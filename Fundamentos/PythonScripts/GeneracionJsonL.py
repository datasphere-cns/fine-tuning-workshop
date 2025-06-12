import pandas as pd
import json
import os
import snowflake.connector # Necesitas instalar esta librería: pip install snowflake-connector-python
import unicodedata # Nueva librería para normalizar caracteres

# --- CONFIGURACIÓN DE SNOWFLAKE ---
SNOWFLAKE_ACCOUNT = "" # Ejemplo: abc12345.east-us-2.azure
SNOWFLAKE_USER = ""
SNOWFLAKE_PASSWORD = ""
SNOWFLAKE_WAREHOUSE = "WH_SMALL"
SNOWFLAKE_DATABASE = "workshop"
SNOWFLAKE_SCHEMA = "bronze_mercadeo"
SNOWFLAKE_ROLE = "ROLE_DEVELOPER"

# Nombre de la tabla a leer
SNOWFLAKE_TABLE_NAME = "tbl_product_data"

# --- CONFIGURACIÓN DE LA SALIDA JSONL ---
output_directory = r"D:\FineTuning" # Usar r"" para raw string y evitar problemas con \
output_jsonl_filename = 'product_descriptions_finetune_normalized_ascii.jsonl' # Nuevo nombre para esta versión
output_jsonl_path = os.path.join(output_directory, output_jsonl_filename)

# Mensaje de sistema AHORA NORMALIZADO: sin tildes ni emojis en el prompt para asegurar consistencia
system_prompt_content = "Eres un escritor de descripciones de productos tecnologicas concisas, amigables y orientadas a beneficios. No uses tildes ni emojis."


# --- PASO 1: LEER LOS DATOS DESDE SNOWFLAKE ---
try:
    print(f"Conectándose a Snowflake para leer la tabla '{SNOWFLAKE_TABLE_NAME}'...")
    conn = snowflake.connector.connect(
        user=SNOWFLAKE_USER,
        password=SNOWFLAKE_PASSWORD,
        account=SNOWFLAKE_ACCOUNT,
        warehouse=SNOWFLAKE_WAREHOUSE,
        database=SNOWFLAKE_DATABASE,
        schema=SNOWFLAKE_SCHEMA,
        role=SNOWFLAKE_ROLE
    )
    cursor = conn.cursor()

    query = f"SELECT name, description FROM {SNOWFLAKE_DATABASE}.{SNOWFLAKE_SCHEMA}.{SNOWFLAKE_TABLE_NAME};"
    
    cursor.execute(query)
    
    df_product_data = cursor.fetch_pandas_all()
    
    print("Datos de productos cargados exitosamente desde Snowflake.")
    
    # --- Limpieza de nombres de columna (por si acaso quedan espacios o están en minúsculas) ---
    df_product_data.columns = df_product_data.columns.str.strip().str.upper()

    print("\nPrimeras 5 filas del DataFrame cargado (antes de la normalización de caracteres):")
    print(df_product_data.head().to_string())

    # --- SOLUCIÓN FINAL Y CORRECTA PARA LAS TILDES Y EMOJIS: NORMALIZAR A ASCII SIN PERDER VOCALES ---
    def normalize_and_remove_non_ascii(text):
        if isinstance(text, str):
            # 1. Normaliza a forma de compatibilidad (NFKD): descompone los caracteres acentuados.
            #    Ej: 'á' se convierte en 'a' + U+0301 (combinando acento).
            # 2. Codifica a 'ascii' ignorando los caracteres que no son ASCII (como los acentos sueltos y emojis).
            # 3. Decodifica de nuevo a una cadena 'utf-8' estándar.
            normalized_text = unicodedata.normalize('NFKD', text)
            return normalized_text.encode('ascii', 'ignore').decode('utf-8')
        return text

    # Aplica la función de corrección a las columnas relevantes
    df_product_data['NAME'] = df_product_data['NAME'].apply(normalize_and_remove_non_ascii)
    df_product_data['DESCRIPTION'] = df_product_data['DESCRIPTION'].apply(normalize_and_remove_non_ascii)

    print("\nPrimeras 5 filas del DataFrame después de la normalización y eliminación de no-ASCII:")
    print(df_product_data.head().to_string())


except Exception as e:
    print(f"Ocurrió un error al conectar o leer desde Snowflake: {e}")
    print("Asegúrate de que tus credenciales y configuración de conexión son correctas, y que tienes los permisos necesarios.")
    print("También verifica que la librería 'snowflake-connector-python' esté instalada y actualizada.")
    exit()
finally:
    if 'conn' in locals() and conn:
        conn.close()
        print("\nConexión a Snowflake cerrada.")

# --- PASO 2: GENERAR EL JSONL PARA FINE-TUNING ---

def create_product_description_message(row):
    messages = [
        {"role": "system", "content": system_prompt_content},
        {"role": "user", "content": f"Genera una descripcion para: {row['NAME']}"},
        {"role": "assistant", "content": row['DESCRIPTION']}
    ]
    return {"messages": messages}

print("\nGenerando el formato JSONL para Fine-tuning...")
openai_data = df_product_data.apply(create_product_description_message, axis=1).tolist()
print(f"Se generaron {len(openai_data)} entradas JSONL.")

# --- PASO 3: GUARDAR EL ARCHIVO JSONL LOCALMENTE ---

try:
    os.makedirs(output_directory, exist_ok=True)
    
    with open(output_jsonl_path, 'w', encoding='utf-8') as f:
        for entry in openai_data:
            json.dump(entry, f, ensure_ascii=False) # Mantenemos ensure_ascii=False para que Python no añada escapes, aunque el contenido ya sea ASCII puro.
            f.write('\n')

    print(f"\n¡Archivo JSONL '{output_jsonl_filename}' guardado exitosamente en: {output_jsonl_path}!")
    print("\nPrimeras 3 entradas del archivo JSONL generado (¡deberían verse las vocales sin tilde y sin emojis!):")
    with open(output_jsonl_path, 'r', encoding='utf-8') as f:
        for i, line in enumerate(f):
            if i >= 3: break
            print(line.strip())

except Exception as e:
    print(f"Ocurrió un error al intentar guardar el archivo JSONL en '{output_jsonl_path}': {e}")
    print("Por favor, verifica que la ruta sea válida y que tengas permisos de escritura en esa ubicación.")
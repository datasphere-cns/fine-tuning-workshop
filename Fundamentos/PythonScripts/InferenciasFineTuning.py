import os
from openai import OpenAI

# --- CONFIGURACIÓN DE TU API KEY Y MODELO AFINADO ---
# ¡IMPORTANTE! Reemplaza con tu API Key real.
# Por seguridad, es mejor usar variables de entorno: os.environ.get("OPENAI_API_KEY")
OPENAI_API_KEY = ""

# Reemplaza con el ID REAL de tu modelo afinado
# Este es el ID que te dio OpenAI cuando el fine-tuning terminó: ft:gpt-3.5-turbo-0125:datasphere:prod-desc-ascii:BhR4XroF
FINE_TUNED_MODEL_ID = "ft:gpt-3.5-turbo-0125:datasphere:prod-desc-ascii:BhR4XroF"

# El mensaje de sistema DEBE SER IDÉNTICO al que usaste en tu JSONL de entrenamiento.
# (Sin tildes, sin emojis, si así lo entrenaste)
SYSTEM_PROMPT_CONTENT = "Eres un escritor de descripciones de productos tecnologicas concisas, amigables y orientadas a beneficios. No uses tildes ni emojis."

# --- INICIALIZACIÓN DEL CLIENTE DE OPENAI ---
client = OpenAI(api_key=OPENAI_API_KEY)

# --- FUNCIÓN PARA GENERAR DESCRIPCIONES ---
def generate_product_description(product_name):
    """
    Genera una descripción de producto usando el modelo afinado.

    Args:
        product_name (str): El nombre del producto para el cual generar la descripción.

    Returns:
        str: La descripción generada por el modelo, o un mensaje de error.
    """
    try:
        response = client.chat.completions.create(
            model=FINE_TUNED_MODEL_ID,
            messages=[
                {"role": "system", "content": SYSTEM_PROMPT_CONTENT},
                {"role": "user", "content": f"Genera una descripcion para: {product_name}"}
            ],
            max_tokens=80,    # Suficientes tokens para una descripción corta
            temperature=0.7,  # Un poco de creatividad (0.0 para menos variacion, 1.0 para mas)
            stop=["\n\n"]     # Opcional: Detener la generación si ve dos saltos de línea consecutivos
        )
        return response.choices[0].message.content.strip()
    except Exception as e:
        return f"Error al generar la descripción: {e}"

# --- EJEMPLOS DE USO ---
if __name__ == "__main__":
    print(f"Usando el modelo afinado: {FINE_TUNED_MODEL_ID}\n")

    products_to_describe = [
        "Monitor Gaming Curvo Quantum",
        "Router Wi-Fi Mesh Evo",
        "Microfono Condensador Profesional Air",
        "Nueva Camara Seguridad Inteligente Guardian X"
    ]

    for i, product in enumerate(products_to_describe):
        print(f"Producto {i+1}: {product}")
        description = generate_product_description(product)
        print(f"  Descripcion Generada: {description}\n")

    # Puedes también pedir descripciones interactivamente
    # while True:
    #     user_input = input("Introduce el nombre de un producto (o 'salir' para terminar): ")
    #     if user_input.lower() == 'salir':
    #         break
    #     description = generate_product_description(user_input)
    #     print(f"  Descripcion Generada: {description}\n")
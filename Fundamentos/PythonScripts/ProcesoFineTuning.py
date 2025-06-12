import os
import time
from openai import OpenAI

# --- CONFIGURACIÓN DE TU API KEY Y ARCHIVO ---
# ¡ADVERTENCIA DE SEGURIDAD! No es recomendable guardar tu API Key directamente en el código fuente.
# Para entornos de producción, considera usar variables de entorno (os.environ.get("OPENAI_API_KEY"))
# o un gestor de secretos.
OPENAI_API_KEY = ""

# Ruta completa a tu archivo JSONL generado.
# Asegúrate de que esta ruta sea correcta en tu sistema.
training_file_path = r"D:\FineTuning\product_descriptions_finetune_ascii_only.jsonl"

# Si dividiste tus datos en entrenamiento y validación (¡muy recomendado!),
# puedes especificar la ruta del archivo de validación aquí.
# Si no lo hiciste, deja validation_file_path en None o coméntalo.
validation_file_path = None # Por ejemplo: r"D:\FineTuning\product_descriptions_validation_ascii_only.jsonl"


# Modelo base para el fine-tuning
# gpt-3.5-turbo-0125 es una versión estable de gpt-3.5-turbo.
# También podrías usar "gpt-4o-mini-2024-07-18" si está disponible y prefieres ese modelo.
BASE_MODEL = "gpt-3.5-turbo-0125"

# --- INICIALIZACIÓN DEL CLIENTE DE OPENAI ---
client = OpenAI(api_key=OPENAI_API_KEY)

# --- PASO 1: SUBIR EL ARCHIVO DE ENTRENAMIENTO ---
print(f"1. Subiendo el archivo de entrenamiento: {training_file_path} a OpenAI...")
try:
    with open(training_file_path, "rb") as file:
        training_file_obj = client.files.create(
            file=file,
            purpose="fine-tune"
        )
    print(f"   Archivo de entrenamiento subido. ID: {training_file_obj.id}")
except FileNotFoundError:
    print(f"Error: El archivo de entrenamiento no se encontró en '{training_file_path}'. Verifica la ruta.")
    exit()
except Exception as e:
    print(f"Error al subir el archivo de entrenamiento: {e}")
    exit()

# --- PASO 2: SUBIR EL ARCHIVO DE VALIDACIÓN (SI EXISTE) ---
validation_file_id = None
if validation_file_path:
    print(f"2. Subiendo el archivo de validación: {validation_file_path} a OpenAI...")
    try:
        with open(validation_file_path, "rb") as file:
            validation_file_obj = client.files.create(
                file=file,
                purpose="fine-tune"
            )
        validation_file_id = validation_file_obj.id
        print(f"   Archivo de validación subido. ID: {validation_file_id}")
    except FileNotFoundError:
        print(f"Advertencia: El archivo de validación no se encontró en '{validation_file_path}'. El fine-tuning continuará sin validación explícita.")
    except Exception as e:
        print(f"Advertencia al subir el archivo de validación: {e}. El fine-tuning continuará sin validación explícita.")

# --- PASO 3: CREAR EL TRABAJO DE FINE-TUNING ---
print(f"3. Creando el trabajo de fine-tuning con el modelo base: {BASE_MODEL}...")
try:
    fine_tuning_params = {
        "training_file": training_file_obj.id,
        "model": BASE_MODEL,
        "suffix": "prod-desc-ascii" # Sufijo para identificar tu modelo afinado
    }
    if validation_file_id:
        fine_tuning_params["validation_file"] = validation_file_id

    fine_tuning_job = client.fine_tuning.jobs.create(**fine_tuning_params)

    print(f"   Trabajo de fine-tuning iniciado. ID del trabajo: {fine_tuning_job.id}")
    print(f"   Estado inicial: {fine_tuning_job.status}")
except Exception as e:
    print(f"Error al crear el trabajo de fine-tuning: {e}")
    exit()

# --- PASO 4: MONITOREAR EL PROGRESO DEL FINE-TUNING ---
print("\n4. Monitoreando el progreso del fine-tuning (esto puede tardar varios minutos u horas)...")
print("   (Puedes cerrar este script; el trabajo continuará en los servidores de OpenAI.)")
print("   (Para verificar el estado más tarde, puedes usar el ID del trabajo: " + fine_tuning_job.id + ")")

job_id = fine_tuning_job.id
fine_tuned_model_id = None

while True:
    try:
        job_status_response = client.fine_tuning.jobs.retrieve(job_id)
        current_status = job_status_response.status
        # --- CAMBIO AQUÍ: Eliminamos la referencia a 'updated_at' ---
        print(f"   Estado actual: {current_status}")

        if current_status in ["succeeded", "failed", "cancelled"]:
            break # El trabajo ha terminado

        time.sleep(60) # Espera 60 segundos antes de volver a verificar

    except Exception as e:
        print(f"Error al monitorear el trabajo de fine-tuning: {e}")
        # Si ocurre un error, puedes considerar cerrar la conexión o salir después de varios intentos fallidos
        break

# --- PASO 5: OBTENER EL ID DEL MODELO AFINADO ---
if current_status == "succeeded":
    fine_tuned_model_id = job_status_response.fine_tuned_model
    print(f"\n¡Fine-tuning completado con éxito!")
    print(f"   ID de tu nuevo modelo afinado: {fine_tuned_model_id}")
    print("\nAhora puedes usar este ID para hacer inferencias con tu modelo personalizado.")
elif current_status == "failed":
    print(f"\nEl trabajo de fine-tuning falló.")
    if job_status_response.error:
        print(f"   Detalles del error: {job_status_response.error.message}")
elif current_status == "cancelled":
    print("\nEl trabajo de fine-tuning fue cancelado.")
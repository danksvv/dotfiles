#!/bin/bash
# ------------------------------------------------------------
# Script: smart_rename.sh
# Función: Renombrar y organizar archivos por tipo, fecha o nombre base.
# Autor: Danks (versión extendida y explicada)
# ------------------------------------------------------------
#
# 🔧 USO:
#   ./smart_rename.sh <directorio> <modo> <extension> [base_name]
#
# 📘 MODOS DISPONIBLES:
#   name → Renombra con base_name + contador
#   date → Renombra con fecha/hora del archivo
#   type → Organiza en carpetas por extensión
#   full → Organiza por tipo y renombra con fecha
#
# 🧩 Ejemplos:
#   ./smart_rename.sh ~/Descargas name jpg imagen
#   ./smart_rename.sh ~/Fotos full png foto
#   ./smart_rename.sh . date pdf documento
# ------------------------------------------------------------

# --- Validación de argumentos ---
if [ "$#" -lt 3 ]; then
  echo "❌ Uso incorrecto."
  echo "Sintaxis: $0 <directorio> <modo> <extension> [base_name]"
  echo "Modos disponibles: name, date, type, full"
  exit 1
fi

DIR="$1"
MODE="$2"
EXTENSION="$(echo "$3" | tr '[:upper:]' '[:lower:]')"
BASE_NAME="${4:-file}" # Valor por defecto si no se pasa base_name

# --- Verificación del directorio ---
if [ ! -d "$DIR" ]; then
  echo "❌ Error: '$DIR' no es un directorio válido."
  exit 1
fi

cd "$DIR" || exit 1

echo "------------------------------------------------------------"
echo "📂 Directorio de trabajo: $DIR"
echo "⚙️  Modo: $MODE"
echo "🧩 Extensión: .$EXTENSION"
echo "🏷️  Nombre base: $BASE_NAME"
echo "------------------------------------------------------------"
sleep 1

counter=1
found_files=0

# --- Explicación general ---
echo "🔍 Buscando archivos *.$EXTENSION ..."
sleep 1

# --- Bucle principal ---
for file in *."$EXTENSION"; do
  [ -f "$file" ] || continue
  found_files=1
  new_name=""

  echo "----------------------------------------"
  echo "📄 Procesando: $file"

  case "$MODE" in
  name)
    new_name=$(printf "%s_%03d.%s" "$BASE_NAME" "$counter" "$EXTENSION")
    echo "   🔧 Nuevo nombre → $new_name"
    mv "$file" "$new_name"
    ;;
  date)
    timestamp=$(date -r "$file" +"%Y%m%d_%H%M%S")
    new_name="${BASE_NAME}_${timestamp}.${EXTENSION}"
    echo "   📅 Renombrando por fecha → $new_name"
    mv "$file" "$new_name"
    ;;
  type)
    mkdir -p "$EXTENSION"
    echo "   📂 Moviendo a carpeta → $EXTENSION/"
    mv "$file" "$EXTENSION/$file"
    ;;
  full)
    mkdir -p "$EXTENSION"
    timestamp=$(date -r "$file" +"%Y%m%d_%H%M%S")
    new_name="${BASE_NAME}_${timestamp}.${EXTENSION}"
    echo "   📂 Moviendo a carpeta → $EXTENSION/"
    echo "   📅 Renombrando → $new_name"
    mv "$file" "$EXTENSION/$new_name"
    ;;
  *)
    echo "❌ Modo inválido: $MODE"
    exit 1
    ;;
  esac

  ((counter++))
done

# --- Resultados ---
if [ $found_files -eq 0 ]; then
  echo "⚠️  No se encontraron archivos *.$EXTENSION en '$DIR'."
else
  echo "------------------------------------------------------------"
  echo "✅ Proceso completado."
  echo "   Archivos *.$EXTENSION procesados en modo '$MODE'."
  echo "------------------------------------------------------------"
fi

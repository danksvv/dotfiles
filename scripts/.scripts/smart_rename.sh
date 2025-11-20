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

# --- Función de Ayuda ---
help_message() {
  echo "------------------------------------------------------------"
  echo "🚀 smart_rename.sh - Herramienta inteligente de renombrado y organización"
  echo "------------------------------------------------------------"
  echo "💡 Sintaxis: $0 <directorio> <modo> <extension> [base_name]"
  echo ""
  echo "🔹 Argumentos:"
  echo "   <directorio> : Ruta del directorio donde se buscarán los archivos."
  echo "   <modo>       : Define la acción a realizar. Ver 'MODOS DISPONIBLES'."
  echo "   <extension>  : Extensión de los archivos a procesar (ej: jpg, pdf, txt)."
  echo "   [base_name]  : (Opcional) Nombre base para el renombrado. Por defecto: 'file'."
  echo ""
  echo "📘 MODOS DISPONIBLES (Argumento 2):"
  echo "   name:    Renombra los archivos como \`base_name_001.ext\`, \`base_name_002.ext\`, etc."
  echo "   date:    Renombra usando la marca de tiempo del archivo: \`base_name_YYYYMMDD_HHMMSS.ext\`."
  echo "   type:    Organiza, moviendo los archivos a una subcarpeta con el nombre de la extensión (ej: \`./jpg/\`)."
  echo "   full:    Combina 'type' y 'date'. Mueve a una carpeta por tipo y renombra por fecha."
  echo ""
  echo "🧩 EJEMPLOS PRÁCTICOS:"
  echo "1. **Renombrar por contador (nombre)**:"
  echo "   $0 ./temp **name** jpg **imagen**"
  echo "   (Renombra \`a.jpg\` a \`imagen_001.jpg\` en el directorio \`./temp/\`)."
  echo ""
  echo "2. **Renombrar por fecha (date)**:"
  echo "   $0 ~/Descargas **date** pdf **documento**"
  echo "   (Renombra a \`documento_20251120_193000.pdf\`)."
  echo ""
  echo "3. **Organizar solo por extensión (type)**:"
  echo "   $0 . **type** png"
  echo "   (Mueve todos los \`.png\` a la carpeta \`./png/\`)."
  echo ""
  echo "4. **Organizar y Renombrar (full)**:"
  echo "   $0 ~/Fotos **full** arw **raw_photo**"
  echo "   (Mueve a \`~/Fotos/arw/\` y renombra por fecha)."
  echo "------------------------------------------------------------"
  exit 0
}

# --- Validación de argumentos ---

# 🛑 NUEVO: Comprobar el flag --help
if [[ "$1" == "--help" ]]; then
  help_message
fi

# Si no hay 3 argumentos mínimos, mostrar error y la sintaxis básica
if [ "$#" -lt 3 ]; then
  echo "❌ Uso incorrecto."
  echo "Sintaxis: $0 <directorio> <modo> <extension> [base_name]"
  echo "Ejecute '$0 --help' para ver la documentación completa."
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
  # 💡 Mejora: Uso de nullglob para evitar procesar el patrón literal si no hay archivos
  # Requires `shopt -s nullglob` at the top of the script for strict compliance,
  # but this check is common and safer if nullglob isn't set.
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
    # 💡 Mejora: Uso de stat para obtener la fecha de modificación más rápido y portable si es posible.
    # Pero el comando `date -r` ya es funcional y mantenemos el código original.
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
    echo "Ejecute '$0 --help' para ver los modos disponibles."
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

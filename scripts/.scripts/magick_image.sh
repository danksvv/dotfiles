#!/bin/bash
# ------------------------------------------------------------
# Script: magick_image.sh
# Función: Convertir imágenes masivamente y (opcionalmente) borrar originales.
# Dependencia: Requiere 'imagemagick' instalado (comando: magick)
# ------------------------------------------------------------
#
# 🔧 USO:
#   ./magick_image.sh <directorio> <ext_origen> <ext_destino>
# ------------------------------------------------------------

# --- Función de Ayuda ---
help_message() {
  echo "------------------------------------------------------------"
  echo "🎨 magick_image.sh - Conversor de Imágenes con Limpieza"
  echo "------------------------------------------------------------"
  echo "💡 Sintaxis: $0 <directorio> <ext_origen> <ext_destino>"
  echo ""
  echo "🔹 Ejemplo:"
  echo "   $0 . jpg png"
  echo ""
  echo "✨ Características:"
  echo "   1. Convierte formato A -> formato B."
  echo "   2. Al finalizar, pregunta si deseas borrar los originales."
  echo "   3. SOLO borra el original si la conversión fue exitosa."
  echo "------------------------------------------------------------"
  exit 0
}

# --- Verificación de Dependencias ---
if ! command -v magick &>/dev/null; then
  echo "❌ Error: No se encuentra 'magick'. Instala ImageMagick."
  exit 1
fi

# --- Validación ---
if [[ "$1" == "--help" ]] || [ "$#" -lt 3 ]; then
  help_message
fi

DIR="$1"
SRC_EXT="$(echo "$2" | tr '[:upper:]' '[:lower:]')"
DEST_EXT="$(echo "$3" | tr '[:upper:]' '[:lower:]')"

if [ ! -d "$DIR" ]; then
  echo "❌ Error: '$DIR' no es un directorio válido."
  exit 1
fi

cd "$DIR" || exit 1

echo "------------------------------------------------------------"
echo "📂 Directorio: $DIR"
echo "🔄 Conversión: *.$SRC_EXT  ➡️  *.$DEST_EXT"
echo "------------------------------------------------------------"
sleep 1

# Array para guardar los archivos que se convirtieron BIEN
declare -a success_files

shopt -s nullglob

# --- Bucle de conversión ---
for file in *."$SRC_EXT"; do
  base_name="${file%.*}"
  output_file="${base_name}.${DEST_EXT}"

  echo "🔨 Procesando: $file ..."
  magick "$file" "$output_file"

  # Verificación
  if [ -f "$output_file" ]; then
    echo "   ✅ Generado: $output_file"
    # Añadimos el archivo original a la lista de éxitos
    success_files+=("$file")
  else
    echo "   ❌ Error al generar $output_file"
  fi
done

# --- Resumen y Limpieza ---
total_converted=${#success_files[@]}

if [ $total_converted -eq 0 ]; then
  echo "⚠️  No se convirtieron archivos. No hay nada que borrar."
  exit 0
fi

echo "------------------------------------------------------------"
echo "🎉 Conversión terminada: $total_converted imágenes creadas."
echo "------------------------------------------------------------"

# --- Pregunta de borrado ---
echo -n "🗑️  ¿Deseas borrar los $total_converted archivos ORIGINALES (*.$SRC_EXT)? [s/N]: "
read -r response

if [[ "$response" =~ ^[sS]$ ]]; then
  echo "🧹 Borrando originales..."
  for del_file in "${success_files[@]}"; do
    rm "$del_file"
    echo "   🔥 Borrado: $del_file"
  done
  echo "✨ ¡Limpieza completada!"
else
  echo "🛡️  Archivos originales conservados."
fi

#!/bin/bash

# --- 1. Revisar si ExifTool está instalado ---
if ! command -v exiftool &>/dev/null; then
  echo "Error: 'exiftool' no está instalado."
  echo "Por favor, instálalo para leer la fecha de las fotos:"
  echo "brew install exiftool"
  exit 1
fi

# --- 2. Función de Ayuda ---
show_usage() {
  echo
  echo "Uso: $0 <directorio> <extension>"
  echo
  echo "Renombra TODOS los ficheros basándose en la mejor fecha disponible."
  echo "Utiliza un sistema de 'fallback' (plan de respaldo):"
  echo "  1. Intenta la Fecha de Toma (DateTimeOriginal)."
  echo "  2. Si falla, intenta la Fecha de Creación (CreateDate)."
  echo "  3. Si falla, usa la Fecha de Modificación del Fichero."
  echo
  echo "Formato final: YYYY.MM.DD_HHMMSS.ext"
  echo
}

# --- 3. Revisión de Argumentos ---
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  show_usage
  exit 0
fi

if [ "$#" -lt 2 ]; then
  show_usage
  exit 1
fi

DIR="$1"
EXT="$2"

if [ ! -d "$DIR" ]; then
  echo "Error: '$DIR' no es un directorio válido."
  exit 1
fi

# --- 4. Plan de Ejecución y Confirmación ---
echo "--- 🔍 Plan de Renombrado (Definitivo) ---"
echo "Directorio:   $DIR"
echo "Extensión:    .$EXT"
echo "Formato:      YYYY.MM.DD_HHMMSS.ext"
echo "Prioridad:    Fecha de Toma > Fecha Creación > Fecha Fichero"
echo "------------------------------------------------"

file_count=$(find "$DIR" -maxdepth 1 -type f -name "*.$EXT" | wc -l | tr -d ' ')

if [ "$file_count" -eq 0 ]; then
  echo "Estado: No se encontraron ficheros *.$EXT en el directorio."
  exit 0
fi

echo "¡Atención! Se intentará renombrar $file_count ficheros."
echo
read -p "¿Estás seguro de que quieres continuar? (s/N) " confirm

if [[ "$confirm" != "s" && "$confirm" != "S" ]]; then
  echo "Operación cancelada."
  exit 0
fi

# --- 5. Ejecución (El comando con Fallbacks) ---
echo
echo "Procesando con ExifTool (con fallbacks)..."

# Explicación del comando:
# 1. '-FileName<DateTimeOriginal' : Intenta esto primero.
# 2. '-FileName<CreateDate' : Si lo primero falla, intenta esto.
# 3. '-FileName<FileModifyDate' : Si todo lo demás falla, usa la fecha del sistema.
# ExifTool es lo suficientemente inteligente como para probarlos en orden.
exiftool -d '%Y.%m.%d_%H%M%S.%%e' \
  '-FileName<DateTimeOriginal' \
  '-FileName<CreateDate' \
  '-FileName<FileModifyDate' \
  -ext "$EXT" -v "$DIR"

echo
echo "¡Renombrado por fecha completado!"

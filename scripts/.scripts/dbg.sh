#!/bin/bash

# =================================================================
# Script Mejorado para Depuración Dinámica con Chrome Auto-Launch
# Uso: ./debug_app_mejorado.sh /ruta/al/fichero.js
# =================================================================

# --- CONFIGURACIÓN ---
# Puerto por defecto de Node.js Inspector
DEBUG_PORT=9229
CHROME_INSPECT_URL="chrome://inspect"

# 1. Validación de Argumentos
if [ -z "$1" ]; then
  echo "❌ ERROR: Debes proporcionar la ruta al archivo JavaScript."
  echo "Uso: $0 /ruta/absoluta/o/relativa/al/fichero.js"
  exit 1
fi

APP_FILE="$1"

if [ ! -f "$APP_FILE" ]; then
  echo "❌ ERROR: El archivo '$APP_FILE' no existe."
  exit 1
fi

# --- FASE 1: INICIO DEL SERVIDOR ---

echo "=========================================================="
echo "      🚀 INICIANDO DEBUGGER DE NODE.JS                   "
echo "=========================================================="

# 1. Ejecuta el archivo en modo Inspector y en segundo plano (&)
# --inspect-brk: Pausa la ejecución en la primera línea para que puedas conectar el depurador.
# --trace-warnings: Muestra más información de warnings/errores.
node --inspect-brk="$DEBUG_PORT" "$APP_FILE" &

# Guarda el ID del proceso de Node.js
NODE_PID=$!

# 2. Muestra información de conexión (más detallada)
echo "✅ SERVIDOR NODE INICIADO."
echo "   PID del proceso: $NODE_PID"
echo "   Archivo depurando: $APP_FILE"
echo "   Puerto de conexión (WS): $DEBUG_PORT"

echo "----------------------------------------------------------"
echo "  🌐 ABRIENDO GOOGLE CHROME..."
echo "----------------------------------------------------------"

# 3. Abre Chrome automáticamente en la página de inspección (macOS/Linux)
# (La ventana de DevTools se abrirá automáticamente después de 1-2 segundos)
open -a "Google Chrome" "$CHROME_INSPECT_URL" &

# 4. Instrucciones para el usuario
echo "Por favor, espera unos segundos. La ventana de Chrome DevTools"
echo "debería aparecer automáticamente y pausada en la primera línea."
echo ""
echo "   Presiona [Enter] cuando termines la sesión de depuración."

# --- FASE 2: CIERRE ---

# Espera la entrada del usuario
read -r

# Termina el proceso de Node.js en segundo plano
kill "$NODE_PID"

echo "=========================================================="
echo "✅ Sesión de depuración terminada. Proceso $NODE_PID finalizado."
echo "=========================================================="

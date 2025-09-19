#!/bin/bash

echo "⚡ Ejecución rápida de FIBONACCI-APP..."

# Configuración
SIMULATOR_NAME="iPad Pro 13-inch (M4)"
BUNDLE_ID="panacea-icono.FIBONACCI-APP"

# Iniciar simulador
echo "📱 Iniciando simulador..."
xcrun simctl boot "$SIMULATOR_NAME" 2>/dev/null || echo "Simulador ya está ejecutándose"

# Esperar un momento
sleep 3

# Instalar y ejecutar
echo "🚀 Instalando y ejecutando FIBONACCI-APP..."
xcrun simctl install "$SIMULATOR_NAME" "/Users/nuevousuario/Library/Developer/Xcode/DerivedData/FIBONACCI-APP-cfdwbofdzztoqlgngdlbhwvqtmsh/Build/Products/Debug-iphonesimulator/FIBONACCI-APP.app" && \
xcrun simctl launch "$SIMULATOR_NAME" "$BUNDLE_ID"

echo "✨ ¡Listo! FIBONACCI-APP ejecutándose en el simulador"

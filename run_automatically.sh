#!/bin/bash

echo "🚀 Iniciando proceso automático de FIBONACCI-APP..."

# Configuración del simulador
SIMULATOR_NAME="iPad Pro 13-inch (M4)"
BUNDLE_ID="panacea-icono.FIBONACCI-APP"

echo "📱 Configurando simulador $SIMULATOR_NAME..."

# Iniciar simulador si está apagado
echo "🔄 Iniciando simulador..."
xcrun simctl boot "$SIMULATOR_NAME" 2>/dev/null || echo "Simulador ya está ejecutándose"

# Esperar a que el simulador esté listo
echo "⏳ Esperando a que el simulador esté listo..."
sleep 5

# Compilar la app
echo "🔨 Compilando FIBONACCI-APP..."
xcodebuild -project FIBONACCI-APP.xcodeproj -scheme FIBONACCI-APP -destination "platform=iOS Simulator,name=$SIMULATOR_NAME" build

if [ $? -eq 0 ]; then
    echo "✅ Compilación exitosa!"
    
    # Instalar la app
    echo "📦 Instalando app en el simulador..."
    xcrun simctl install "$SIMULATOR_NAME" "/Users/nuevousuario/Library/Developer/Xcode/DerivedData/FIBONACCI-APP-cfdwbofdzztoqlgngdlbhwvqtmsh/Build/Products/Debug-iphonesimulator/FIBONACCI-APP.app"
    
    if [ $? -eq 0 ]; then
        echo "✅ Instalación exitosa!"
        
        # Ejecutar la app
        echo "🎬 Ejecutando FIBONACCI-APP..."
        xcrun simctl launch "$SIMULATOR_NAME" "$BUNDLE_ID"
        
        if [ $? -eq 0 ]; then
            echo "🎉 ¡FIBONACCI-APP ejecutándose exitosamente!"
            echo "📱 Simulador: $SIMULATOR_NAME"
            echo "🏥 App: FIBONACCI-APP con logo médico y video de fondo"
        else
            echo "❌ Error al ejecutar la app"
        fi
    else
        echo "❌ Error al instalar la app"
    fi
else
    echo "❌ Error en la compilación"
fi

echo "✨ Proceso completado!"

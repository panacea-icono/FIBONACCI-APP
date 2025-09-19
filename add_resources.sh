#!/bin/bash

# Script para agregar recursos multimedia al proyecto Xcode
echo "Agregando recursos multimedia al proyecto FIBONACCI-APP..."

# Crear directorio Resources en el proyecto si no existe
mkdir -p FIBONACCI-APP/Resources

# Copiar imágenes de médicos
echo "Copiando imágenes de médicos..."
cp -r FIBONACCI-APP/Resources/Images/Doctors/* FIBONACCI-APP/Resources/ 2>/dev/null || echo "Algunas imágenes ya existen"

# Copiar videos de animaciones
echo "Copiando videos de animaciones..."
cp -r FIBONACCI-APP/Resources/Videos/Animations/* FIBONACCI-APP/Resources/ 2>/dev/null || echo "Algunos videos ya existen"

# Copiar imágenes de Fibonacci
echo "Copiando imágenes de Fibonacci..."
cp -r FIBONACCI-APP/Resources/Images/Fibonacci/* FIBONACCI-APP/Resources/ 2>/dev/null || echo "Algunas imágenes ya existen"

echo "Recursos copiados exitosamente!"
echo "Ahora necesitas agregar estos archivos manualmente al proyecto en Xcode:"
echo "1. Abre FIBONACCI-APP.xcodeproj en Xcode"
echo "2. Haz clic derecho en el proyecto"
echo "3. Selecciona 'Add Files to FIBONACCI-APP'"
echo "4. Selecciona la carpeta Resources"
echo "5. Asegúrate de que 'Add to target' esté marcado para FIBONACCI-APP"

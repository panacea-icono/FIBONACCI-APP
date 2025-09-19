#!/bin/bash

echo "Simplificando nombres de archivos multimedia..."

# Crear directorio de recursos simplificados
mkdir -p FIBONACCI-APP/Resources/Simplified

# Copiar y renombrar imágenes de médicos
echo "Copiando imágenes de médicos..."
cp "FIBONACCI-APP/Resources/Images/Doctors/20250905_0400_Doctor Carismático en Bata_simple_compose_01k4ce8032f4b8kph8p0nbjjye.png" "FIBONACCI-APP/Resources/Simplified/Doctor1.png" 2>/dev/null
cp "FIBONACCI-APP/Resources/Images/Doctors/20250905_0401_Mujer Médica Carismática_simple_compose_01k4ce6nscew4ry3h8nzn14058.png" "FIBONACCI-APP/Resources/Simplified/Doctor2.png" 2>/dev/null
cp "FIBONACCI-APP/Resources/Images/Doctors/20250905_0401_Médica Carismática de 28_simple_compose_01k4ce9vnfe9rav02xv6ezc0ns.png" "FIBONACCI-APP/Resources/Simplified/Doctor3.png" 2>/dev/null
cp "FIBONACCI-APP/Resources/Images/Doctors/20250916_0450_Estatua Médica Perfecta_simple_compose_01k58vd92we1cv6tsd1yfb2z84.png" "FIBONACCI-APP/Resources/Simplified/Doctor4.png" 2>/dev/null

# Copiar videos
echo "Copiando videos..."
cp "FIBONACCI-APP/Resources/Videos/Animations/20250911_0827_Warm Autumn Flow_simple_compose_01k4wbwycpfz2vs6fe66erpeme.mp4" "FIBONACCI-APP/Resources/Simplified/BackgroundVideo.mp4" 2>/dev/null

echo "Archivos simplificados creados en FIBONACCI-APP/Resources/Simplified/"
ls -la FIBONACCI-APP/Resources/Simplified/

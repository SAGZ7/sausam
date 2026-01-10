#!/bin/bash

# SAUSAM - Script de Instalación Automática
# Este script configura todo el proyecto automáticamente

# Colores
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

echo -e "${CYAN}================================================${NC}"
echo -e "${CYAN}  SAUSAM - Sistema de Administración de Usuarios${NC}"
echo -e "${CYAN}================================================${NC}"
echo ""

# Paso 1: Build
echo -e "${YELLOW}[1/5] Construyendo imágenes de Docker...${NC}"
echo -e "${GRAY}Esto puede tardar 10-15 minutos la primera vez.${NC}"
docker compose build
if [ $? -ne 0 ]; then
    echo -e "${RED}Error en el build. Abortando.${NC}"
    exit 1
fi
echo -e "${GREEN}Build completado!${NC}"
echo ""

# Paso 2: Up
echo -e "${YELLOW}[2/5] Levantando contenedores...${NC}"
docker compose up -d
echo -e "${GREEN}Contenedores iniciados!${NC}"
echo ""

# Paso 3: Esperar a que backend esté listo
echo -e "${YELLOW}[3/5] Esperando a que el backend esté listo...${NC}"
echo -e "${GRAY}Esto puede tardar hasta 60 segundos...${NC}"

timeout=60
elapsed=0
ready=false

while [ $elapsed -lt $timeout ] && [ "$ready" = false ]; do
    sleep 3
    elapsed=$((elapsed + 3))
    
    if docker compose logs backend 2>&1 | grep -q "Server running"; then
        ready=true
        echo -e "${GREEN}Backend listo!${NC}"
    else
        echo -e "${GRAY}Esperando... ($elapsed segundos)${NC}"
    fi
done

if [ "$ready" = false ]; then
    echo -e "${YELLOW}Timeout alcanzado. Continuando de todas formas...${NC}"
fi
echo ""

# Paso 4: Configurar
echo -e "${YELLOW}[4/5] Configurando backend...${NC}"

echo -e "${GRAY}  - Copiando archivo de configuración...${NC}"
docker exec sausam_backend cp .env.example .env

echo -e "${GRAY}  - Generando clave de aplicación...${NC}"
docker exec sausam_backend php artisan key:generate

echo -e "${GRAY}  - Ejecutando migraciones...${NC}"
docker exec sausam_backend php artisan migrate --force

echo -e "${GRAY}  - Creando usuarios de prueba...${NC}"
docker exec sausam_backend php artisan db:seed --class=UserSeeder --force

echo -e "${GREEN}Configuración completada!${NC}"
echo ""

# Paso 5: Verificar
echo -e "${YELLOW}[5/5] Verificando instalación...${NC}"
user_count=$(docker exec sausam_db psql -U sausam_user -d sausam -t -c "SELECT COUNT(*) FROM users;" 2>/dev/null | tr -d ' ')
if [ ! -z "$user_count" ] && [ "$user_count" -gt 0 ] 2>/dev/null; then
    echo -e "${GREEN}Usuarios creados: $user_count${NC}"
else
    echo -e "${GRAY}No se pudo verificar usuarios (esto es normal)${NC}"
fi
echo ""

# Resumen
echo -e "${CYAN}================================================${NC}"
echo -e "${GREEN}  INSTALACIÓN COMPLETADA${NC}"
echo -e "${CYAN}================================================${NC}"
echo ""
echo -e "${NC}Servicios disponibles:${NC}"
echo -e "${CYAN}  - Frontend: http://localhost:5173${NC}"
echo -e "${CYAN}  - Backend:  http://localhost:8000${NC}"
echo ""
echo -e "${NC}Usuarios de prueba:${NC}"
echo -e "${YELLOW}  Admin:   admin@sausam.com / password${NC}"
echo -e "${YELLOW}  Usuario: user@sausam.com / password${NC}"
echo ""
echo -e "${GRAY}Abriendo aplicación en el navegador...${NC}"
sleep 2

# Abrir navegador según el sistema operativo
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    open http://localhost:5173
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    if command -v xdg-open > /dev/null; then
        xdg-open http://localhost:5173
    elif command -v gnome-open > /dev/null; then
        gnome-open http://localhost:5173
    fi
fi

echo ""
echo -e "${GRAY}Presiona Enter para salir...${NC}"
read
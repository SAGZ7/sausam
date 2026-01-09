# SAUSAM - Script de Instalación
Write-Host " Instalando SAUSAM..." -ForegroundColor Cyan
Write-Host ""

# Backend: Instalar dependencias con Composer via Docker
Write-Host " Instalando dependencias de Laravel..." -ForegroundColor Yellow
docker run --rm `
    -v "${PWD}/backend:/app" `
    -w /app `
    composer:latest `
    composer install --ignore-platform-reqs

Write-Host " Dependencias de Laravel instaladas" -ForegroundColor Green

# Instalar Sanctum
Write-Host " Instalando Laravel Sanctum..." -ForegroundColor Yellow
docker run --rm `
    -v "${PWD}/backend:/app" `
    -w /app `
    composer:latest `
    composer require laravel/sanctum --ignore-platform-reqs

Write-Host " Sanctum instalado" -ForegroundColor Green

# Instalar Laravel Excel
Write-Host " Instalando Laravel Excel..." -ForegroundColor Yellow
docker run --rm `
    -v "${PWD}/backend:/app" `
    -w /app `
    composer:latest `
    composer require maatwebsite/excel --ignore-platform-reqs

Write-Host " Laravel Excel instalado" -ForegroundColor Green

# Frontend: Instalar dependencias
Write-Host " Instalando dependencias de Vue..." -ForegroundColor Yellow
cd frontend
npm install
cd ..

Write-Host " Dependencias de Vue instaladas" -ForegroundColor Green
Write-Host ""
Write-Host " Instalación completada!" -ForegroundColor Green
Write-Host ""
Write-Host "Siguiente paso: docker-compose up -d" -ForegroundColor Cyan

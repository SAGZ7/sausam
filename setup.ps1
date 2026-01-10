# SAUSAM - Script de Instalación Automática
# Este script configura todo el proyecto automáticamente

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  SAUSAM - Sistema de Administración de Usuarios" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Paso 1: Build
Write-Host "[1/5] Construyendo imágenes de Docker..." -ForegroundColor Yellow
Write-Host "Esto puede tardar 10-15 minutos la primera vez." -ForegroundColor Gray
docker-compose build
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error en el build. Abortando." -ForegroundColor Red
    exit 1
}
Write-Host "Build completado!" -ForegroundColor Green
Write-Host ""

# Paso 2: Up
Write-Host "[2/5] Levantando contenedores..." -ForegroundColor Yellow
docker-compose up -d
Write-Host "Contenedores iniciados!" -ForegroundColor Green
Write-Host ""

# Paso 3: Esperar a que backend esté listo
Write-Host "[3/5] Esperando a que el backend esté listo..." -ForegroundColor Yellow
Write-Host "Esto puede tardar hasta 60 segundos..." -ForegroundColor Gray

$timeout = 60
$elapsed = 0
$ready = $false

while ($elapsed -lt $timeout -and -not $ready) {
    Start-Sleep -Seconds 3
    $elapsed += 3

    $logs = docker-compose logs backend 2>&1 | Select-String "Server running"
    if ($logs) {
        $ready = $true
        Write-Host "Backend listo!" -ForegroundColor Green
    } else {
        Write-Host "Esperando... ($elapsed segundos)" -ForegroundColor Gray
    }
}

if (-not $ready) {
    Write-Host "Timeout alcanzado. Continuando de todas formas..." -ForegroundColor Yellow
}
Write-Host ""

# Paso 4: Configurar
Write-Host "[4/5] Configurando backend..." -ForegroundColor Yellow

Write-Host "  - Copiando archivo de configuración..." -ForegroundColor Gray
docker exec sausam_backend cp .env.example .env

Write-Host "  - Generando clave de aplicación..." -ForegroundColor Gray
docker exec sausam_backend php artisan key:generate

Write-Host "  - Ejecutando migraciones..." -ForegroundColor Gray
docker exec sausam_backend php artisan migrate --force

Write-Host "  - Creando usuarios de prueba..." -ForegroundColor Gray
docker exec sausam_backend php artisan db:seed --class=UserSeeder --force

Write-Host "Configuración completada!" -ForegroundColor Green
Write-Host ""

# Paso 5: Verificar
Write-Host "[5/5] Verificando instalación..." -ForegroundColor Yellow
try {
    $userCount = docker exec sausam_db psql -U sausam_user -d sausam -t -c "SELECT COUNT(*) FROM users;" 2>$null
    if ($userCount -and $userCount.Trim() -match "^\d+$") {
        $count = [int]$userCount.Trim()
        Write-Host "Usuarios creados: $count" -ForegroundColor Green
    }
} catch {
    Write-Host "No se pudo verificar usuarios (esto es normal)" -ForegroundColor Gray
}
Write-Host ""

# Resumen
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  INSTALACIÓN COMPLETADA" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Servicios disponibles:" -ForegroundColor White
Write-Host "  - Frontend: http://localhost:5173" -ForegroundColor Cyan
Write-Host "  - Backend:  http://localhost:8000" -ForegroundColor Cyan
Write-Host ""
Write-Host "Usuarios de prueba:" -ForegroundColor White
Write-Host "  Admin:   admin@sausam.com / password" -ForegroundColor Yellow
Write-Host "  Usuario: user@sausam.com / password" -ForegroundColor Yellow
Write-Host ""
Write-Host "Abriendo aplicación en el navegador..." -ForegroundColor Gray
Start-Sleep -Seconds 2
Start-Process "http://localhost:5173"
Write-Host ""
Write-Host "Presiona cualquier tecla para salir..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
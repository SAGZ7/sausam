# SAUSAM - Sistema de Administración de Usuarios de Samuel García

Sistema CRUD completo de gestión de usuarios con autenticación, roles y exportación a CSV.

![SAUSAM Dashboard](https://img.shields.io/badge/Laravel-11-FF2D20?style=for-the-badge&logo=laravel&logoColor=white)
![Vue](https://img.shields.io/badge/Vue.js-3-4FC08D?style=for-the-badge&logo=vue.js&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)

## 🚀 Características

- **CRUD Completo** de usuarios con validación frontend y backend
- **Autenticación** con Laravel Sanctum (token-based)
- **Sistema de Roles** (Administrador y Usuario)
- **Exportación a CSV** para administradores
- **Paginación** de resultados
- **API RESTful** documentada
- **Interfaz responsive** con Tailwind CSS
- **Protección XSS** automática
- **Dockerizado** para fácil despliegue

## 🛠️ Stack Tecnológico

### Backend
- **Laravel 11** - Framework PHP
- **PostgreSQL 15** - Base de datos
- **Laravel Sanctum** - Autenticación API
- **Laravel Excel** - Exportación CSV

### Frontend
- **Vue 3** (Composition API)
- **Vite 5** - Build tool
- **Vue Router 4** - Enrutamiento
- **Axios** - Cliente HTTP
- **Tailwind CSS 3** - Estilos
- **Vuelidate** - Validación de formularios

### DevOps
- **Docker** - Contenedorización
- **Docker Compose** - Orquestación

## Requisitos Previos

- Docker Desktop instalado
- Git
- Navegador web moderno

## Instalación

### 1. Clonar el repositorio
```bash
git clone https://github.com/SAGZ7/sausam.git
cd sausam
```

### 2. Levantar contenedores
```bash
docker-compose up -d
```

Esto levantará:
- PostgreSQL en puerto `5432`
- Backend Laravel en puerto `8000`
- Frontend Vue en puerto `5173`

### 3. Configurar backend
```bash
# Generar APP_KEY
docker exec sausam_backend php artisan key:generate

# Ejecutar migraciones
docker exec sausam_backend php artisan migrate

# Crear usuarios de prueba
docker exec sausam_backend php artisan db:seed --class=UserSeeder
```

### 4. Acceder a la aplicación

Abre tu navegador en: **http://localhost:5173**

## 👤 Usuarios de Prueba

### Administrador
- **Email:** admin@sausam.com
- **Contraseña:** password
- **Permisos:** CRUD completo + Exportar CSV

### Usuario Regular
- **Email:** user@sausam.com
- **Contraseña:** password
- **Permisos:** Solo lectura

## API Endpoints

### Autenticación
```
POST   /api/register    - Registrar nuevo usuario
POST   /api/login       - Iniciar sesión
POST   /api/logout      - Cerrar sesión
GET    /api/me          - Usuario autenticado
```

### Usuarios (requiere autenticación)
```
GET    /api/users           - Listar usuarios (paginado)
GET    /api/users/{id}      - Ver usuario específico
POST   /api/users           - Crear usuario (solo admin)
PUT    /api/users/{id}      - Actualizar usuario (solo admin)
DELETE /api/users/{id}      - Eliminar usuario (solo admin)
GET    /api/users/export/csv - Exportar CSV (solo admin)
```

### Ejemplo de Request
```bash
# Login
curl -X POST http://localhost:8000/api/login \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{"email":"admin@sausam.com","password":"password"}'

# Obtener usuarios (con token)
curl -X GET http://localhost:8000/api/users \
  -H "Authorization: Bearer {tu-token}" \
  -H "Accept: application/json"
```

## Estructura del Proyecto
```
sausam/
├── backend/                 # Laravel
│   ├── app/
│   │   ├── Http/
│   │   │   ├── Controllers/API/
│   │   │   │   ├── AuthController.php
│   │   │   │   └── UserController.php
│   │   │   └── Middleware/
│   │   │       └── CheckRole.php
│   │   ├── Models/
│   │   │   └── User.php
│   │   └── Exports/
│   │       └── UsersExport.php
│   ├── database/
│   │   ├── migrations/
│   │   └── seeders/
│   └── routes/
│       └── api.php
│
├── frontend/                # Vue 3 SPA
│   ├── src/
│   │   ├── components/
│   │   ├── views/
│   │   │   ├── Login.vue
│   │   │   ├── Dashboard.vue
│   │   │   └── Users.vue
│   │   ├── composables/
│   │   │   ├── useAuth.js
│   │   │   └── useUsers.js
│   │   ├── router/
│   │   │   └── index.js
│   │   └── services/
│   │       └── api.js
│   └── tailwind.config.js
│
└── docker-compose.yml
```

## Seguridad

- Passwords hasheados con bcrypt
- Autenticación basada en tokens
- Middleware de roles para proteger rutas
- Validación de datos en frontend y backend
- Protección CSRF
- Headers CORS configurados
- Protección XSS automática de Vue

## 🧪 Testing
```bash
# Tests backend (Laravel)
docker exec sausam_backend php artisan test

# Tests frontend (Vue)
docker exec sausam_frontend npm run test
```

## 📦 Comandos Útiles
```bash
# Ver logs
docker-compose logs -f

# Detener contenedores
docker-compose down

# Rebuild completo
docker-compose down
docker-compose build --no-cache
docker-compose up -d

# Acceder al contenedor backend
docker exec -it sausam_backend bash

# Limpiar caché Laravel
docker exec sausam_backend php artisan cache:clear
docker exec sausam_backend php artisan config:clear
```

## Capturas de Pantalla

### Login
![Login](docs/screenshots/login.png)

### Dashboard
![Dashboard](docs/screenshots/dashboard.png)

### Gestión de Usuarios
![Users](docs/screenshots/users.png)

## Notas de Desarrollo

- Desarrollado con Docker para garantizar portabilidad
- Arquitectura API REST con separación frontend/backend
- Código limpio siguiendo estándares PSR-12 (PHP) y Vue Style Guide
- Responsive design mobile-first
- Optimizado para producción

## Autor

**Samuel García**
- GitHub: [@SAGZ7](https://github.com/SAGZ7)
- Proyecto: Prueba Técnica - Enero 2025

## Licencia

Este proyecto fue desarrollado como prueba técnica.

---

**Desarrollado con ❤️ usando Laravel + Vue + Docker**
FROM php:8.4-fpm

# 1. Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpq-dev \
    libonig-dev \
    libxml2-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    zip \
    unzip

# 2. Limpiar cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# 3. Configurar GD
RUN docker-php-ext-configure gd --with-freetype --with-jpeg

# 4. Instalar extensiones PHP
RUN docker-php-ext-install pdo pdo_pgsql mbstring exif pcntl bcmath gd zip

# 5. Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 6. Establecer directorio de trabajo
WORKDIR /var/www

# 7. Copiar composer files
COPY composer.json composer.lock ./

# 8. Instalar dependencias
RUN composer install --no-interaction --no-dev --prefer-dist --ignore-platform-reqs --no-scripts

# 9. Copiar el resto de archivos
COPY . .

RUN composer dump-autoload --optimize

# 11. Permisos
RUN chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www/storage \
    && chmod -R 755 /var/www/bootstrap/cache

EXPOSE 8000

CMD php artisan migrate --force && php artisan serve --host=0.0.0.0 --port=8000

FROM php:8.3-fpm

RUN apt-get update && apt-get install -y \
    git curl libpq-dev libonig-dev libxml2-dev \
    libpng-dev libjpeg-dev libfreetype6-dev libzip-dev zip unzip

RUN apt-get clean && rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install pdo pdo_pgsql mbstring exif pcntl bcmath gd zip

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www
COPY . .

RUN chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www/storage \
    && chmod -R 755 /var/www/bootstrap/cache

EXPOSE 8000

CMD composer install --no-interaction --prefer-dist --ignore-platform-reqs && \
    php artisan serve --host=0.0.0.0 --port=8000

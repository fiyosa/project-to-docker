FROM php:8.1.18-fpm

# add composer to image app
COPY --from=composer:2.5.5 /usr/bin/composer /usr/bin/composer
RUN chmod +x /usr/bin/composer

# add nodejs to image app
COPY --from=node:14.21.3-slim /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node:14.21.3-slim /usr/local/bin/node /usr/local/bin/node
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    nano \
    libpq-dev

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /var/www/

# Copy file composer.json dan composer.lock ke dalam container
COPY ./ ./

# Install dependencies menggunakan Composer
RUN composer install --no-scripts --no-progress --no-interaction

# Autoload Composer
RUN composer dump-autoload --optimize

# RUN sudo chmod -R 777 storage && sudo chmod -R 777 bootstrap/cache

RUN php artisan route:clear

RUN php artisan cache:clear

RUN php artisan optimize:clear

CMD ["php-fpm"]

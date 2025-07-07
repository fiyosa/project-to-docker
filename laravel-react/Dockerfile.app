FROM php:8.2-fpm-alpine

## add composer to image app
COPY --from=composer:2.8.9 /usr/bin/composer /usr/bin/composer
RUN chmod +x /usr/bin/composer

## add nodejs to image app
COPY --from=node:22-alpine /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node:22-alpine /usr/local/bin/node /usr/local/bin/node
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm
# RUN npm install -g yarn --unsafe-perm

## install dependencies
RUN apk update && apk add --no-cache \
    # 1. main php
    bash curl git unzip zip vim libzip-dev oniguruma-dev icu-dev gmp-dev \
    # 2. image
    libpng-dev libjpeg-turbo-dev freetype-dev libwebp-dev libavif-dev

## install extensions
RUN docker-php-ext-configure gd && \
    docker-php-ext-install gd

# ======================
## DATABASE DRIVERS

## 1. MySQL/MariaDB
# RUN apk add --no-cache mariadb-dev && \
#     docker-php-ext-install pdo_mysql mysqli

## 2. PostgreSQL
# RUN apk add --no-cache postgresql-dev && \
#     docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql && \
#     docker-php-ext-install pdo_pgsql pgsql

## 3. SQLite
RUN apk add --no-cache sqlite-dev && \
    docker-php-ext-install pdo_sqlite

## 4. MongoDB (via PECL)
# RUN pecl install mongodb && \
#     docker-php-ext-enable mongodb

## 5. SQL Server (via ODBC)
# RUN apk add --no-cache unixodbc-dev freetds-dev && \
#     pecl install sqlsrv pdo_sqlsrv && \
#     docker-php-ext-enable sqlsrv pdo_sqlsrv && \
#     echo "extension=sqlsrv.so" > /usr/local/etc/php/conf.d/sqlsrv.ini && \
#     echo "extension=pdo_sqlsrv.so" > /usr/local/etc/php/conf.d/pdo_sqlsrv.ini

## 6. LDAP
# RUN apk add --no-cache openldap-dev libldap ca-certificates && \
#     docker-php-ext-configure ldap --with-libdir=lib/ && \
#     docker-php-ext-install ldap && \
#     # verify
#     php -r "if (!extension_loaded('ldap')) { throw new Exception('LDAP extension failed'); }" && \
#     # clean
#     apk del openldap-dev

# ======================

# Install supervisor for running services
RUN apk add --no-cache supervisor

## clear cache
RUN rm -rf /var/cache/apk/* /tmp/*

## set working directory
WORKDIR /var/www/html

## copy files
COPY composer.json ./

## install packages
RUN composer install --no-dev --no-scripts --no-interaction --optimize-autoloader

## copy files
COPY . .

### (optional)
RUN mv .env.example .env

RUN composer dump-autoload --optimize

### (optional)
RUN php artisan key:generate

## clear cache
RUN php artisan config:clear && \
    php artisan clear-compiled && \
    php artisan event:clear && \
    php artisan route:clear && \
    php artisan view:clear

## create cache
RUN php artisan config:cache && \
    php artisan event:cache && \
    php artisan route:cache && \
    php artisan view:cache

## set permissions
RUN chown -R 1000:1000 storage bootstrap/cache && \
    chmod -R 777 storage bootstrap/cache

    ### (optional)
RUN php artisan migrate

# ======================
## DATABASE DRIVERS

## delete unused files
RUN rm -f resources/js/package-lock.json
RUN rm -rf resources/js/node_modules

RUN npm install --omit=dev
RUN npm run build

RUN rm -rf resources/js/node_modules

# ======================

## Copy config supervisor
COPY docker/supervisord.conf /etc/supervisor/supervisord.conf

CMD ["supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]

# CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]

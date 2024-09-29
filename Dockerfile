# Utiliser une image de base PHP avec FPM
FROM php:8.1-fpm

    # Installer les dépendances, y compris Nginx
    RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    git \
    curl \
    libonig-dev \
    pkg-config \
    libssl-dev \
    libpq-dev  # Ajout de la bibliothèque PostgreSQL

    # Installer les extensions PHP requises pour Laravel
    RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install pdo pdo_mysql zip \
    && docker-php-ext-install pdo_pgsql  # Installation du driver pdo_pgsql


# Installer Composer globalement
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Créer le répertoire de l'application
RUN mkdir -p /var/www/html

# Définir le répertoire de travail
WORKDIR /var/www/html

# Copier le fichier composer et installer les dépendances
COPY composer.json composer.lock ./
RUN composer install --no-scripts --no-autoloader

# Copier le reste des fichiers de l'application
COPY . .

# Installer les dépendances du projet
RUN composer install --optimize-autoloader --no-dev

# Donner les permissions à l'utilisateur www-data
RUN chown -R www-data:www-data /var/www/html/storage /var/www//html/bootstrap/cache

# Exposer le port 8000 pour le serveur Artisan
EXPOSE 8000

# Lancer le serveur Laravel Artisan
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]

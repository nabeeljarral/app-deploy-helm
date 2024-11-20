# Stage 1: Build the Vue.js frontend
FROM node:14.20.1 AS node_build

# Set working directory
WORKDIR /application

# Copy package.json and package-lock.json to leverage Docker cache
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all project files
COPY . .

# Build the frontend for production
RUN npm run vite-prod


# Stage 2: Set up the PHP with Apache
FROM php:8.2-apache

# Set working directory
WORKDIR /var/www/html

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    libzip-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql zip

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy application source code and set permissions
COPY . /var/www/html
RUN chown -R www-data:www-data /var/www/html && mkdir -p /var/www/html/bootstrap/cache && chmod -R 777 /var/www/html/bootstrap/cache

# Copy built files from Node.js build stage
COPY --from=node_build /application/public /var/www/html/public

# Install PHP dependencies using Composer
RUN composer install --optimize-autoloader

# Expose port 80 for Apache
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]
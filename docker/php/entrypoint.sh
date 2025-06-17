#!/bin/sh

# Créer le fichier .env si manquant
if [ ! -f .env ]; then
  echo "Copie du fichier .env.example"
  cp .env.example .env
fi

if [ ! -d "vendor" ]; then
  echo "Installation des dépendances Composer..."
  composer install
fi

npm install
npm run build

php artisan key:generate
php artisan migrate:fresh --seed

exec docker-php-entrypoint php-fpm

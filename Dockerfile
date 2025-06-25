version: "3.8"

services:
  app:
    image: laravelsail/php83-composer
    container_name: laravel_app
    working_dir: /var/www
    volumes:
      - .:/var/www
    ports:
      - 8500:8000
    depends_on:
      - mysql
    environment:
      - APP_ENV=local
      - APP_DEBUG=true
      - APP_KEY=
      - DB_HOST=mysql
      - DB_PORT=3306
      - DB_DATABASE=laravel
      - DB_USERNAME=laravel
      - DB_PASSWORD=laravel

  mysql:
    image: mysql:8.0
    container_name: mysql_laravel
    restart: unless-stopped
    volumes:
      - db-data:/var/lib/mysql
    environment:
      MYSQL_DATABASE: laravel
      MYSQL_USER: laravel
      MYSQL_PASSWORD: laravel
      MYSQL_ROOT_PASSWORD: root
    ports:
      - 3306:3306

  nginx:
    image: nginx:alpine
    container_name: nginx_laravel
    ports:
      - 80:80
    volumes:
      - .:/var/www
      - ./nginx/default.conf:/etc/nginx/conf.d/default.conf
    depends_on:
      - app

volumes:
  db-data:

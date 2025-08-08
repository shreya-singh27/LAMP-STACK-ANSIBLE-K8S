FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y apache2 php libapache2-mod-php php-mysql && rm -rf /var/lib/apt/lists/*
COPY index.php /var/www/html/index.php
EXPOSE 80
CMD ["apache2ctl","-D","FOREGROUND"]


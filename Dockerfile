FROM debian:wheezy

MAINTAINER Oxalide bra@oxalide.com

RUN apt-get update && apt-get install -y apache2 php5 libapache2-mod-php5 php5-mcrypt php5-mysql && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

RUN echo "<?php phpinfo();" > /var/www/info.php

EXPOSE 80

CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]

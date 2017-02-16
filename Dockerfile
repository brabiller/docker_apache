FROM debian:wheezy

MAINTAINER Oxalide bra@oxalide.com

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && apt-get install -y apache2 php5 libapache2-mod-php5 php5-mcrypt php5-mysql && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_SERVERADMIN admin@localhost
ENV APACHE_SERVERNAME terredhermes.ppr-digital.hermes.com
ENV APACHE_SERVERALIAS docker.localhost
ENV APACHE_DOCUMENTROOT /var/www/terredhermes.ppr-digital.hermes.com

RUN mkdir /var/www/terredhermes.ppr-digital.hermes.com && chown www-data:www-data /var/www/terredhermes.ppr-digital.hermes.com
RUN echo "<?php phpinfo();" > /var/www/terredhermes.ppr-digital.hermes.com/index.php

ADD ./001-terredhermes.ppr-digital.hermes.com.conf /etc/apache2/sites-available/
RUN ln -s /etc/apache2/sites-available/001-terredhermes.ppr-digital.hermes.com.conf /etc/apache2/sites-enabled/

EXPOSE 80

CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]

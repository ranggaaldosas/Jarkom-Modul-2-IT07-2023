#!/bin/bash

if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root"
    exit 1
fi

echo -e '
nameserver 192.168.122.1
' > /etc/resolv.conf
apt-get update && apt install nginx php php-fpm -y
apt-get install wget -y
apt-get install unzip -y
apt-get install lynx -y
apt-get install apache2 -y

wget -O '/var/www/abimanyu.it07.com' 'https://drive.google.com/uc?export=download&id=1a4V23hwK9S7hQEDEcv9FL14UkkrHc-Zc'
unzip -o /var/www/abimanyu.it07.com -d /var/www/
mv /var/www/abimanyu.yyy.com /var/www/abimanyu.it07
rm /var/www/abimanyu.it07.com
rm -rf /var/www/abimanyu.yyy.com

wget -O '/var/www/arjuna.it07.com' 'https://drive.google.com/uc?export=download&id=17tAM_XDKYWDvF-JJix1x7txvTBEax7vX'
unzip -o /var/www/arjuna.it07.com -d /var/www/
mv /var/www/arjuna.yyy.com /var/www/arjuna.it07
rm /var/www/arjuna.it07.com
rm -rf /var/www/arjuna.yyy.com

wget -O '/var/www/parikesit.abimanyu.it07.com' 'https://drive.google.com/uc?export=download&id=1LdbYntiYVF_NVNgJis1GLCLPEGyIOreS'
unzip -o /var/www/parikesit.abimanyu.it07.com -d /var/www/
mv /var/www/parikesit.abimanyu.yyy.com /var/www/parikesit.abimanyu.it07
rm /var/www/parikesit.abimanyu.it07.com
rm -rf /var/www/parikesit.abimanyu.yyy.com
mkdir /var/www/parikesit.abimanyu.it07/secret

wget -O '/var/www/rjp.baratayuda.abimanyu.it07.com' 'https://drive.google.com/uc?export=download&id=1pPSP7yIR05JhSFG67RVzgkb-VcW9vQO6'
unzip -o /var/www/rjp.baratayuda.abimanyu.it07.com -d /var/www/
mv /var/www/rjp.baratayuda.abimanyu.yyy.com /var/www/rjp.baratayuda.abimanyu.it07
rm /var/www/rjp.baratayuda.abimanyu.it07.com
rm -rf /var/www/rjp.baratayuda.abimanyu.yyy.com

service php7.0-fpm start

mkdir /var/www/jarkom

echo ' <?php
 echo "Halo, Kamu berada di Abimanyu nya IT07";
 ?>' > /var/www/jarkom/index.php

echo ' server {

 	listen 8002;

 	root /var/www/jarkom;

 	index index.php index.html index.htm;
 	server_name _;

 	location / {
 			try_files $uri $uri/ /index.php?$query_string;
 	}

 	# pass PHP scripts to FastCGI server
 	location ~ \.php$ {
 	include snippets/fastcgi-php.conf;
 	fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
 	}

 location ~ /\.ht {
 			deny all;
 	}

 	error_log /var/log/nginx/jarkom_error.log;
 	access_log /var/log/nginx/jarkom_access.log;
 }' > /etc/nginx/sites-available/jarkom

ln -s /etc/nginx/sites-available/jarkom /etc/nginx/sites-enabled/jarkom
rm /etc/nginx/sites-enabled/default

#Soal 11
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/abimanyu.it07.com.conf
rm /etc/apache2/sites-available/000-default.conf

echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/abimanyu.it07

  ServerName abimanyu.it07.com
  ServerAlias www.abimanyu.it07.com

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/abimanyu.it07.com.conf

a2ensite abimanyu.it07.com.conf


#Soal 12
echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/abimanyu.it07
  ServerName abimanyu.it07.com
  ServerAlias www.abimanyu.it07.com

  <Directory /var/www/abimanyu.it07/index.php/home>
          Options +Indexes
  </Directory>

  Alias "/home" "/var/www/abimanyu.it07/index.php/home"

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/abimanyu.it07.com.conf


#Soal 13
echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/parikesit.abimanyu.it07
  ServerName parikesit.abimanyu.it07.com
  ServerAlias www.parikesit.abimanyu.it07.com

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/parikesit.abimanyu.it07.com.conf

a2ensite parikesit.abimanyu.it07.com.conf

#Soal 14
echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/parikesit.abimanyu.it07
  ServerName parikesit.abimanyu.it07.com
  ServerAlias www.parikesit.abimanyu.it07.com

  <Directory /var/www/parikesit.abimanyu.it07/public>
          Options +Indexes
  </Directory>

  <Directory /var/www/parikesit.abimanyu.it07/secret>
          Options -Indexes
  </Directory>

  Alias "/public" "/var/www/parikesit.abimanyu.it07/public"
  Alias "/secret" "/var/www/parikesit.abimanyu.it07/secret"

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/parikesit.abimanyu.it07.com.conf


#Soal 15
echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/parikesit.abimanyu.it07
  ServerName parikesit.abimanyu.it07.com
  ServerAlias www.parikesit.abimanyu.it07.com

  <Directory /var/www/parikesit.abimanyu.it07/public>
          Options +Indexes
  </Directory>

  <Directory /var/www/parikesit.abimanyu.it07/secret>
          Options -Indexes
  </Directory>

  Alias "/public" "/var/www/parikesit.abimanyu.it07/public"
  Alias "/secret" "/var/www/parikesit.abimanyu.it07/secret"

  ErrorDocument 404 /error/404.html
  ErrorDocument 403 /error/403.html

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/parikesit.abimanyu.it07.com.conf


#Soal 16
echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/parikesit.abimanyu.it07
  ServerName parikesit.abimanyu.it07.com
  ServerAlias www.parikesit.abimanyu.it07.com

  <Directory /var/www/parikesit.abimanyu.it07/public>
          Options +Indexes
  </Directory>

  <Directory /var/www/parikesit.abimanyu.it07/secret>
          Options -Indexes
  </Directory>

  Alias "/public" "/var/www/parikesit.abimanyu.it07/public"
  Alias "/secret" "/var/www/parikesit.abimanyu.it07/secret"
  Alias "/js" "/var/www/parikesit.abimanyu.it07/public/js"

  ErrorDocument 404 /error/404.html
  ErrorDocument 403 /error/403.html

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/parikesit.abimanyu.it07.com.conf


#Soal 17
echo -e '<VirtualHost *:14000 *:14400>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/rjp.baratayuda.abimanyu.it07
  ServerName rjp.baratayuda.abimanyu.it07.com
  ServerAlias www.rjp.baratayuda.abimanyu.it07.com

  ErrorDocument 404 /error/404.html
  ErrorDocument 403 /error/403.html

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/rjp.baratayuda.abimanyu.it07.com.conf

echo -e '# If you just change the port or add more ports here, you will likely also
# have to change the VirtualHost statement in
# /etc/apache2/sites-enabled/000-default.conf

Listen 80
Listen 14000
Listen 14400

<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet' > /etc/apache2/ports.conf

a2ensite rjp.baratayuda.abimanyu.it07.com.conf


#Soal 18
echo -e '<VirtualHost *:14000 *:14400>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/rjp.baratayuda.abimanyu.it07
  ServerName rjp.baratayuda.abimanyu.it07.com
  ServerAlias www.rjp.baratayuda.abimanyu.it07.com

  <Directory /var/www/rjp.baratayuda.abimanyu.it07>
          AuthType Basic
          AuthName "Restricted Content"
          AuthUserFile /etc/apache2/.htpasswd
          Require valid-user
  </Directory>

  ErrorDocument 404 /error/404.html
  ErrorDocument 403 /error/403.html

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/rjp.baratayuda.abimanyu.it07.com.conf

a2ensite rjp.baratayuda.abimanyu.it07.com.conf

htpasswd -c -b /etc/apache2/.htpasswd Wayang baratayudait07


# Soal 19
echo -e '<VirtualHost *:80>
    ServerAdmin webmaster@abimanyu.it07.com
    DocumentRoot /var/www/html

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

    Redirect / http://www.abimanyu.it07.com/
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

apache2ctl configtest


# Soal 20
a2enmod rewrite

echo 'RewriteEngine On
RewriteCond %{REQUEST_URI} ^/public/images/(.*)(abimanyu)(.*\.(png|jpg))
RewriteCond %{REQUEST_URI} !/public/images/abimanyu.png
RewriteRule abimanyu http://parikesit.abimanyu.it07.com/public/images/abimanyu.png$1 [L,R=301]' > /var/www/parikesit.abimanyu.it07/.htaccess

echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/parikesit.abimanyu.it07

  ServerName parikesit.abimanyu.it07.com
  ServerAlias www.parikesit.abimanyu.it07.com

  <Directory /var/www/parikesit.abimanyu.it07/public>
          Options +Indexes
  </Directory>

  <Directory /var/www/parikesit.abimanyu.it07/secret>
          Options -Indexes
  </Directory>

  <Directory /var/www/parikesit.abimanyu.it07>
          Options +FollowSymLinks -Multiviews
          AllowOverride All
  </Directory>

  Alias "/public" "/var/www/parikesit.abimanyu.it07/public"
  Alias "/secret" "/var/www/parikesit.abimanyu.it07/secret"
  Alias "/js" "/var/www/parikesit.abimanyu.it07/public/js"

  ErrorDocument 404 /error/404.html
  ErrorDocument 403 /error/403.html

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/parikesit.abimanyu.it07.com.conf

service apache2 restart


# TEST push
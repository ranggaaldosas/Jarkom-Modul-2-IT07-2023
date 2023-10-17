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
 echo "Halo, Kamu berada di Wisanggeni";
 ?>' > /var/www/jarkom/index.php

echo ' server {

 	listen 8003;

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

service nginx restart
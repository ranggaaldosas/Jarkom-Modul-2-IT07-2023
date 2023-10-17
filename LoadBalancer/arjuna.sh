echo -e '
nameserver 192.168.122.1
' > /etc/resolv.conf
 apt-get update
 apt-get install bind9 nginx -y

echo 'upstream roundrobin {
  server 10.67.2.5:8001; # IP PrabuKusuma
  server 10.67.2.4:8002; # IP Abimanyu
  server 10.67.2.6:8003; # IP Wisanggeni
}

server {
  listen 80;
  server_name arjuna.it07.com www.arjuna.it07.com;

  location / {
    proxy_pass http://roundrobin;
  }
}
' > /etc/nginx/sites-available/jarkom

ln -s /etc/nginx/sites-available/jarkom /etc/nginx/sites-enabled/jarkom

rm /etc/nginx/sites-enabled/default

service nginx restart
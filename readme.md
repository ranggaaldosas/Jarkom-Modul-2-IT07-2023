# Praktikum Modul 2 Jaringan Komputer

Praktikum Modul 2 Jaringan Komputer - **IT07**

## Authors

| Nama                                                | NRP        |
| --------------------------------------------------- | ---------- |
| [Rangga Aldo](https://www.github.com/ranggaaldosas) | 5027211059 |
| [Maulana Ilyasa](https://www.github.com/xxx)        | 5027211065 |

> Resources can be downloaded [here](https://drive.google.com/drive/folders/15Wr1eTQqn_vZzqkTXEAKF7tgULsxkxfe?usp=sharing)

### Topologi 2

<p align="center">
    <img src="https://i.ibb.co/vPCRwNW/02.png">
<p align="center">
    <img src="https://i.ibb.co/GJg0Rhx/Screenshot-41.png">

# Laporan Resmi Modul 2

## Config

- **List IP**

  ```
  YudhistiraDNSMaster 10.67.3.2
  WerkudaraDNSSlave 10.67.2.2

  SadewaClient 10.67.1.2
  NakulaClient 10.67.1.3

  ArjunaLoadBalancer 10.67.2.3

  AbimayuWebServer 10.67.2.4
  PrabukusumaWebServer 10.67.2.5
  WisageniWebSever 10.67.2.6
  ```

- **Pandudewanata Router**

  ```
  auto eth0
  iface eth0 inet dhcp

  auto eth1
  iface eth1 inet static
          address 10.67.1.1
          netmask 255.255.255.0

  auto eth2
  iface eth2 inet static
          address 10.67.2.1
          netmask 255.255.255.0

  auto eth3
  iface eth3 inet static
          address 10.67.3.1
          netmask 255.255.255.0
  ```

- **Yudhistira DNS Master**
  ```
  auto eth0
  iface eth0 inet static
          address 10.67.3.2
          netmask 255.255.255.0
          gateway 10.67.3.1
  ```
- **Werkudara DNS Slave**
  ```
  auto eth0
  iface eth0 inet static
          address 10.67.2.2
          netmask 255.255.255.0
          gateway 10.67.2.1
  ```
- **Sadewa Client**
  ```
  auto eth0
  iface eth0 inet static
          address 10.67.1.2
          netmask 255.255.255.0
          gateway 10.67.1.1
  ```
- **Nakula Client**

  ```
  auto eth0
  iface eth0 inet static
          address 10.67.1.3
          netmask 255.255.255.0
          gateway 10.67.1.1
  ```

- **Arjuna LoadBalancer**
  ```
  auto eth0
  iface eth0 inet static
          address 10.67.2.3
          netmask 255.255.255.0
          gateway 10.67.2.1
  ```
- **Abimanyu WebServer**
  ```
  auto eth0
  iface eth0 inet static
          address 10.67.2.4
          netmask 255.255.255.0
          gateway 10.67.2.1
  ```
- **Prabukusuma WebServer**
  ```
  auto eth0
  iface eth0 inet static
          address 10.67.2.5
          netmask 255.255.255.0
          gateway 10.67.2.1
  ```
- **Wisanggeni WebServer**
  ```
  auto eth0
  iface eth0 inet static
          address 10.67.2.6
          netmask 255.255.255.0
          gateway 10.67.2.1
  ```

## Setup .bashrc

- **Router**
  ```
  iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.67.0.0/16
  echo 'nameserver 192.168.122.1' > /etc/resolv.conf
  ```
- **DNS (Master)**

  ```
  apt-get update
  apt-get install bind9 -y

  bash dnsmaster.sh

  echo 'nameserver 192.168.122.1' > /etc/resolv.conf
  ```

- **DNS (Slave)**

  ```
  apt-get update
  apt-get install bind9 -y

  bash dnsslave.sh

  echo 'nameserver 192.168.122.1' > /etc/resolv.conf
  ```

- **Client**

  ```
  pt-get update
  apt-get install dnsutils -y
  apt-get install lynx -y

  echo 'nameserver 10.67.3.2
  nameserver 10.67.2.2
  nameserver 192.168.122.1' > /etc/resolv.conf
  ```

---

## Soal 1

#### 1. Yudhistira akan digunakan sebagai DNS Master, Werkudara sebagai DNS Slave, Arjuna merupakan Load Balancer yang terdiri dari beberapa Web Server yaitu Prabakusuma, Abimanyu, dan Wisanggeni. Buatlah topologi dengan pembagian sebagai berikut. Folder topologi dapat diakses pada drive berikut

### Script

**Nakula dan Sadewa**

```bash
ping google.com
```

### Result

<p align="center">
    <img src="https://i.ibb.co/d6pRfBV/Screenshot-32.png
https://i.ibb.co/PMrwXsX/Screenshot-31.png">
<p align="center">
    <img src="https://i.ibb.co/d6pRfBV/Screenshot-32.png">

## Soal 2

#### 2. Buatlah website utama pada node arjuna dengan akses ke arjuna.yyy.com dengan alias www.arjuna.yyy.com dengan yyy merupakan kode kelompok.

### Scripting

```bash
mkdir /etc/bind/jarkom
cp /etc/bind/db.local /etc/bind/jarkom/arjuna.it07.com

echo 'zone "arjuna.it07.com" {
        type master;
        file "/etc/bind/jarkom/arjuna.it07.com";
        allow-transfer { 10.67.2.2; }; // IP Werkudara
};

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     arjuna.it07.com. root.arjuna.it07.com. (
                        2023101001      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      arjuna.it07.com.
@       IN      A       10.67.2.2     ; IP Yudhistira
www     IN      CNAME   arjuna.it07.com.' > /etc/bind/jarkom/arjuna.it07.com
```

```bash
ping arjuna.it07.com
ping www.arjuna.it07.com
```

<p align="center">
    <img src="https://i.ibb.co/LvtcKKq/Screenshot-33.png">

## Soal 3

#### 3. Dengan cara yang sama seperti soal nomor 2, buatlah website utama dengan akses ke abimanyu.yyy.com dan alias www.abimanyu.yyy.com.

### Scripting

```bash
ping arjuna.it07.com
ping www.arjuna.it07.com
```

```bash
cp /etc/bind/db.local /etc/bind/jarkom/abimanyu.it07.com

echo 'zone "arjuna.it07.com" {
        type master;
        file "/etc/bind/jarkom/arjuna.it07.com";
        allow-transfer { 10.67.2.2; }; // IP Werkudara
};

zone "abimanyu.it07.com" {
        type master;
        notify yes;
        also-notify { 10.67.2.2; }; // IP Werkudara
        allow-transfer { 10.67.2.2; }; // IP Werkudara
        file "/etc/bind/jarkom/abimanyu.it07.com";
};' > /etc/bind/named.conf.local

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     abimanyu.it07.com. root.abimanyu.it07.com. (
                        2023101001      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      abimanyu.it07.com.
@       IN      A       10.67.2.2     ; IP Yudhistira
www     IN      CNAME   abimanyu.it07.com.' > /etc/bind/jarkom/abimanyu.it07.com
```

<p align="center">
    <img src="https://i.ibb.co/TBDZb6c/Screenshot-34.png">

## Soal 4

#### 4. Kemudian, karena terdapat beberapa web yang harus di-deploy, buatlah subdomain parikesit.abimanyu.yyy.com yang diatur DNS-nya di Yudhistira dan mengarah ke Abimanyu.

> Tambahkan parikesit IN A 10.67.2.4 ; IP Abimanyu

### Scripting

```bash
ping parikesit.abimanyu.it07.com
```

```bash
echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     abimanyu.it07.com. root.abimanyu.it07.com. (
                        2023101001      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      abimanyu.it07.com.
@       IN      A       10.67.2.2     ; IP Yudhistira
www     IN      CNAME   abimanyu.it07.com.
parikesit IN    A       10.67.2.4     ; IP Abimanyu' > /etc/bind/jarkom/abimanyu.it07.com
```

<p align="center">
    <img src="https://i.ibb.co/bWfxqbJ/Screenshot-35.png">

## Soal 5

#### 5. Buat juga reverse domain untuk domain utama. (Abimanyu saja yang direverse)

### Scripting

```bash
host -t PTR 10.67.2.4
```

```bash
cp /etc/bind/db.local /etc/bind/jarkom/2.236.192.in-addr.arpa

echo 'zone "2.236.192.in-addr.arpa" {
        type master;
        file "/etc/bind/jarkom/2.236.192.in-addr.arpa";
};' > /etc/bind/named.conf.local

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     abimanyu.it07.com. root.abimanyu.it07.com. (
                        2003101001      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
2.236.192.in-addr.arpa. IN      NS      abimanyu.it07.com.
2                       IN      PTR     abimanyu.it07.com.' > /etc/bind/jarkom/2.236.192.in-addr.arpa
```

<p align="center">
    <img src="https://i.ibb.co/jy619Wx/Screenshot-36.png">

## Soal 6

#### 6. Agar dapat tetap dihubungi ketika DNS Server Yudhistira bermasalah, buat juga Werkudara sebagai DNS Slave untuk domain utama.

### Scripting

A. di master, service bind9 stop

<p align="center">
    <img src="https://i.ibb.co/Xp0Wbc2/Screenshot-38.png">

B. di nakula client, lakukan command berikut

```bash
ping abimanyu.it07.com
```

<p align="center">
    <img src="https://i.ibb.co/Xp0Wbc2/Screenshot-38.png">
    
C. berhasil == slave berhasil jadi dns cadangan

D. di master, service bind9 start, untuk soal selanjutnya

```bash
echo 'zone "abimanyu.it07.com" {
    type slave;
    masters { 10.67.3.2; }; // Masukan IP Yudhistira
    file "/var/lib/bind/abimanyu.it07.com";
}; > /etc/bind/named.conf.local
```

## Soal 7

#### 7. Seperti yang kita tahu karena banyak sekali informasi yang harus diterima, buatlah subdomain khusus untuk perang yaitu baratayuda.abimanyu.yyy.com dengan alias www.baratayuda.abimanyu.yyy.com yang didelegasikan dari Yudhistira ke Werkudara dengan IP menuju ke Abimanyu dalam folder Baratayuda.

### Scripting

```bash
ping baratayuda.abimanyu.it07.com
ping www.baratayuda.abimanyu.it07.com
```

```bash
#Soal 7
mkdir /etc/bind/baratayuda

#Soal 7
cp /etc/bind/db.local /etc/bind/baratayuda/baratayuda.abimanyu.it07.com
echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     baratayuda.abimanyu.it07.com. root.baratayuda.abimanyu.it07.com. (
                        2023101001      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      baratayuda.abimanyu.it07.com.
@       IN      A       10.67.2.4    ; IP Abimanyu
www     IN      CNAME   baratayuda.abimanyu.it07.com.' > /etc/bind/baratayuda/baratayuda.abimanyu.it07.com

#Soal 7
echo "options {
    directory \"/var/cache/bind\";

    // If there is a firewall between you and nameservers you want
    // to talk to, you may need to fix the firewall to allow multiple
    // ports to talk.  See http://www.kb.cert.org/vuls/id/800113

    // If your ISP provided one or more IP addresses for stable
    // nameservers, you probably want to use them as forwarders.
    // Uncomment the following block, and insert the addresses replacing
    // the all-0's placeholder.

    // forwarders {
    //      0.0.0.0;
    // };

    //========================================================================
    // If BIND logs error messages about the root key being expired,
    // you will need to update your keys.  See https://www.isc.org/bind-keys
    //========================================================================
    //dnssec-validation auto;
    allow-query {any;};

    auth-nxdomain no;
    listen-on-v6 { any; };
};" > /etc/bind/named.conf.options
```

<p align="center">
    <img src="https://i.ibb.co/Ptj3ChB/Screenshot-37.png">

## Soal 8

#### 8. Seperti yang kita tahu karena banyak sekali informasi yang harus diterima, buatlah subdomain khusus untuk perang yaitu baratayuda.abimanyu.yyy.com dengan alias www.baratayuda.abimanyu.yyy.com yang didelegasikan dari Yudhistira ke Werkudara dengan IP menuju ke Abimanyu dalam folder Baratayuda.

### Scripting

```bash
ping rjp.baratayuda.abimanyu.it07.com
ping www.rjp.baratayuda.abimanyu.it07.com
```

```bash
#Soal 8
echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     baratayuda.abimanyu.it07.com. root.baratayuda.abimanyu.it07.com. (
                        2023101001      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@               IN      NS      baratayuda.abimanyu.it07.com.
@               IN      A       10.67.2.4    ; IP Abimanyu
www             IN      CNAME   baratayuda.abimanyu.it07.com.
rjp             IN      A       10.67.2.4    ; IP Abimanyu
www.rjp         IN      CNAME   rjp.baratayuda.abimanyu.it07.com.' > /etc/bind/baratayuda/baratayuda.abimanyu.it07.com
```

<p align="center">
    <img src="https://i.ibb.co/4KkM0ZD/Screenshot-40.png">

## Soal 9 & 10

###

9. Melakukan sebuah deployment untuk ketiga worker (Abimanyu,Prabukusuma,Wisanggeni) yang dimana Arjuna bertindak sebagai load balancer serta menggunakan nginx sebagai web server

10. Setelah berhasil setup pada nomer 9,tugas pada nomer 10 tidak lebih hanya menambahkan port pada masing-masing worker untuk formatnya kurang lebih Prabakusuma:8001 ,Abimanyu:8002 ,Wisanggeni:8003 dalam menjalankannya.

### scripting

```bash
lynx http://10.67.2.5:8001 #Prabukusuma
lynx http://10.67.2.4:8002 #Abimanyu
lynx http://10.67.2.6:8003 #Wisageni

```

```bash
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
```

<p align="center">
    <img src="https://i.ibb.co/xh38wDd/Screenshot-42.png">
<p align="center">
    <img src="https://i.ibb.co/8mqZ3NC/Screenshot-43.png">
<p align="center">
    <img src="https://i.ibb.co/26ZWWFV/Screenshot-44.png">

## Soal 11

###

11. Melakukan konfigurasi web server yang dibuat dengan https://www.abimanyu.yyy.com/ pada worker abimanyu,tapi sebelum itu buatlah server dengan DocumentRoot /var/www/abimanyu.yyy.

### scripting

```bash
lynx abimanyu.it07.com
```

```bash
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
```

<p align="center">
    <img src="https://i.ibb.co/bNG4Zn2/Screenshot-62.png">

## Soal 12

###

12. Setelah berhasil pada nomer 11, sekarang ubah directory menjadi /home seperti https://www.abimanyu.yyy.com/home

### scripting

```bash
lynx abimanyu.it07.com/home
```

```bash
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
```

<p align="center">
    <img src="https://i.ibb.co/hXwmcQ1/Screenshot-63.png">

## Soal 13

###

13. Setelah berhasi setup parikesit di nomer atas, sekrang kita panggil kembali subdomain nya dengan format https://www.parikesit.abimanyu.yyy.com/

### scripting

```bash
lynx parikesit.abimanyu.it07.com
```

```bash
echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/parikesit.abimanyu.it07
  ServerName parikesit.abimanyu.it07.com
  ServerAlias www.parikesit.abimanyu.it07.com

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/parikesit.abimanyu.it07.com.conf

a2ensite parikesit.abimanyu.it07.com.conf
```

<p align="center">
    <img src="https://i.ibb.co/drjCf4j/Screenshot-45.png">

## Soal 14

###

14. Lalu pada format parikesit yang sama pada nomer 13, pada nomer 14 ini kita menambahkan masing” /public untuk melakukan directory listing, dan /secret tidak dapat diakses (403 forbidden)

### scripting

```bash
lynx parikesit.abimanyu.it07.com/public
lynx parikesit.abimanyu.it07.com/secret

```

```bash
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
```

<p align="center">
    <img src="https://i.ibb.co/kMtrp7N/Screenshot-46.png">

#### /Secret???!!

<p align="center">
    <img src="https://i.ibb.co/0M5twc6/Screenshot-47.png">

## Soal 15

###

15. Membuat customisasi halaman error /errortest yang dimana akan menampilkan alert 404 not found serta pesan, lalu untuk halaman /secret akan muncul alert 403 forbidden serta terdapat pesan

### scripting

```bash
lynx parikesit.abimanyu.it07.com/iniakanerror
lynx parikesit.abimanyu.it07.com/secret

```

```bash
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
```

> /iniakanerror??! Alias 404

<p align="center">
    <img src="https://i.ibb.co/GQbnDSM/Screenshot-58.png">
<p align="center">
    <img src="https://i.ibb.co/3fxHRxm/Screenshot-48.png">

> /403!!!!!

<p align="center">
    <img src="https://i.ibb.co/bNhnz2X/Screenshot-57.png">

<p align="center">
    <img src="https://i.ibb.co/0M5twc6/Screenshot-47.png">

## Soal 16

###

16. Mengubah virtual host pada file asset agar lebih singkat yang dimana sebelumnya https://www.parikesit.abimanyu.yyy.com/public/js menjadi /js saja pada belakangnya

###

### Inilah /js yang anda minta puh

> lynx parikesit.abimanyu.it07.com/js

```bash
lynx parikesit.abimanyu.it07.com/js
```

```bash
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
```

<p align="center">
    <img src="https://i.ibb.co/93kqdGj/Screenshot-50.png">

## Soal 17 & 18

###

17. Membuat sebuah konfigurasi baru www.rjp.baratayuda.abimanyu.yyy.com lalu untuk memanggilnya dilakukan kustomisasi port dengan menambahkan port listen 14000 dan 14400.

18. Setelah berhasil pada nomer 17, sekarang kita tambahkan username “Wayang” dan password “baratayudait07”untuk melakukan autentikasi saat hendak masuk ke www.rjp.baratayuda.abimanyu.yyy.com

### scripting

```bash
lynx rjp.baratayuda.abimanyu.it07.com:14000
lynx rjp.baratayuda.abimanyu.it07.com:14400

```

```bash
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
```

### Butuhh username dan password??!!

> Rahasia yak:
> **username: Wayang pass: baratayudait07**

Hihi minta authorization

<p align="center">
    <img src="https://i.ibb.co/rc1fTF2/Screenshot-59.png">
<p align="center">
    <img src="https://i.ibb.co/vjBCX8Y/Screenshot-60.png">

Sukses masuk :)

<p align="center">
    <img src="https://i.ibb.co/2nCVfQx/Screenshot-51.png">

Jika username/password salah??

<p align="center">
    <img src="https://i.ibb.co/b1Pp68n/Screenshot-52.png">

## Soal 19

###

19. Setiap melakukan pemanggilan IP abimanyu maka akan dibuat sistem otomatis yang men direct kepada link https://www.abimanyu.yyy.com/ yang telah di kustomisasi

### scripting

> lynx 10.67.2.4 #nyoba ke abimanyu

```bash
lynx 10.67.2.4  #akan mengarah ke www.abimanyu.it07.com
```

```bash
echo -e '<VirtualHost *:80>
    ServerAdmin webmaster@abimanyu.it07.com
    DocumentRoot /var/www/html

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

    Redirect / http://www.abimanyu.it07.com/
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

apache2ctl configtest
```

<p align="center">
    <img src="https://i.ibb.co/pvC6MXk/Screenshot-61.png">

## Soal 20

###

20. Pada format parikesit yang sudah dibuat pada nomer 13 https://www.parikesit.abimanyu.yyy.com/ kita mengubah request gambar yang terdapat substring “abimanyu” langsung di direct menuju abimanyu.png

###

### Nyoba download gambar?

```bash
lynx parikesit.abimanyu.it07.com/public/images/not-abimanyu.png
```

```bash
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
```

#### A. Download Gambar

<p align="center">
    <img src="https://i.ibb.co/GcBmK18/Screenshot-53.png">

#### B. Wow bisa save ke local-disk

<p align="center">
    <img src="https://i.ibb.co/nk8W5VD/Screenshot-54.png">

#### C. Coba ganti nama

<p align="center">
    <img src="https://i.ibb.co/6s9ZWY0/Screenshot-55.png">

#### D. Muncul di local brow

<p align="center">
    <img src="https://i.ibb.co/4gf122q/Screenshot-56.png">

---

# IT07 Pamit

## Authors

| Nama                                                | NRP        |
| --------------------------------------------------- | ---------- |
| [Rangga Aldo](https://www.github.com/ranggaaldosas) | 5027211059 |
| [Maulana Ilyasa](https://www.github.com/xxx)        | 5027211065 |

<p align="center">
    <img src="https://i.ibb.co/Z6Hf5Rq/82u6f1.jpg">

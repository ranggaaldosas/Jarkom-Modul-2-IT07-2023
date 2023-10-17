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
ping arjuna.it07.com
ping www.arjuna.it07.com
```

<p align="center">
    <img src="https://i.ibb.co/LvtcKKq/Screenshot-33.png">

## Soal 3

#### 3. Dengan cara yang sama seperti soal nomor 2, buatlah website utama dengan akses ke abimanyu.yyy.com dan alias www.abimanyu.yyy.com.

### Scripting

```bash
ping abimanyu.it07.com
ping www.abimanyu.it07.com
```

<p align="center">
    <img src="https://i.ibb.co/TBDZb6c/Screenshot-34.png">

## Soal 4

#### 4. Kemudian, karena terdapat beberapa web yang harus di-deploy, buatlah subdomain parikesit.abimanyu.yyy.com yang diatur DNS-nya di Yudhistira dan mengarah ke Abimanyu.

### Scripting

```bash
ping parikesit.abimanyu.it07.com
```

<p align="center">
    <img src="https://i.ibb.co/bWfxqbJ/Screenshot-35.png">

## Soal 5

#### 5. Buat juga reverse domain untuk domain utama. (Abimanyu saja yang direverse)

### Scripting

```bash
host -t PTR 10.67.2.4
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

## Soal 7

#### 7. Seperti yang kita tahu karena banyak sekali informasi yang harus diterima, buatlah subdomain khusus untuk perang yaitu baratayuda.abimanyu.yyy.com dengan alias www.baratayuda.abimanyu.yyy.com yang didelegasikan dari Yudhistira ke Werkudara dengan IP menuju ke Abimanyu dalam folder Baratayuda.

### Scripting

```bash
ping baratayuda.abimanyu.it07.com
ping www.baratayuda.abimanyu.it07.com
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

<p align="center">
    <img src="https://i.ibb.co/bNG4Zn2/Screenshot-62.png">

## Soal 12

###
12. Setelah berhasil pada nomer 11, sekarang ubah directory menjadi /home seperti https://www.abimanyu.yyy.com/home

### scripting

```bash
lynx abimanyu.it07.com/home
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

<p align="center">
    <img src="https://i.ibb.co/drjCf4j/Screenshot-45.png">

## Soal 14

###
14. Lalu pada format parikesit yang sama pada nomer 13, pada nomer 14 ini kita menambahkan masing” /public untuk melakukan directory listing, dan  /secret tidak dapat diakses (403 forbidden)

### scripting

```bash
lynx parikesit.abimanyu.it07.com/public
lynx parikesit.abimanyu.it07.com/secret

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

<p align="center">
    <img src="https://i.ibb.co/93kqdGj/Screenshot-50.png">

## Soal 17 & 18

###
17. Membuat sebuah konfigurasi  baru www.rjp.baratayuda.abimanyu.yyy.com lalu untuk memanggilnya dilakukan kustomisasi port dengan menambahkan port listen 14000 dan 14400.

18. Setelah berhasil pada nomer 17, sekarang kita tambahkan username “Wayang” dan password “baratayudait07”untuk melakukan autentikasi saat hendak masuk ke  www.rjp.baratayuda.abimanyu.yyy.com

### scripting

```bash
lynx rjp.baratayuda.abimanyu.it07.com:14000
lynx rjp.baratayuda.abimanyu.it07.com:14400

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

<p align="center">
    <img src="https://i.ibb.co/pvC6MXk/Screenshot-61.png">

## Soal 20

###
20. Pada format parikesit yang sudah dibuat pada nomer 13 https://www.parikesit.abimanyu.yyy.com/ kita mengubah request gambar yang terdapat substring “abimanyu” langsung di direct menuju abimanyu.png

### 

### Nyoba download gambar?

> lynx parikesit.abimanyu.it07.com/public/images/not-abimanyu.png

### 

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


# test pushh
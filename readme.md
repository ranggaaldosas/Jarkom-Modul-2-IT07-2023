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

### Testing

```bash
ping arjuna.it07.com
ping www.arjuna.it07.com
```

<p align="center">
    <img src="https://i.ibb.co/LvtcKKq/Screenshot-33.png">

## Soal 3

#### 3. Dengan cara yang sama seperti soal nomor 2, buatlah website utama dengan akses ke abimanyu.yyy.com dan alias www.abimanyu.yyy.com.

### Testing

```bash
ping abimanyu.it07.com
ping www.abimanyu.it07.com
```

<p align="center">
    <img src="https://i.ibb.co/TBDZb6c/Screenshot-34.png">

## Soal 4

#### 4. Kemudian, karena terdapat beberapa web yang harus di-deploy, buatlah subdomain parikesit.abimanyu.yyy.com yang diatur DNS-nya di Yudhistira dan mengarah ke Abimanyu.

### Testing

```bash
ping parikesit.abimanyu.it07.com
```

<p align="center">
    <img src="https://i.ibb.co/bWfxqbJ/Screenshot-35.png">

## Soal 5

#### 5. Buat juga reverse domain untuk domain utama. (Abimanyu saja yang direverse)

### Testing

```bash
host -t PTR 10.67.2.4
```

<p align="center">
    <img src="https://i.ibb.co/jy619Wx/Screenshot-36.png">

## Soal 6

#### 6. Agar dapat tetap dihubungi ketika DNS Server Yudhistira bermasalah, buat juga Werkudara sebagai DNS Slave untuk domain utama.

### Testing

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

### Testing

```bash
ping baratayuda.abimanyu.it07.com
ping www.baratayuda.abimanyu.it07.com
```

<p align="center">
    <img src="https://i.ibb.co/Ptj3ChB/Screenshot-37.png">

## Soal 8

#### 8. Seperti yang kita tahu karena banyak sekali informasi yang harus diterima, buatlah subdomain khusus untuk perang yaitu baratayuda.abimanyu.yyy.com dengan alias www.baratayuda.abimanyu.yyy.com yang didelegasikan dari Yudhistira ke Werkudara dengan IP menuju ke Abimanyu dalam folder Baratayuda.

### Testing

```bash
ping rjp.baratayuda.abimanyu.it07.com
ping www.rjp.baratayuda.abimanyu.it07.com
```

<p align="center">
    <img src="https://i.ibb.co/4KkM0ZD/Screenshot-40.png">

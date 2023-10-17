#!/bin/bash

if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root"
    exit 1
fi

echo 'nameserver 192.168.122.1' > /etc/resolv.conf
apt-get update
apt-get install bind9 -y

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
};

zone "2.236.192.in-addr.arpa" {
        type master;
        file "/etc/bind/jarkom/2.236.192.in-addr.arpa";
};' > /etc/bind/named.conf.local


mkdir /etc/bind/jarkom

cp /etc/bind/db.local /etc/bind/jarkom/arjuna.it07.com

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


cp /etc/bind/db.local /etc/bind/jarkom/abimanyu.it07.com

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


cp /etc/bind/db.local /etc/bind/jarkom/2.236.192.in-addr.arpa

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


echo ';
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
parikesit IN    A       10.67.2.4     ; IP Abimanyu
ns1     IN      A       10.67.2.2     ; IP Werkudara
baratayuda IN   NS      ns1' > /etc/bind/jarkom/abimanyu.it07.com

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


# 11
echo ';
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
@       IN      A       10.67.2.4     ; IP Abimanyu
www     IN      CNAME   abimanyu.it07.com.
parikesit IN    A       10.67.2.4     ; IP Abimanyu
ns1     IN      A       10.67.2.2     ; IP Werkudara
baratayuda IN   NS      ns1' > /etc/bind/jarkom/abimanyu.it07.com

service bind9 restart

if [ $? -eq 0 ]; then
    echo "Bind9 restarted successfully."
else
    echo "Failed to restart Bind9. Check for errors."
    named-checkconf
fi

echo "IT07 bisa scripting master"
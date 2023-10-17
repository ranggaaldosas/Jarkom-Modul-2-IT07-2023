echo 'nameserver 192.168.122.1' > /etc/resolv.conf
apt-get update
apt-get install bind9 -y

echo 'zone "abimanyu.it07.com" {
    type slave;
    masters { 10.67.3.2; }; // Masukan IP Yudhistira
    file "/var/lib/bind/abimanyu.it07.com";
};

zone "baratayuda.abimanyu.it07.com" {
        type master;
        file "/etc/bind/baratayuda/baratayuda.abimanyu.it07.com";
};' > /etc/bind/named.conf.local

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

service bind9 restart

if [ $? -eq 0 ]; then
    echo "Bind9 restarted successfully."
else
    echo "Failed to restart Bind9. Check for errors."
    named-checkconf
fi

echo "IT07 bisa scripting slave"
echo -e '
nameserver 10.67.3.2 # IP Yudhistira
nameserver 10.67.2.2 # IP Werkudara
nameserver 192.168.122.1
' > /etc/resolv.conf

apt-get update
apt-get install dnsutils -y
apt-get install lynx -y
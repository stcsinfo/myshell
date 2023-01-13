https://help.ubuntu.com/community/BIND9ServerHowto

Services:
sudo systemctl status named.service

Files:
sudo cat /etc/bind/named.conf
sudo cat /etc/bind/named.conf.options
sudo cat /etc/bind/named.conf.local

Rsync from master to slave:
-

named:
named-checkzone example.com /etc/bind/$domain_pro_stcs
named-checkzone 1.168.192.in-addr.arpa. /etc/bind/db.192
dig 1.168.192.in-addr.arpa. AXFR
sudo journalctl -f --unit named.service
sudo tail -f /var/log/syslog

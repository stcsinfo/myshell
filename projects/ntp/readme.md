https://ubuntu.com/server/docs/network-ntp
https://www.ntppool.org/zone/europe

timedatectl status
systemctl status systemd-timesyncd
/etc/systemd/timesyncd.conf

sudo apt install chrony -y

chronyd - the actual daemon to sync and serve via the NTP protocol
chronyc - command-line interface for chrony daemon

sudo nano /etc/chrony/chrony.conf

sudo systemctl restart chrony.service
sudo systemctl enable chrony.service

chronyc sources
chronyc sourcestats

sudo journalctl -f --unit chrony.service
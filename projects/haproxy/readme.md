https://kifarunix.com/configure-highly-available-haproxy-with-keepalived-on-ubuntu-20-04/
https://www.haproxy.com/blog/how-to-install-haproxy-on-ubuntu/

Services:
sudo systemctl restart haproxy.service
sudo systemctl restart keepalive.service

Files:
sudo nano /etc/haproxy/haproxy.cfg
sudo nano /etc/keepalived/keepalived.conf

Rsync from master to slave:
/etc/ssl/private/*.pem
/etc/haproxy/haproxy.cfg

haproxy:
sudo haproxy -f /etc/haproxy/haproxy.cfg -c
sudo journalctl -f --unit haproxy.service

keepalive:
ip --brief add
sudo journalctl -f --unit keepalived.service

haproxy

    Ubuntu
    sudo apt install --no-install-recommends software-properties-common
    sudo add-apt-repository ppa:vbernat/haproxy-2.6 -y
    sudo apt install haproxy=2.6.\*
    haproxy -v
    sudo apt update && sudo apt upgrade -y

    Debian
    #https://haproxy.debian.net/#distribution=Debian&release=bullseye&version=2.6
    curl https://haproxy.debian.net/bernat.debian.org.gpg | gpg --dearmor > /usr/share/keyrings/haproxy.debian.net.gpg
    sudo echo deb "[signed-by=/usr/share/keyrings/haproxy.debian.net.gpg]" http://haproxy.debian.net bullseye-backports-2.6 main \
    > /etc/apt/sources.list.d/haproxy.list
    sudo apt-get update
    sudo apt-get install haproxy=2.6.\*
    haproxy -v


keepalive

Both servers

    sudo apt install keepalived
    sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf
    echo "net.ipv4.ip_nonlocal_bind = 1" >> /etc/sysctl.conf
    sysctl -p

Set archives master-backup
    
    sudo systemctl restart keepalived.service

sudo systemctl status mariadb.service
sudo apt install mariadb-server
sudo mysql_secure_installation


To allow connections from remote hosts edit:

/etc/mysql/mariadb.conf.d/50-server.cnf

change 
# allow from all source
bind-address            = 0.0.0.0
docker-compose exec passbolt su -m -c "/usr/share/php/passbolt/bin/cake \
passbolt register_user \
-u none@passbolt.local \
-f No \
-l One \
-r admin" -s /bin/sh www-data
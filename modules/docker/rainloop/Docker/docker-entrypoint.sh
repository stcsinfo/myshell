#!/bin/sh
sh /rainloop-install.sh
#service apache2 start
httpd-foreground
#tail -f /dev/null
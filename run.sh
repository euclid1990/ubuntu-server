#!/bin/bash
/usr/sbin/a2enmod *
/usr/sbin/a2dismod lua
cd /etc/apache2/site-available
a2ensite *
cd
echo "RESTART APACHE"
/etc/init.d/apache2 restart
echo "START TRACCAR"
/opt/traccar/bin/traccar start
/usr/sbin/sshd -D

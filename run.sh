#!/bin/bash
/usr/sbin/a2enmod *
/usr/sbin/a2dismod lua
cd /etc/apache2/site-available
a2ensite *
cd
/etc/init.d/apache2 restart
/opt/traccar/bin/traccar start
/usr/sbin/sshd -D

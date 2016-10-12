#!/bin/bash
/usr/sbin/a2enmod *
/usr/sbin/a2dismod lua
/etc/init.d/apache2 start
/usr/sbin/sshd -D

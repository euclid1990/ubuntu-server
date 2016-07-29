#!/bin/bash

set_authorized_keys()
{
    if [ ! -z "${AUTHORIZED_KEYS}" ]; then
        IFS=$'\n'
        AUTHORIZED_KEY_ARR=$(echo ${AUTHORIZED_KEYS} | tr "," "\n")
        for k in $AUTHORIZED_KEY_ARR
        do
            k=$(echo $k |sed -e 's/^ *//' -e 's/ *$//')
            cat /root/.ssh/authorized_keys | grep "$k" >/dev/null 2>&1
            if [ $? -ne 0 ]; then
                echo "Adding SSH public key: $k"
                echo $k >> /root/.ssh/authorized_keys
            fi
        done
    fi
    chmod 600 /root/.ssh/authorized_keys
}

set_root_password()
{
    if [ ! -f /scripts/root_password_set ]; then
        if [ -z "$ROOT_PASSWORD" ]; then
            ROOT_PASSWORD="$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)"
        fi
        echo "root:${ROOT_PASSWORD}" | chpasswd
        echo "Root's Password: $ROOT_PASSWORD"
        touch /scripts/root_password_set
    fi
}

set_authorized_keys
set_root_password

exec $@
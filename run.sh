#!/bin/bash

set_authorized_keys()
{
    echo ${SSH_AUTHORIZED_KEYS} >> ~/.ssh/authorized_keys
    chmod 600 ~/.ssh/authorized_keys
}

set_authorized_keys
/usr/sbin/sshd -D
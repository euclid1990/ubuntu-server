# Ubuntu Server
## Version 0.3

- Ubuntu docker images with SSH access, Vim and Net tools and apache / php / phpmyadmin / imagemick und vielem mehr..

### Running container
```
docker run --name some-server \
    -e AUTHORIZED_KEYS="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7c..." \
    -e ROOT_PASSWORD="your_password" -d ubuntu-server
```

### SSH
```
ssh root@{container_ip}
```


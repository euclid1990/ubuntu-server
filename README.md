# Ubuntu Server

- Ubuntu docker images with SSH access, Vim and Net tools

### Running container
```
$ docker run --name some-server \
    -e AUTHORIZED_KEYS="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7c..." \
    -e ROOT_PASSWORD="your_password" -d ubuntu-server

$ docker run --name some-server \
    -e AUTHORIZED_KEYS="$(cat ~/.ssh/id_rsa.pub)" \
    -e ROOT_PASSWORD="your_password" -d ubuntu-server
```

### SSH
```
$ docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' some-server
$ ssh root@{container_ip}
```

### [Docker Hub page](https://hub.docker.com/r/euclid1990/ubuntu-server/)
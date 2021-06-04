# Ubuntu Server

- Ubuntu 20.04 docker images with Systemd, SSH access, Vim and Net tools

### Running container
```
$ docker run -d --name ssh-server \
    -e AUTHORIZED_KEYS="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7c..." \
    -e ROOT_PASSWORD="your_password" \
    --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    euclid1990/ubuntu-server

$ docker run -d --name ssh-server \
    -e AUTHORIZED_KEYS="$(cat ~/.ssh/id_rsa.pub)" \
    -e ROOT_PASSWORD="your_password" \
    --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    euclid1990/ubuntu-server
```

## SSH
```
$ docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ssh-server
$ ssh root@{container_ip}
```

### [Docker Hub page](https://hub.docker.com/r/euclid1990/ubuntu-server/)
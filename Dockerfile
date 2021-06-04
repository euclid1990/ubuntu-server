FROM ubuntu:20.04

ENV LC_ALL=C DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    apt-utils apt-transport-https ca-certificates \
    locales net-tools zip vim \
    systemd systemd-sysv \
    openssh-server \
    python-simplejson \
    python3-pip python3-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Change default python to python3
RUN cd /usr/local/bin \
    && ln -s /usr/bin/python3 python \
    && pip3 install --upgrade pip

# Setup systemd
RUN cd /lib/systemd/system/sysinit.target.wants/ \
    && ls | grep -v systemd-tmpfiles-setup | xargs rm -f $1

RUN rm -f /lib/systemd/system/multi-user.target.wants/* \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/basic.target.wants/* \
    /lib/systemd/system/anaconda.target.wants/* \
    /lib/systemd/system/plymouth* \
    /lib/systemd/system/systemd-update-utmp*

RUN mkdir /var/run/sshd && mkdir /root/.ssh/ && touch /root/.ssh/authorized_keys

VOLUME [ "/sys/fs/cgroup" ]

# Setup SSH server
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

COPY ./entrypoint.sh /scripts/entrypoint.sh
COPY ./command.sh /scripts/command.sh
RUN chmod a+x /scripts/*.sh

RUN echo "export AUTHORIZED_KEYS=" >> /etc/profile
RUN echo "export ROOT_PASSWORD=" >> /etc/profile

RUN mkdir -p /run/sshd /var/run/sshd \
    && systemctl enable ssh.service

EXPOSE 80 443 3000 3001 9000 3306 22

ENTRYPOINT ["/scripts/entrypoint.sh"]

CMD ["/lib/systemd/systemd"]

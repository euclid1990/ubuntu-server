FROM ubuntu:20.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    apt-utils \
    apt-transport-https \
    ca-certificates \
    net-tools \
    openssh-server \
    python-simplejson \
    zip \
    vim \
    python3-pip python3-dev \
    && cd /usr/local/bin \
    && ln -s /usr/bin/python3 python \
    && pip3 install --upgrade pip

RUN mkdir /var/run/sshd && mkdir /root/.ssh/ && touch /root/.ssh/authorized_keys

RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

COPY ./entrypoint.sh /scripts/entrypoint.sh
COPY ./command.sh /scripts/command.sh
RUN chmod a+x /scripts/*.sh

RUN echo "export AUTHORIZED_KEYS=" >> /etc/profile
RUN echo "export ROOT_PASSWORD=" >> /etc/profile

EXPOSE 80 443 3000 9000 3306 22

ENTRYPOINT ["/scripts/entrypoint.sh"]

CMD ["/scripts/command.sh"]
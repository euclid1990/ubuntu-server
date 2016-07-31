FROM ubuntu:14.04
MAINTAINER euclid1990

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    apt-utils \
    apt-transport-https \
    ca-certificates \
    net-tools \
    openssh-server \
    python-simplejson \
    zip \
    vim

RUN mkdir /var/run/sshd && mkdir /root/.ssh/ && touch /root/.ssh/authorized_keys

RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

COPY ./docker-entrypoint.sh /scripts/docker-entrypoint.sh
COPY ./run.sh /scripts/run.sh
RUN chmod a+x /scripts/docker-entrypoint.sh && chmod a+x /scripts/run.sh

RUN echo "export AUTHORIZED_KEYS=" >> /etc/profile
RUN echo "export ROOT_PASSWORD=" >> /etc/profile

EXPOSE 80 443 3000 9000 3306 22

ENTRYPOINT ["/scripts/docker-entrypoint.sh"]

CMD ["/scripts/run.sh"]
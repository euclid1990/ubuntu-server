FROM ubuntu
MAINTAINER euclid1990

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    apt-utils \
    net-tools \
    openssh-server

RUN mkdir /var/run/sshd

RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN mkdir ~/.ssh/ && touch ~/.ssh/authorized_keys

EXPOSE 80 443 3000 9000 3306 22
CMD ["/usr/sbin/sshd", "-D"]
FROM debian:stretch
LABEL maintainer="Jeremie CUADRADO"

ENV DEBIAN_FRONTEND noninteractive

# Enable systemd.
RUN apt-get update ; \
    apt-get install -y systemd ; \
    apt-get clean ; \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ; \
    rm -rf /lib/systemd/system/multi-user.target.wants/* ; \
    rm -rf /etc/systemd/system/*.wants/* ; \
    rm -rf /lib/systemd/system/local-fs.target.wants/* ; \
    rm -rf /lib/systemd/system/sockets.target.wants/*udev* ; \
    rm -rf /lib/systemd/system/sockets.target.wants/*initctl* ; \
    rm -rf /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* ; \
    rm -rf /lib/systemd/system/systemd-update-utmp* ; \
    test -e /usr/bin/python || (apt-get -y update && apt-get install -y python3 sudo gnupg python3-apt openssl)

# Mount cgroup volume
VOLUME [ "/sys/fs/cgroup" ]

CMD ["/lib/systemd/systemd"]

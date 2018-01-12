FROM ubuntu:16.04

RUN apt-get update \
    && apt-get install -y build-essential libmodule-install-perl libdbd-mysql-perl libconfig-tiny-perl liblog-dispatch-perl libparallel-forkmanager-perl git \
    && cd /tmp \
    && git clone https://github.com/yoshinorim/mha4mysql-manager.git \
    && cd mha4mysql-manager \
    && perl Makefile.PL \
    && make \
    && make install \
    && cp -p samples/scripts/master_ip_failover /usr/local/bin/ \
    && chown root:root /usr/local/bin/master_ip_failover \
    && chmod 555 /usr/local/bin/master_ip_failover

COPY mha/.ssh /root/.ssh
RUN chmod 600 /root/.ssh/config \
    && chmod 400 /root/.ssh/id_rsa_mha \
    && chown root:root /root/.ssh/id_rsa_mha \
    && chown root:root /root/.ssh/config \
    && mkdir -p /var/log/masterha \
    && mkdir -p /etc/masterha/conf \
    && mkdir -p /var/run/sshd
   
COPY mha/config /etc/masterha/conf/test.conf

RUN apt-get -y install build-essential devscripts dh-make fakeroot dpkg-dev debhelper libdbi-perl libmysqlclient-dev zlib1g-dev libmodule-install-perl libdbd-mysql-perl git openssh-server\
    && cd /tmp \
    && git clone https://github.com/yoshinorim/mha4mysql-node \
    && cd mha4mysql-node \
    && perl Makefile.PL \
    && make \
    && make install

COPY mha/NodeUtil.pm  /usr/local/share/perl/5.22.1/MHA/NodeUtil.pm

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

FROM leafney/ubuntu-mysql
MAINTAINER mizanur rahman <mrahmanjewel@gmail.com>

ENV MYSQL_USER=admin \
    MYSQL_PASS= \
    REPLICATION_USER=replica \
    REPLICATION_PASS=replica \
    REPLICATION_HOST= \
    REPLICATION_PORT=3306 \
    MYSQL_DATA_DIR=/var/lib/mysql \
    MYSQL_CONFIG=/etc/mysql/conf.d/custom.cnf \
    MYSQL_RUN_DIR=/var/run/mysqld \
    MYSQL_LOG=/var/log/mysql/error.log \
    OS_LOCALE="en_US.UTF-8"

# Set the locale
RUN apt-get update && apt-get install -y locales openssh-server\
    && locale-gen ${OS_LOCALE} \
    && dpkg-reconfigure locales

ENV LANG=${OS_LOCALE} \
    LANGUAGE=en_US:en \
    LC_ALL=${OS_LOCALE}

# Remove existing mysql configuration
RUN rm -rf /etc/mysql/* \
    && mkdir /etc/mysql/conf.d \
    && touch /tmp/.EMPTY_DB
    # Forward request and error logs to docker log collector
    #&& ln -sf /dev/stderr ${MYSQL_LOG}

# Add MySQL configuration
COPY my.cnf /etc/mysql/my.cnf
COPY custom.cnf ${MYSQL_CONFIG}

EXPOSE 3306/tcp 22
VOLUME  ["${MYSQL_DATA_DIR}", "${MYSQL_RUN_DIR}"]

# Prepare for MHA node
COPY mha/.ssh /root/.ssh
RUN chmod 600 /root/.ssh/config \
    && chmod 400 /root/.ssh/id_rsa_mha \
    && chown root:root /root/.ssh/id_rsa_mha \
    && chown root:root /root/.ssh/config \
    && mkdir -p /var/log/masterha \
    && mkdir -p /var/run/sshd \
    && systemctl enable ssh

RUN apt-get -y install build-essential devscripts dh-make fakeroot dpkg-dev debhelper libdbi-perl libmysqlclient-dev zlib1g-dev libmodule-install-perl libdbd-mysql-perl git \
    && cd /tmp \
    && git clone https://github.com/yoshinorim/mha4mysql-node \
    && cd mha4mysql-node \
    && perl Makefile.PL \
    && make \
    && make install

COPY mha/NodeUtil.pm  /usr/local/share/perl/5.22.1/MHA/NodeUtil.pm

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]

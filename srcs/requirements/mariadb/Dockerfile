FROM debian:bullseye-slim

ARG MARIADB_VERSION=10.5

RUN apt-get update && \
    apt-get install -y mariadb-server-${MARIADB_VERSION} coreutils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /run/mysqld && \
    chown mysql:mysql /run/mysqld

COPY tools/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
# COPY tools/my.cnf /etc/mysql/my.cnf
COPY tools/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# CMD ["tail", "-f", "/dev/null"]


CMD ["mysqld"]

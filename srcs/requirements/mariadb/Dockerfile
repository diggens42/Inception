FROM debian:bullseye-slim


RUN apt-get update && \
    apt-get install -y mariadb-server coreutils tini && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY tools/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/docker-entrypoint.sh /docker-entrypoint-initdb.d/docker-entrypoint.sh

RUN chmod +x /docker-entrypoint-initdb.d/docker-entrypoint.sh
RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

ENTRYPOINT [ "/usr/bin/tini", "--" ]
# ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]


CMD ["/docker-entrypoint-initdb.d/docker-entrypoint.sh"]



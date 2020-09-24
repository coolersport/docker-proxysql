FROM debian:buster-slim

ENV PROXYSQL_VERSION=2.0.14

COPY --chown=999:999 rootfs /

RUN apt update && apt upgrade -y && \
    apt install -y lsb-release curl gnupg2 gettext && \
    curl -fsSL 'https://repo.proxysql.com/ProxySQL/repo_pub_key' | apt-key add - && \
    echo deb https://repo.proxysql.com/ProxySQL/proxysql-2.0.x/$(lsb_release -sc)/ ./ > /etc/apt/sources.list.d/proxysql.list && \
	apt update && \
	apt install proxysql=$PROXYSQL_VERSION -y && \
# clean up
    chmod +x /*.sh && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/*

USER proxysql

ENTRYPOINT ["/entrypoint.sh"]

#!/usr/bin/env bash

CNF=${PROXYSQL_CNF:-/etc/proxysql.cnf}

if [[ -n "$PROXYSQL_CNF_TEMPLATE" ]]; then
	[[ ! -f "$CNF" || -w "$CNF" ]] && envsubst < $PROXYSQL_CNF_TEMPLATE > $CNF
fi

if [[ -z "$@" ]]; then
	exec proxysql --initial -f -D ${PROXYSQL_DATADIR:-/var/lib/proxysql} -c $CNF ${PROXYSQL_NO_MONITOR}
else
	exec $@
fi

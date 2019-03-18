#!/bin/sh
set -e

if [ "$1" = "snmptrapd" ]; then
	shift

	cp /config/snmptrapd.src /config/snmptrapd.conf
	if [ -n "$TRAP_COMMUNITIES" ] ; then
		# TODO split on spaces, ensure sed can handle multiples
		sed -i \
			-e "s/^(.*) # TRAP_COMMUNITY/$TRAP_COMMUNITIES/" \
			/config/snmptrapd.conf
	fi

	exec /usr/sbin/snmptrapd -a -f -n -Le "$@"
fi

exec "$@"

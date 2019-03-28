#!/bin/sh
set -e

if compgen -G "/config/rpm/*.rpm" > /dev/null; then
	yum install -y /config/rpm/*.rpm || true
fi

if [ "$1" = "snmptrapd" ]; then
	shift

	cp /default/snmptrapd.conf /config/snmptrapd.conf
	if [ -n "$TRAP_COMMUNITY_1" ] ; then
		sed -r -i \
			-e "s/^(.*) # TRAP_COMMUNITY_1/authCommunity execute,log $TRAP_COMMUNITY_1/" \
			/config/snmptrapd.conf
	fi
	if [ -n "$TRAP_COMMUNITY_2" ] ; then
		sed -r -i \
			-e "s/^(.*) # TRAP_COMMUNITY_2$/authCommunity execute,log $TRAP_COMMUNITY_2/" \
			/config/snmptrapd.conf
	fi
	if [ -n "$TRAP_COMMUNITY_3" ] ; then
		sed -r -i \
			-e "s/^(.*) # TRAP_COMMUNITY_3$/authCommunity execute,log $TRAP_COMMUNITY_3/" \
			/config/snmptrapd.conf
	fi
	if [ -n "$TRAP_COMMUNITY_4" ] ; then
		sed -r -i \
			-e "s/^(.*) # TRAP_COMMUNITY_4$/authCommunity execute,log $TRAP_COMMUNITY_4/" \
			/config/snmptrapd.conf
	fi
	if [ -n "$TRAP_COMMUNITY_5" ] ; then
		sed -r -i \
			-e "s/^(.*) # TRAP_COMMUNITY_5$/authCommunity execute,log $TRAP_COMMUNITY_5/" \
			/config/snmptrapd.conf
	fi
	if [ -n "$TRAP_COMMUNITY_6" ] ; then
		sed -r -i \
			-e "s/^(.*) # TRAP_COMMUNITY_6$/authCommunity execute,log $TRAP_COMMUNITY_6/" \
			/config/snmptrapd.conf
	fi
	if [ -n "$TRAP_COMMUNITY_7" ] ; then
		sed -r -i \
			-e "s/^(.*) # TRAP_COMMUNITY_7$/authCommunity execute,log $TRAP_COMMUNITY_7/" \
			/config/snmptrapd.conf
	fi
	if [ -n "$TRAP_COMMUNITY_8" ] ; then
		sed -r -i \
			-e "s/^(.*) # TRAP_COMMUNITY_8$/authCommunity execute,log $TRAP_COMMUNITY_8/" \
			/config/snmptrapd.conf
	fi

	exec /usr/sbin/snmptrapd -a -f -n -LE 5 "$@"
fi

exec "$@"

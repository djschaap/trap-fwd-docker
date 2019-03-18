# trap-fwd-docker

Docker image for forwarding traps from snmptrapd to rsyslog within Docker.

Based on Alpine Linux.

USE AT YOUR OWN RISK.

Project Home: https://github.com/djschaap/trap-fwd-docker

Docker Hub: https://cloud.docker.com/repository/docker/djschaap/trap_fwd

## Test Commands

### v1 generic warmStart
   snmptrap -v 1 -c public $HOST enterprises.9 '' 1 0 ''

### v1 NET-SNMP-AGENT-MIB::nsNotifyStart
   snmptrap -v 1 -c public $HOST netSnmpNotificationPrefix '' 6 1 ''
    # enterprise-oid agent trap-type specific-type uptime [OID TYPE VALUE]...

### v2c warmStart
   snmptrap -v 2c -c public $HOST '' warmStart
    # uptime trapoid [OID TYPE VALUE] ...

### v2c
   snmptrap -v 2c -c public $HOST 0 linkUp ifIndex.1 i 1 \
     ifAdminStatus.1 i up ifOperStatus.1 i up ifDescr s eth0

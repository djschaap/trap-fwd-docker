# trap-fwd-docker

Docker image for forwarding traps from snmptrapd to rsyslog within Docker.

Based on CentOS 7.

USE AT YOUR OWN RISK.

Project Home: https://github.com/djschaap/trap-fwd-docker

Docker Hub: https://cloud.docker.com/repository/docker/djschaap/trap_fwd

## Makefile targets

- Makefile from https://github.com/mvanholsteijn/docker-makefile

```
make patch-release     increments the patch release level, build and push to registry
make minor-release     increments the minor release level, build and push to registry
make major-release     increments the major release level, build and push to registry
make release           build the current release and push the image to the registry
make build             builds a new version of your Docker image and tags it
make snapshot          build from the current (dirty) workspace and pushes the image to the registry
make check-status      will check whether there are outstanding changes
make check-release     will check whether the current directory matches the tagged release in git.
make showver           will show the current release tag based on the directory content.
```

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

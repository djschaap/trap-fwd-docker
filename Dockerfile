FROM centos:7
#FROM alpine:3.9
LABEL maintainer="djschaap@gmail.com"
VOLUME /config
# alpine:3.9 net-utils snmptrapd is missing embedded perl interpreter
#RUN apk --no-cache add net-snmp \
#  && addgroup -S snmp \
#  && adduser -S -D -s /bin/sh snmp snmp \
#  && chown -R snmp.snmp /logs
RUN yum install -y \
    net-snmp \
    net-snmp-perl \
    perl-App-cpanminus \
    perl-CPAN \
    perl-JSON \
  && cpanm Net::Syslog \
  && yum clean all 

COPY config /config
COPY default /default
COPY entrypoint.sh /
COPY lib/TrapFwd.pm /usr/local/share/perl5/

ENTRYPOINT ["/entrypoint.sh"]
CMD ["snmptrapd", "-c", "/config/snmptrapd.conf"]

EXPOSE 162/udp

ENV RSYSLOG_HOST rsyslog
ENV RSYSLOG_PORT 5145
ENV TRAP_COMMUNITY_1 public
ENV TRAP_COMMUNITY_2 ""
ENV TRAP_COMMUNITY_3 ""
ENV TRAP_COMMUNITY_4 ""
ENV TRAP_COMMUNITY_5 ""
ENV TRAP_COMMUNITY_6 ""
ENV TRAP_COMMUNITY_7 ""
ENV TRAP_COMMUNITY_8 ""

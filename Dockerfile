FROM centos:7
#FROM alpine:3.9
LABEL maintainer="djschaap@gmail.com"
VOLUME /config /logs
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
COPY entrypoint.sh /
COPY lib/TrapFwd.pm /usr/local/share/perl5/

ENTRYPOINT ["/entrypoint.sh"]
CMD ["snmptrapd", "-c", "/config/snmptrapd.conf", "-Dperl"]

EXPOSE 162/udp

ENV CUSTOMER_ID 00000
ENV RSYSLOG_HOST rsyslog
ENV RSYSLOG_PORT 5145
#ENV TRAP_COMMUNITIES private public

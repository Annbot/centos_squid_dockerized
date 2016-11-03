FROM centos
MAINTAINER robert.kleniewski

ENV SQUID_CACHE_LOC=/var/spool/squid \
    SQUID_LOG_LOC=/var/log/squid \
    SQUID_USR=squidusr

RUN yum update -y \
 && yum install squid -y \ 
 && mv /etc/squid/squid.conf /etc/squid/squid.conf.orig \
 && useradd -ms /sbin/nologin ${SQUID_USR} \
 && chmod -R 755 ${SQUID_LOG_LOC} \
 && chown -R ${SQUID_USR}:${SQUID_USR} ${SQUID_LOG_LOC} \
 && mkdir -p ${SQUID_CACHE_LOC} \
 && chmod -R 755 ${SQUID_CACHE_LOC} \
 && chown -R ${SQUID_USR}:${SQUID_USR} ${SQUID_CACHE_LOC} \
 && touch /var/run/squid.pid \
 && chown ${SQUID_USR}:${SQUID_USR} /var/run/squid.pid  

COPY squid.conf /etc/squid/squid.conf
COPY start.sh /sbin/start.sh
RUN chmod 755 /sbin/start.sh

USER ${SQUID_USR}

EXPOSE 3128/tcp
VOLUME ["${SQUID_CACHE_LOC}"]
ENTRYPOINT ["/sbin/start.sh"]

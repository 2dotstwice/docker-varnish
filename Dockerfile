FROM ubuntu:14.04

RUN apt-get -qq update && \
    apt-get -y --no-install-recommends --fix-missing install \
        ca-certificates \
        apt-transport-https \
        curl \
        supervisor && \
    curl -s https://packagecloud.io/install/repositories/varnishcache/varnish41/script.deb.sh | bash && \
    apt-get -y --no-install-recommends --fix-missing install varnish && \
    rm -rf /var/lib/apt/lists/*

ADD ./files/etc/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
ADD ./files/etc/supervisor/conf.d/varnish.conf /etc/supervisor/conf.d/varnish.conf

# Still to be tested thoroughly
#ADD ./files/etc/supervisor/conf.d/varnishncsa.conf /etc/supervisor/conf.d/varnishncsa.conf
#ADD ./files/varnishncsa.sh /varnishncsa.sh

VOLUME /var/log

EXPOSE 80

CMD supervisord -n -c /etc/supervisor/supervisord.conf

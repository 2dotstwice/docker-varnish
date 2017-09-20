#!/bin/bash
# stores Varnish access logs formatted as JSON
# so it can be easily picked up by a Logstash agent
varnishncsa \
    -a -w /var/log/varnish/access.log \
    -F \
"{ \
  \"client_ip\":\"%h\", \
  \"request\":\"%r\", \
  \"message\": \"%h %l %u %t \\\\\"%r\\\\\" %s %b\", \
  \"timestamp\": \"%{%Y-%m-%dT%H:%M:%S%z}t\", \
  \"useragent\": \"%{User-agent}i\", \
  \"host\": \"%{Host}i\", \
  \"duration\": %D, \
  \"status\": %s, \
  \"request\": \"%U%q\", \
  \"urlpath\": \"%U\", \
  \"urlquery\": \"%q\", \
  \"method\": \"%m\", \
  \"bytes\": %O, \
  \"cache\": \"%{X-Cache}o\" \
}";

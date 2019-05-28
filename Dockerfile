FROM nginx:stable-alpine

ADD conf/nginx.conf /etc/nginx/nginx.conf
#ADD conf/service.conf /etc/nginx/conf.d/service.conf

ADD script/entrypoint.sh /entrypoint.sh
ADD script/le.sh /le.sh

RUN \
 rm /etc/nginx/conf.d/default.conf && \
 chmod +x /entrypoint.sh && \
 chmod +x /le.sh && \
 apk add  --update certbot tzdata openssl gcc python2-dev musl-dev libffi-dev openssl-dev py2-pip && \
 rm -rf /var/cache/apk/* && \
 pip install certbot-dns-dnsimple

CMD ["/entrypoint.sh"]

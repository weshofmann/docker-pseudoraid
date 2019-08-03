FROM alpine:latest

RUN apk --update add python git bash vim curl smartmontools 

RUN apk add snapraid mergerfs --update-cache \
      --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing --allow-untrusted

RUN git clone https://github.com/Chronial/snapraid-runner.git /app/snapraid-runner && \
    chmod +x /app/snapraid-runner/snapraid-runner.py && \
    rm -rf /var/cache/apk/*

RUN echo '0 3 * * * /usr/bin/python /app/snapraid-runner/snapraid-runner.py -c /config/snapraid-runner.conf' > /etc/crontabs/root

VOLUME /mnt /config

COPY /snapraid.sh /mergerfs.sh /entrypoint.sh  /
RUN chmod 755 /snapraid.sh /mergerfs.sh /entrypoint.sh

CMD ["/entrypoint.sh"]

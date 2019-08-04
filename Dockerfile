FROM alpine:latest

RUN apk --update add python git bash vim curl smartmontools 

RUN apk add snapraid mergerfs --update-cache \
      --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing --allow-untrusted

RUN git clone https://github.com/Chronial/snapraid-runner.git /app/snapraid-runner && \
    chmod +x /app/snapraid-runner/snapraid-runner.py && \
    rm -rf /var/cache/apk/*

VOLUME /share /config

COPY entrypoint /entrypoint
RUN chmod 755 /entrypoint

CMD ["/entrypoint"]

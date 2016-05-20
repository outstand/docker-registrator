FROM gliderlabs/registrator:v7
MAINTAINER Ryan Schlesinger <ryan@outstand.com>

RUN apk update && \
      apk add bash && \
      rm -rf /var/cache/apk/*

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["registrator"]

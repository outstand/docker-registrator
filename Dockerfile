FROM gliderlabs/registrator:v7
MAINTAINER Ryan Schlesinger <ryan@outstand.com>

# Alpine 3.2 doesn't have --no-cache
RUN apk update && \
      apk add bash && \
      rm -rf /var/cache/apk/*

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["registrator"]

FROM gliderlabs/registrator:master
MAINTAINER Ryan Schlesinger <ryan@outstand.com>

RUN apk add --no-cache bash

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["registrator"]

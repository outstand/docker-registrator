FROM gliderlabs/registrator:v7
MAINTAINER Ryan Schlesinger <ryan@outstand.com>

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["registrator"]

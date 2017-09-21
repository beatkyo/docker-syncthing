ARG IMAGE

FROM ${IMAGE}

RUN apk update && apk add --update ca-certificates curl && update-ca-certificates 

ARG VERSION
ARG DIST

ENV STNODEFAULTFOLDER true
ENV STNOUPGRADE true

WORKDIR /opt/syncthing
RUN chown 1000:1000 .

USER 1000:1000

RUN set -x \
	&& mkdir -p /opt/syncthing/config \
	&& mkdir -p /opt/syncthing/sync \
	&& curl -fL https://github.com/syncthing/syncthing/releases/download/v${VERSION}/${DIST}-v${VERSION}.tar.gz | tar -xz \
	&& mv ${DIST}-v${VERSION}/syncthing . \
	&& rm -rf ${DIST}-v${VERSION}


ENTRYPOINT ["/opt/syncthing/syncthing", "-home", "/opt/syncthing/config", "-gui-address", "0.0.0.0:8384"]
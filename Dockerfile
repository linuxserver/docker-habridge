FROM lsiobase/alpine:3.8

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="saarg"

# install packages
RUN \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	curl \
	jq && \
	libcap \
	openjdk8-jre && \
 echo "**** install ha-bridge ****" && \
 mkdir -p \
	/app && \
 habridge_url=$(curl -s https://api.github.com/repos/bwssytems/ha-bridge/releases/latest \
	| jq -r '.assets[].browser_download_url') && \
 curl -o \
 /app/ha-bridge.jar -L \
	"$habridge_url" && \
 echo "**** workaround to run habridge on port 80 as abc user ****" && \
 setcap cap_net_bind_service=+epi /usr/lib/jvm/java-1.8-openjdk/bin/java && \
 setcap cap_net_bind_service=+epi /usr/lib/jvm/java-1.8-openjdk/jre/bin/java && \
 echo "**** make architecture agnostic symlinks of java libs ****" && \
 find \
	/usr/lib/jvm/java-1.8-openjdk/jre \
	-type f \( -name "libjvm.so" -o -name "libjli.so" \) \
	-exec ln -sf {} /usr/lib/ \;

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 8080
VOLUME /config

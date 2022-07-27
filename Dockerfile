FROM ghcr.io/linuxserver/baseimage-alpine:3.13

# set version label
ARG BUILD_DATE
ARG VERSION
ARG HABRIDGE_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="saarg"

# install packages
RUN \
  echo "**** install runtime packages ****" && \
  apk add --no-cache \
    curl \
    jq \
    libcap \
    nss \
    openjdk8-jre \
    sqlite-libs && \
  echo "**** install ha-bridge ****" && \
  if [ -z ${HABRIDGE_RELEASE+x} ]; then \
    HABRIDGE_RELEASE=$(curl -sL "https://api.github.com/repos/bwssytems/ha-bridge/releases/latest" \
    | jq -r '.tag_name'); \
  fi && \
  mkdir -p \
    /app && \
  curl -o \
  /app/ha-bridge.jar -L \
    "https://github.com/bwssytems/ha-bridge/releases/download/${HABRIDGE_RELEASE}/ha-bridge-${HABRIDGE_RELEASE:1}.jar" && \
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

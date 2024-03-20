FROM ghcr.io/linuxserver/baseimage-alpine:3.19

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
    libcap \
    nss \
    openjdk17-jre \
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
    "https://github.com/bwssytems/ha-bridge/releases/download/${HABRIDGE_RELEASE}/ha-bridge-${HABRIDGE_RELEASE:1}.jar"

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 8080
VOLUME /config

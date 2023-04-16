FROM debian:bullseye-slim
LABEL authors="tkeil"
MAINTAINER "tkeil"

RUN \
    echo "deb http://deb.debian.org/debian bullseye-backports main contrib non-free" > /etc/apt/sources.list.d/backports.list; \
    apt update && \
    apt install -y git gpg makeself jq curl gh; \
    apt clean; \

ENTRYPOINT ["top", "-b"]
FROM alpine:3.5 as downloader
RUN apk add --no-cache wget tar xz

WORKDIR /tmp/
RUN \
    wget --no-check-certificate --progress=bar:force --output-document=basealt.tar.xz https://mirror.yandex.ru/altlinux-starterkits/release/alt-p8-ovz-generic-20171212-i586.tar.xz && \
    mkdir -p /alt/ && \
    tar -xJvf /tmp/basealt.tar.xz -C /alt/

FROM scratch
COPY --from=downloader /alt/ /
RUN \
    apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get -y install basesystem etcnet apt apt-repo bash && \
    apt-get clean

ENTRYPOINT /bin/bash
FROM scratch
ADD basealt.tar.xz /

RUN \
    apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get -y install basesystem etcnet apt apt-repo bash && \
    apt-get clean

ENTRYPOINT /bin/bash
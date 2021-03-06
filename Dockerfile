FROM owncloud/ubuntu:16.04

LABEL maintainer="ownCloud DevOps <devops@owncloud.com>" \
  org.label-schema.name="ownCloud CI Transifex" \
  org.label-schema.vendor="ownCloud GmbH" \
  org.label-schema.schema-version="1.0"

ENTRYPOINT ["/usr/bin/tx"]

RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
  echo "deb https://deb.nodesource.com/node_8.x xenial main" | tee /etc/apt/sources.list.d/node.list

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y git-core nodejs perl gettext liblocale-po-perl liblocale-gettext-perl python3 python3-pip && \
  pip3 install -U transifex-client==0.13.4 && \
  npm install -g yarn && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY rootfs /

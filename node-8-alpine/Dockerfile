FROM node:8-alpine

LABEL org.label-schema.schema-version = 1.0.0 \
    org.label-schema.vendor = mkenney@webbedlam.com \
    org.label-schema.vcs-url = https://github.com/mkenney/docker-npm \
    org.label-schema.description = "This image provides node based build tools." \
    org.label-schema.name = "NPM" \
    org.label-schema.url = http://mkenney.github.io/docker-npm/

ENV TERM=xterm \
    NLS_LANG=American_America.AL32UTF8 \
    LANG=C.UTF-8 \
    LANGUAGE=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    TIMEZONE=America/Denver

########################################################################
# Build tools
########################################################################
RUN set -x \
    && apk update \
    && apk add \
        ca-certificates \
        curl \
        git \
        gnupg \
        mercurial \
        shadow \
        subversion \
        sudo

RUN set -x \
    && touch /root/.profile \
    # Install node packages
    && npm install --silent -g \
        gulp-cli \
        grunt-cli \
        bower \
        markdown-styles \
    # Create a dev user to use as the directory owner
    && addgroup dev \
    && adduser -D -s /bin/sh -G dev dev \
    && echo "dev:password" | chpasswd \
    && curl --compressed -o- -L https://yarnpkg.com/install.sh | sh \
    # Setup wrapper scripts
    && curl -o /run-as-user https://raw.githubusercontent.com/mkenney/docker-scripts/master/container/run-as-user \
    && chmod 0755 /run-as-user

##############################################################################
# ~ fin ~
##############################################################################

RUN set -x \
    && apk del \
        curl \
        gnupg \
        linux-headers \
        paxctl \
        python \
        tar \
    && rm -rf \
        /var/cache/apk/* \
        ${NODE_PREFIX}/lib/node_modules/npm/man \
        ${NODE_PREFIX}/lib/node_modules/npm/doc \
        ${NODE_PREFIX}/lib/node_modules/npm/html


VOLUME /src
WORKDIR /src

ENTRYPOINT ["/run-as-user"]
CMD ["/usr/local/bin/npm"]

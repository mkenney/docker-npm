FROM node:11-alpine

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
        acl \
        ca-certificates \
        curl \
        git \
        gnupg \
        mercurial \
        rsync \
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
        npx \
    # Configure root account
    && echo "export NLS_LANG=$(echo $NLS_LANG)"                >> /root/.profile \
    && echo "export LANG=$(echo $LANG)"                        >> /root/.profile \
    && echo "export LANGUAGE=$(echo $LANGUAGE)"                >> /root/.profile \
    && echo "export LC_ALL=$(echo $LC_ALL)"                    >> /root/.profile \
    && echo "export TERM=xterm"                                >> /root/.profile \
    && echo "export PATH=$(echo $PATH)"                        >> /root/.profile \
    && echo "cd /src"                                          >> /root/.profile \
    # Create a dev user to use as the directory owner
    && addgroup dev \
    && adduser -D -s /bin/sh -G dev dev \
    && echo "dev:password" | chpasswd \
    && curl --compressed -o- -L https://yarnpkg.com/install.sh | sh \
    && rsync -a /root/ /home/dev/ \
    && chown -R dev:dev /home/dev/ \
    && chmod 0777 /home/dev \
    && chmod -R u+rwX,g+rwX,o+rwX /home/dev \
    && setfacl -R -d -m user::rwx,group::rwx,other::rwx /home/dev \
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
        rsync \
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

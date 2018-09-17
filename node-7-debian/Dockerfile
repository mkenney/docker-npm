FROM node:7-wheezy

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

RUN set -x \
    && apt-get -qq update \
    && apt-get install -qqy apt-transport-https apt-utils \
    && apt-get -qq upgrade \
    && apt-get -qq dist-upgrade \
    && apt-get -qq update \
    && apt-get install -qqy \
        acl \
        git \
        mercurial \
        rsync \
        subversion \
        sudo \
        wget \
    # Restore a borne-shell compatible default shell
    && rm /bin/sh \
    && ln -s /bin/bash /bin/sh

# install npm packages
RUN set -x \
    && npm install --silent --global \
        gulp-cli \
        grunt-cli \
        bower \
        markdown-styles \
        npx \
    && curl --compressed -o- -L https://yarnpkg.com/install.sh | sh

##############################################################################
# UTF-8 Locale, timezone
##############################################################################

RUN set -x \
    && apt-get install -qqy locales \
    && locale-gen C.UTF-8 ${UTF8_LOCALE} \
    && dpkg-reconfigure locales \
    && /usr/sbin/update-locale LANG=C.UTF-8 LANGUAGE=C.UTF-8 LC_ALL=C.UTF-8 \
    && export LANG=C.UTF-8 \
    && export LANGUAGE=C.UTF-8 \
    && export LC_ALL=C.UTF-8 \
    && echo $TIMEZONE > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata

##############################################################################
# users
##############################################################################

RUN set -x \
    # Configure root account
    && echo "export NLS_LANG=$(echo $NLS_LANG)"                >> /root/.bash_profile \
    && echo "export LANG=$(echo $LANG)"                        >> /root/.bash_profile \
    && echo "export LANGUAGE=$(echo $LANGUAGE)"                >> /root/.bash_profile \
    && echo "export LC_ALL=$(echo $LC_ALL)"                    >> /root/.bash_profile \
    && echo "export TERM=xterm"                                >> /root/.bash_profile \
    && echo "export PATH=$(echo $PATH)"                        >> /root/.bash_profile \
    && echo "cd /src"                                          >> /root/.bash_profile \
    && echo "source \$HOME/.bashrc"                            >> /root/.bash_profile \
    # Add a dev user and configure
    && groupadd dev \
    && useradd dev -s /bin/bash -m -g dev \
    && echo "dev:password" | chpasswd \
    && echo "dev ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && rsync -a /root/ /home/dev/ \
    && chown -R dev:dev /home/dev/ \
    && chmod 0777 /home/dev \
    && chmod -R u+rwX,g+rwX,o+rwX /home/dev \
    && setfacl -R -d -m user::rwx,group::rwx,other::rwx /home/dev

##############################################################################
# ~ fin ~
##############################################################################

RUN set -x \
    && wget -O /run-as-user https://raw.githubusercontent.com/mkenney/docker-scripts/master/container/run-as-user \
    && chmod 0755 /run-as-user \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

VOLUME /src
WORKDIR /src

ENTRYPOINT ["/run-as-user"]
CMD ["/usr/local/bin/npm"]

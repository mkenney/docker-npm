FROM node:latest

MAINTAINER Michael Kenney <mkenney@webbedlam.com>

ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8
ENV PATH /root/bin:$PATH
ENV NLS_LANG American_America.AL32UTF8
ENV TIMEZONE America/Denver
ENV TERM xterm

RUN set -x \
    # the 'node' UID and GID are 1000 which conflicts with common users/groups
    && node_uid=$(id -u node) \
    && node_gid=$(id -g node) \
    && groupmod -g 200 -o node \
    && usermod -u 200 -o node \
    && find / -group $node_gid | xargs chgrp node \
    && find / -user $node_uid | xargs chown node \

    && apt-get -qq update \
    && apt-get install -qqy apt-utils \
    && apt-get -qq upgrade \
    && apt-get -qq dist-upgrade \
    && apt-get install -qqy \
        git \
        mercurial \
        rsync \
        subversion \
        sudo \
        wget \

    # install npm packages
    && rm -f /usr/local/bin/yarn \
    && npm install --silent -g \
        gulp-cli \
        grunt-cli \
        bower \
        markdown-styles \
        yarn \
    && chown -R node:node /usr/local/lib/node_modules \

    # Restore a borne-shell compatible default shell
    && rm /bin/sh \
    && ln -s /bin/bash /bin/sh

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

    # Add a dev user and configure
    && groupadd dev \
    && useradd dev -s /bin/bash -m -g dev \
    && echo "dev:password" | chpasswd \
    && echo "dev ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && rsync -a /root/ /home/dev/ \
    && chown -R dev:dev /home/dev/ \
    && chmod 0777 /home/dev

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

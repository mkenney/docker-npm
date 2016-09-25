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
    && npm install --silent -g \
        gulp-cli \
        grunt-cli \
        bower \
        markdown-styles \

##############################################################################
# UTF-8 Locale, timezone
##############################################################################

    && apt-get install -qqy locales \
    && locale-gen C.UTF-8 ${UTF8_LOCALE} \
    && dpkg-reconfigure locales \
    && /usr/sbin/update-locale LANG=C.UTF-8 LANGUAGE=C.UTF-8 LC_ALL=C.UTF-8 \
    && export LANG=C.UTF-8 \
    && export LANGUAGE=C.UTF-8 \
    && export LC_ALL=C.UTF-8 \
    && echo $TIMEZONE > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata \

##############################################################################
# users
##############################################################################

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
    && chmod 0777 /home/dev \

##############################################################################
# ~ fin ~
##############################################################################

    && wget -O /run-as-user https://raw.githubusercontent.com/mkenney/docker-scripts/master/container/run-as-user \
    && chmod 0755 /run-as-user \

    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

VOLUME /src
WORKDIR /src

CMD ["/run-as-user", "/usr/local/bin/npm"]

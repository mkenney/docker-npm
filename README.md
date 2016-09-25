![MIT License](https://img.shields.io/github/license/mkenney/docker-npm.svg) ![Docker pulls](https://img.shields.io/docker/pulls/mkenney/npm.svg) ![Docker stars](https://img.shields.io/docker/stars/mkenney/npm.svg) ![Github issues](https://img.shields.io/github/issues-raw/mkenney/docker-npm.svg)

# Portable npm and related executables

- [Tagged Dockerfiles](#tagged-dockerfiles)
- [About](#about)
- [Image](#image)
- [Change log](#change-log)

## Tagged Dockerfiles

* [`latest` Dockerfile](https://github.com/mkenney/docker-npm/blob/master/Dockerfile), [`alpine` Dockerfile](https://github.com/mkenney/docker-npm/blob/master/Dockerfile)

  ![build status](https://travis-ci.org/mkenney/docker-npm.svg?branch=master) ![Image size](https://img.shields.io/badge/image size-62MB-blue.svg)
  * ![bower](https://img.shields.io/badge/bower-v1.7.9-ffcc2f.svg)
  * ![generate-md](https://img.shields.io/badge/generate%20md-v3.1.6-000000.svg)
  * ![grunt](https://img.shields.io/badge/grunt-v1.2.0-e48632.svg)
  * ![gulp](https://img.shields.io/badge/gulp-v1.2.1-cf4646.svg)
  * ![node](https://img.shields.io/badge/node-v6.2.2-026e00.svg)
  * ![npm](https://img.shields.io/badge/npm-v3.10.2-c12127.svg)

* [`debian` Dockerfile](https://github.com/mkenney/docker-npm/blob/master/Dockerfile)

  ![build status](https://travis-ci.org/mkenney/docker-npm.svg?branch=debian) ![Image size](https://img.shields.io/badge/image size-~300MB-blue.svg)
  * ![bower](https://img.shields.io/badge/bower-v1.7.9-ffcc2f.svg)
  * ![generate-md](https://img.shields.io/badge/generate%20md-v3.1.8-000000.svg)
  * ![grunt](https://img.shields.io/badge/grunt-v1.2.0-e48632.svg)
  * ![gulp](https://img.shields.io/badge/gulp-v1.2.2-cf4646.svg)
  * ![node](https://img.shields.io/badge/node-v6.2.0-026e00.svg)
  * ![npm](https://img.shields.io/badge/npm-v3.10.3-c12127.svg)

## About

Essentially, this is just a set of [shell scripts](https://github.com/mkenney/docker-npm/tree/master/bin) that manages a [Node.js](https://nodejs.org/) docker image. The docker image includes a script that allows commands to run as either the current user or the owner/group of the current directory, which the shell scripts take advantage of to make sure files are written with permissions that match the current directory.

### Installation

This assumes that you already have [Docker](https://www.docker.com) installed. A running `docker` daemon is required. You probably want to be able to [run docker commands without sudo](https://docs.docker.com/v1.8/installation/ubuntulinux/#create-a-docker-group), but even if you excute the scripts with sudo files will be written with the appropriate `uid` and `gid`.

The following wrapper scripts are available in the source repository:

* [`bower`](https://github.com/mkenney/docker-npm/blob/master/bin/bower)
* [`generate-md`](https://github.com/mkenney/docker-npm/blob/master/bin/generate-md)
* [`grunt`](https://github.com/mkenney/docker-npm/blob/master/bin/grunt)
* [`gulp`](https://github.com/mkenney/docker-npm/blob/master/bin/gulp)
* [`node`](https://github.com/mkenney/docker-npm/blob/master/bin/node)
* [`npm`](https://github.com/mkenney/docker-npm/blob/master/bin/npm)

Installation is just a matter of putting them somewhere in your path and making them executable. I like to put my scripts in a `bin/` folder in my home directory:

#### alpine:3.4

In the Alpine version `node` is compiled from source and is very small and lightweight

* `wget -nv -O ~/bin/bower https://raw.githubusercontent.com/mkenney/docker-npm/master/bin/bower && chmod 0755 ~/bin/bower`
* `wget -nv -O ~/bin/generate-md https://raw.githubusercontent.com/mkenney/docker-npm/master/bin/generate-md && chmod 0755 ~/bin/generate-md`
* `wget -nv -O ~/bin/grunt https://raw.githubusercontent.com/mkenney/docker-npm/master/bin/grunt && chmod 0755 ~/bin/grunt`
* `wget -nv -O ~/bin/gulp https://raw.githubusercontent.com/mkenney/docker-npm/master/bin/gulp && chmod 0755 ~/bin/gulp`
* `wget -nv -O ~/bin/node https://raw.githubusercontent.com/mkenney/docker-npm/master/bin/node && chmod 0755 ~/bin/node`
* `wget -nv -O ~/bin/npm https://raw.githubusercontent.com/mkenney/docker-npm/master/bin/npm && chmod 0755 ~/bin/npm`

#### debian:jessie

The Debian version is based on `node:latest` and the image is fairly large. Some build tools (gcc, g++, make, etc.) so packages like `node-sass` can use them

* `wget -nv -O ~/bin/bower https://raw.githubusercontent.com/mkenney/docker-npm/debian/bin/bower && chmod 0755 ~/bin/bower`
* `wget -nv -O ~/bin/generate-md https://raw.githubusercontent.com/mkenney/docker-npm/debian/bin/generate-md && chmod 0755 ~/bin/generate-md`
* `wget -nv -O ~/bin/grunt https://raw.githubusercontent.com/mkenney/docker-npm/debian/bin/grunt && chmod 0755 ~/bin/grunt`
* `wget -nv -O ~/bin/gulp https://raw.githubusercontent.com/mkenney/docker-npm/debian/bin/gulp && chmod 0755 ~/bin/gulp`
* `wget -nv -O ~/bin/node https://raw.githubusercontent.com/mkenney/docker-npm/debian/bin/node && chmod 0755 ~/bin/node`
* `wget -nv -O ~/bin/npm https://raw.githubusercontent.com/mkenney/docker-npm/debian/bin/npm && chmod 0755 ~/bin/npm`

#### Updating

* `bower self-update`
* `generate self-update`
* `grunt self-update`
* `gulp self-update`
* `node self-update`
* `npm self-update`

Each of the scripts have a `self-update` command which pulls down the latest docker image (which all the scripts share) and then updates the shell script itself. If you don't have write permissions on the shell script you'll get a permissions error, you can run the self-update command with `sudo` if needed. At the time of this writing, I expect the shell scripts, which couldn't be much simpler, probably won't change so a simple `docker pull mkenney/npm:{version}` should generally be enough.

## Image

These [images](https://hub.docker.com/r/mkenney/npm/tags/) contain the latest stable `node` and `npm` binaries for [`debian:jessie`](https://hub.docker.com/_/debian/) and [`alpine:3.4`](https://hub.docker.com/_/alpine/). `npm` has been used to install various build tools globally. When using the [shell scripts](https://github.com/mkenney/docker-npm/tree/master/bin) available in the [source repository](https://github.com/mkenney/docker-npm), the current directory is mounted into `/src` in the container and a [wrapper script](https://github.com/mkenney/docker-scripts/blob/master/container/run-as-user) executes `npm` as a user who's `uid` and `gid` matches those properties on that directory. This way any output is written as the directory owner/group instead of root or a random user.

If you need additional modules and/or wrapper scripts [let me know](https://github.com/mkenney/docker-npm/issues).

## Change log

### 2016-09-17

Because it produces a much smaller image, I have moved the Alpine build into the `master` branch and the Debian build into it's own `debian` branch and made corresponding changes on [hub.docker.com](https://hub.docker.com/r/mkenney/npm/).

I added the `--allow-root` option to the `bower` script to resolve [issue #4](https://github.com/mkenney/docker-npm/issues/4).

I merged [a PR](https://github.com/mkenney/docker-npm/pull/5) to prevent ssl certificate issues in `self-update` commands.

I updated the `self-update` command in the scripts to resolve [issue #8](https://github.com/mkenney/docker-npm/issues/8).

### 2016-08-29

I have added a markdown-to-html generator for static documentation ([`markdown-styles`](https://www.npmjs.com/package/markdown-styles)) and a script to run it ([`generate-md`](https://github.com/mkenney/docker-npm/blob/master/bin/generate-md)).

I also removed the dev user from the root group, the way it was setup new files were owned by root because it was the default group. Please [let me know](https://github.com/mkenney/docker-npm/issues) if that change causes any issues.

### 2016-07-13

I have re-structured automated the Docker Hub builds, they are no longer triggered by GitHub pushes. Instead they are triggered by a deployment script that is executed on successful `travis-ci` builds. This way, even if builds are failing the image on DockerHub should remain the last stable image at all times.

There may be an issue with API call throttling on the Docker Hub side, if that seems to be happening I'll dig in further.

I also fixed an issue with the path in the source URL that had been preventing successuful alpine builds for a few days.

Please [let me know](https://github.com/mkenney/docker-phpunit/issues) if you have any problems.

### 2016-07-05

Fixed a string-comparison issue on logins where the default shell is Bourne shell rather than Bourne again shell.

Please [let me know](https://github.com/mkenney/docker-npm/issues) if you have any problems.

### 2016-06-29

Added updating `npm` to the latest stable version in the `debian` image. I changed to compiling `node` from source in the `alpine` image because the version installed by `n` was compiled with a different prefix than the `apk` packages which made a mess. I also to use the same prefix as the `node:latest` image.

I also added some simple checks to the travis-ci configuration to catch the issue I found the other day with the missing `shadow` package.

Please [let me know](https://github.com/mkenney/docker-npm/issues) if you run into any problems.

### 2016-06-28

alpine:latest doesn't have the `shadow` available (at the moment) so the `/run-as-user` script wasn't functioning correctly. I added the `edge/testing` repo, installed `shadow` and also went ahead and updated `npm` to the latest available version (`3.10.2`).

Please [let me know](https://github.com/mkenney/docker-npm/issues) if you run into any problems.

### 2016-06-23

* Added `bower` to the image and a [wrapper script](https://github.com/mkenney/docker-npm/blob/master/bin/bower) to the repository.
* Added a `node` [wrapper script](https://github.com/mkenney/docker-npm/blob/master/bin/node) to the repository.
* Added mounting your `~/.ssh/` directory into the container to support access to private repositories. If that directory is mounted, then `npm` and `bower` will run as the `uid`/`gid` that owns that `~/.ssh/` directory (hopefully you), otherwise it will run as the project directories `uid` and `gid` as usual.
* Updated all the wrapper scripts to use variables for the image tag and github branch to make merges simpler
* Created a [tagged](https://hub.docker.com/r/mkenney/npm/tags/) version of the image based on [`alpine:latest`](https://hub.docker.com/_/alpine/)

Please [let me know](https://github.com/mkenney/docker-npm/issues) if you run into any problems.

### 2016-06-06

I modified the `run-as-user` script so that it doesn't require specifying which user account in the container that should be modified, and instead will always modify the `dev` user. This required updating both the image and the wrapper scripts, if you use the wrapper scripts you should run:
* `sudo npm self-update`
* `sudo gulp self-update`
* `sudo grunt self-update`

### 2016-06-03

I removed the `as-user` script and put it in a [separate repo](https://github.com/mkenney/docker-scripts/blob/master/container/run-as-user) as it's used in several images. [Let me know](https://github.com/mkenney/docker-npm/issues) if you have any trouble, this is the first image I've switched over.

### 2016-05-25

#### Breaking changes

I have added a wrapper script to the container that executes `npm`, `gulp` and `grunt` commands as a user who's `uid` and `gid` matches those properties on the current directory. This way any files are installed as the directory owner/group instead of root or a random user.

If you've been using the [previous version](https://github.com/mkenney/docker-npm/tree/deprecated/bin) of the included shell scripts from the project's `/bin` directory you will probably need to update the permissions of files created using them or the new scripts are likely to have permissions errors because previously the files would have been created by the `root` user. This command should take care of it for you but _make sure you understand what it will do **before** you run it_. I can't help you if you hose your system.

* From your **_project directory_**: `sudo chown -R $(stat -c '%u' .):$(stat -c '%g' .) ./`

If you haven't been using the included scripts, then you don't need to do anything.

If you need to use the [previous version](https://github.com/mkenney/docker-npm/tree/deprecated) of this image it's [tagged](https://hub.docker.com/r/mkenney/npm/tags/) as `deprecated` but the image is still rebuilt automatically when there are changes to [node:latest](https://hub.docker.com/_/node/) or [Debian:jessie](https://hub.docker.com/_/debian/) so it will stay up to date.

## Source Repo

[mkenney/docker-npm](https://github.com/mkenney/docker-npm)

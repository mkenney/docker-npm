![MIT License](https://img.shields.io/github/license/mkenney/docker-npm.svg) ![Docker pulls](https://img.shields.io/docker/pulls/mkenney/npm.svg) ![Docker stars](https://img.shields.io/docker/stars/mkenney/npm.svg) ![Github issues](https://img.shields.io/github/issues-raw/mkenney/docker-npm.svg)

# Portable npm and related executables

- [Tagged Dockerfiles](#tagged-dockerfiles)
- [About](#about)
- [Image](#image)
- [Change log](#change-log)

## Tagged Dockerfiles

* [`latest`](https://github.com/mkenney/docker-npm/blob/master/Dockerfile), [`debian`](https://github.com/mkenney/docker-npm/blob/master/Dockerfile)

  ![build status](https://travis-ci.org/mkenney/docker-npm.svg?branch=master) ![Image size](https://img.shields.io/badge/image size-286MB-blue.svg) ![Node.js](https://img.shields.io/badge/Node.js-v6.2.2-026e00.svg) ![npm](https://img.shields.io/badge/npm-v3.9.5-c12127.svg) ![Bower](https://img.shields.io/badge/Bower-v1.7.9-ffcc2f.svg) ![gulp](https://img.shields.io/badge/gulp-v1.2.1-cf4646.svg) ![grunt](https://img.shields.io/badge/Grunt-v1.2.0-e48632.svg)

* [`alpine`](https://github.com/mkenney/docker-npm/blob/alpine/Dockerfile)

  ![build status](https://travis-ci.org/mkenney/docker-npm.svg?branch=alpine) ![Image size](https://img.shields.io/badge/image size-48MB-blue.svg) ![Node.js](https://img.shields.io/badge/Node.js-v6.2.0-026e00.svg) ![npm](https://img.shields.io/badge/npm-v3.10.2-c12127.svg) ![Bower](https://img.shields.io/badge/Bower-v1.7.9-ffcc2f.svg) ![gulp](https://img.shields.io/badge/gulp-v1.2.1-cf4646.svg) ![grunt](https://img.shields.io/badge/Grunt-v1.2.0-e48632.svg)

## About

Essentially, this is just a set of [shell scripts](https://github.com/mkenney/docker-npm/tree/master/bin) that manages a [Node.js](https://nodejs.org/) docker image. The docker image includes a script that allows commands to run as either the current user or the owner/group of the current directory, which the shell scripts take advantage of to make sure files are written with permissions that match the current directory.

### Installation

This assumes that you already have [Docker](https://www.docker.com) installed. A running `docker` daemon is required.

The following wrapper scripts are available in the source repository

* [`bower`](https://github.com/mkenney/docker-npm/blob/master/bin/bower)
* [`grunt`](https://github.com/mkenney/docker-npm/blob/master/bin/grunt)
* [`gulp`](https://github.com/mkenney/docker-npm/blob/master/bin/gulp)
* [`node`](https://github.com/mkenney/docker-npm/blob/master/bin/node)
* [`npm`](https://github.com/mkenney/docker-npm/blob/master/bin/npm)

Installation is just a matter of putting them somewhere in your path and making them executable. I like to put my scripts in a `bin/` folder in my home directory:

#### debian:jessie

Debian (at the time of this writing) has a slightly more up-to-date version of `node` but the image is fairly large.

* `wget -nv -O ~/bin/bower https://raw.githubusercontent.com/mkenney/docker-npm/master/bin/bower && chmod 0755 ~/bin/bower`
* `wget -nv -O ~/bin/grunt https://raw.githubusercontent.com/mkenney/docker-npm/master/bin/grunt && chmod 0755 ~/bin/grunt`
* `wget -nv -O ~/bin/gulp https://raw.githubusercontent.com/mkenney/docker-npm/master/bin/gulp && chmod 0755 ~/bin/gulp`
* `wget -nv -O ~/bin/node https://raw.githubusercontent.com/mkenney/docker-npm/master/bin/node && chmod 0755 ~/bin/node`
* `wget -nv -O ~/bin/npm https://raw.githubusercontent.com/mkenney/docker-npm/master/bin/npm && chmod 0755 ~/bin/npm`

#### alpine:latest

Alpine (at the time of this writing) has a slightly newer version of `npm` and the image is very small and lightweight.

* `wget -nv -O ~/bin/bower https://raw.githubusercontent.com/mkenney/docker-npm/alpine/bin/bower && chmod 0755 ~/bin/bower`
* `wget -nv -O ~/bin/grunt https://raw.githubusercontent.com/mkenney/docker-npm/alpine/bin/grunt && chmod 0755 ~/bin/grunt`
* `wget -nv -O ~/bin/gulp https://raw.githubusercontent.com/mkenney/docker-npm/alpine/bin/gulp && chmod 0755 ~/bin/gulp`
* `wget -nv -O ~/bin/node https://raw.githubusercontent.com/mkenney/docker-npm/alpine/bin/node && chmod 0755 ~/bin/node`
* `wget -nv -O ~/bin/npm https://raw.githubusercontent.com/mkenney/docker-npm/alpine/bin/npm && chmod 0755 ~/bin/npm`

#### Updating

* `bower self-update`
* `grunt self-update`
* `gulp self-update`
* `node self-update`
* `npm self-update`

Each of the scripts have a `self-update` command which pulls down the latest docker image (which all the scripts share) and then updates the shell script itself. If you don't have write permissions on the shell script you'll get a permissions error, you can run the self-update command with `sudo` if needed. At the time of this writing, I expect the shell scripts, which couldn't be much simpler, probably won't change so a simple `docker pull mkenney/npm:{version}` should generally be enough.

## Image

These [images](https://hub.docker.com/r/mkenney/npm/tags/) contain the latest `node` and `npm` binaries for [`debian:jessie`](https://hub.docker.com/_/debian/) and [`alpine:latest`](https://hub.docker.com/_/alpine/) (currently v3.4) installed via their respective package managers. `npm` has been used to install `bower`, `gulp-cli` and `grunt-cli` globally. When using the [shell scripts](https://github.com/mkenney/docker-npm/tree/master/bin) available in the [source repository](https://github.com/mkenney/docker-npm), the current directory is mounted into `/src` in the container and a [wrapper script](https://github.com/mkenney/docker-scripts/blob/master/container/run-as-user) executes `npm` as a user who's `uid` and `gid` matches those properties on that directory. This way any output is written as the directory owner/group instead of root or a random user.

If you need additional modules and/or wrapper scripts [let me know](https://github.com/mkenney/docker-npm/issues).

## Change log

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

# npm

[![dockeri.co](http://dockeri.co/image/mkenney/npm)](https://hub.docker.com/r/mkenney/npm/)

[![MIT License](https://img.shields.io/github/license/mkenney/docker-npm.svg)](https://raw.githubusercontent.com/mkenney/docker-npm/master/LICENSE) [![Github issues](https://img.shields.io/github/issues-raw/mkenney/docker-npm.svg)](https://github.com/mkenney/docker-npm/issues) [![build status](https://travis-ci.org/mkenney/docker-npm.svg?branch=master)](https://travis-ci.org/mkenney/docker-npm)

## Portable `node`, package managers and build tools

- [Tagged Dockerfiles](#tagged-dockerfiles)
- [About](#about)
- [Images](#images)
- [Installation](#installation)
- [Change log](#change-log)

### Tagged Dockerfiles

* [`latest`, `alpine` Dockerfile](https://github.com/mkenney/docker-npm/blob/master/Dockerfile)

  ![Image size](https://img.shields.io/badge/image%20size-124MB-blue.svg) This image is under development and may not be as stable as versioned images. This image is based on a recent version of [alpine](https://hub.docker.com/_/alpine/) and compiles a recent version of `node` from source. Package versions are not pinned, instead `https://npmjs.org/install.sh` is executed to install a current version of `npm`, which is then used to install current versions of the packages.

* [`debian` Dockerfile](https://github.com/mkenney/docker-npm/blob/master/Dockerfile)

  ![Image size](https://img.shields.io/badge/image%20size-308MB-blue.svg) This image is under development and may not be as stable as versioned images. This image is based on [`node:latest`](https://hub.docker.com/r/library/node/tags/latest/). Package versions are not pinned, instead the included `npm` executable is used to install current versions of the packages.

* [`7.0-alpine` Dockerfile](https://github.com/mkenney/docker-npm/blob/7.0-alpine/Dockerfile)

  ![Image size](https://img.shields.io/badge/image%20size-124MB-blue.svg) Based on [`alpine:3.4`](https://hub.docker.com/r/library/alpine/tags/3.4/) with `node` v7.0 compiled from source.

* [`7.0-debian` Dockerfile](https://github.com/mkenney/docker-npm/blob/7.0-debian/Dockerfile)

  ![Image size](https://img.shields.io/badge/image%20size-266MB-blue.svg) Based on[`node:7.0-wheezy`](https://hub.docker.com/r/library/node/tags/7.0-wheezy/).

* [`6.9-alpine` Dockerfile](https://github.com/mkenney/docker-npm/blob/6.9-alpine/Dockerfile)

  ![Image size](https://img.shields.io/badge/image%20size-122MB-blue.svg) Based on [`alpine:3.4`](https://hub.docker.com/r/library/alpine/tags/3.4/) with `node` v6.9 compiled from source.

* [`6.9-debian` Dockerfile](https://github.com/mkenney/docker-npm/blob/6.9-debian/Dockerfile)

  ![Image size](https://img.shields.io/badge/image%20size-254MB-blue.svg) Based on[`node:6.9-wheezy`](https://hub.docker.com/r/library/node/tags/6.9-wheezy/).

### About

Essentially, this is just a set of [shell scripts](https://github.com/mkenney/docker-npm/tree/master/bin) that manage a [Node.js](https://nodejs.org/) docker image. The docker image includes a script ([`run-as-user`](https://github.com/mkenney/docker-scripts/tree/master/container)) that allows commands to run as either the current user or the owner/group of the current directory, which the shell scripts take advantage of to make sure files are written with your preferred permissions rather than root.

#### Images

The [images](https://hub.docker.com/r/mkenney/npm/tags/) contain the latest stable `node` and `npm` binaries for [`debian:jessie`](https://hub.docker.com/_/debian/) and [`alpine:3.4`](https://hub.docker.com/_/alpine/). `npm` has been used to install various build tools globally. When using the [shell scripts](https://github.com/mkenney/docker-npm/tree/master/bin) available in the [source repository](https://github.com/mkenney/docker-npm), the current directory is mounted into `/src` in the container and a [wrapper script](https://github.com/mkenney/docker-scripts/blob/master/container/run-as-user) executes `npm` as a user who's `uid` and `gid` matches those properties on that directory. This way any output is written as the directory owner/group instead of root or a random user.

If you need additional modules and/or wrapper scripts [let me know](https://github.com/mkenney/docker-npm/issues).

#### Installation

This assumes that you already have [Docker](https://www.docker.com) installed. A running `docker` daemon is required. You probably want to be able to [run docker commands without sudo](https://docs.docker.com/v1.8/installation/ubuntulinux/#create-a-docker-group), but even if you excute the scripts with sudo files will be written with the appropriate `uid` and `gid`.

Several wrapper scripts are available in the source repository:

* [`bower`](https://github.com/mkenney/docker-npm/blob/master/bin/bower)
* [`generate-md`](https://github.com/mkenney/docker-npm/blob/master/bin/generate-md)
* [`grunt`](https://github.com/mkenney/docker-npm/blob/master/bin/grunt)
* [`gulp`](https://github.com/mkenney/docker-npm/blob/master/bin/gulp)
* [`node`](https://github.com/mkenney/docker-npm/blob/master/bin/node)
* [`npm`](https://github.com/mkenney/docker-npm/blob/master/bin/npm)
* [`yarn`](https://github.com/mkenney/docker-npm/blob/master/bin/yarn)

Installation is just a matter of putting them somewhere in your path and making them executable. An [installation script](https://github.com/mkenney/docker-npm/blob/master/bin/install.sh) is available and can be executed with a shell `curl`+`sh -s` command. Simply pass in your command arguments normally.

```
Usage
  install.sh COMMAND [TAG [PREFIX]]

Synopsys
  Install a mkenney/npm container execution script locally

Options
  COMMAND  - Required, the name of the command to install (bower, gulp, npm, etc.)
  TAG      - Optional, the image tag to use. Default 'latest'
  PREFIX   - Optional, the location to install the command script. Default '$HOME/bin'

Examples
  $ curl -L https://raw.githubusercontent.com/mkenney/docker-npm/master/bin/install.sh | bash -s gulp 7.0-alpine $HOME/bin
  $ bash ./install.sh gulp 7.0-alpine $HOME/bin
```

##### Updating

* `[command] self-update`

  Each of the scripts have a `self-update` command which pulls down the latest docker image (which all the scripts share) and then updates the shell script itself. If you don't have write permissions on the shell script you'll get a permissions error, you can run the self-update command with `sudo` if necessary.

### Change log

#### 2017-04-12

Added support for specifying the user and group ids you want to run your container commands to the `/run-as-user` script via `docker run` execution: https://github.com/mkenney/docker-scripts/pull/1/files

To use this behavior, you can pass `PUID` and `PGID` environment variables when you execute the container:

```bash
  docker run \
      --rm \
      -ti \
      -v $(pwd):/src:rw \
      -e "PUID=<user id>" \
      -e "PGID=<group id>" \
      mkenney/npm:latest <commands>
```

Also added support for using the `/run-as-user` script as an entrypoint and updated this `Dockerfile` to use it as an entrypoint, hopefully simplifying and clairifying `docker run` statements. This should not be a breaking change for any scripts that were taking advantage of the `CMD` behavior. https://github.com/mkenney/docker-scripts/pull/2/files

Please [let me know](https://github.com/mkenney/docker-npm/issues) if you have any problems.

#### 2016-11-13

* Created "stable" branches for node v6.9 images
* More performance updates to the CI integration

Please [let me know](https://github.com/mkenney/docker-npm/issues) if you have any problems.

#### 2016-11-08

* Modified the `alpine`-based dockerfiles to retain the build tools

  This change increases the image size by ~45MB but its still around 1/2 the size of the `debian`-based images.

Please [let me know](https://github.com/mkenney/docker-npm/issues) if you have any problems.

#### 2016-11-06

* Added an install script to easily install the command wrapper scripts locally
* Added `travis-ci` tests to test and validate both the installation script and the individual wrapper scripts
  * The install script is using `bash` instead of `sh` because the version of `sh` installed on `travis-ci` would constantly have a syntax error on the `usage` function definition, regardless of how it was defined. Both of these failed:

    ```sh
function usage {
    ...
}
```

      ```sh
usage() {
    ...
}
```

      At some point I'll get that figured out and switch it back to `sh`.

Please [let me know](https://github.com/mkenney/docker-npm/issues) if you have any problems.

#### 2016-11-03

* Added tty detection to the shell scripts to alter the way the container is executed with piped input.

Please [let me know](https://github.com/mkenney/docker-npm/issues) if you have any problems.

#### 2016-11-02

* Upgraded `node` to 7.0.0 in the `alpine` image.
* Created "stable" branches for the 7.0 images
* Merged a [change to the wrapper scripts](https://github.com/mkenney/docker-npm/pull/25) to resolve a [reported issue](https://github.com/mkenney/docker-npm/issues/24). This change reverts the 2016-07-05 changes.

Please [let me know](https://github.com/mkenney/docker-npm/issues) if you have any problems.

#### 2016-10-20

* Added support for the `yarn` package manager. [issue](https://github.com/mkenney/docker-npm/issues/19), [pr](https://github.com/mkenney/docker-npm/pull/20)

Please [let me know](https://github.com/mkenney/docker-npm/issues) if you have any problems.

#### 2016-09-17

##### Tag changes, possibly breaking

* Because it produces a much smaller image, I have moved the Alpine build into the `master` branch and the Debian build into it's own `debian` branch and made corresponding changes on [hub.docker.com](https://hub.docker.com/r/mkenney/npm/).
* Added the `--allow-root` option to the `bower` script to resolve [issue #4](https://github.com/mkenney/docker-npm/issues/4).
* Merged [a PR](https://github.com/mkenney/docker-npm/pull/5) to prevent ssl certificate issues in `self-update` commands.
* Updated the `self-update` command in the scripts to resolve [issue #8](https://github.com/mkenney/docker-npm/issues/8).

Please [let me know](https://github.com/mkenney/docker-npm/issues) if you have any problems.

#### 2016-08-29

* Added a markdown-to-html generator for static documentation ([`markdown-styles`](https://www.npmjs.com/package/markdown-styles)) and a script to run it ([`generate-md`](https://github.com/mkenney/docker-npm/blob/master/bin/generate-md)).
* Removed the dev user from the root group, the way it was setup new files were owned by root because it was the default group.

Please [let me know](https://github.com/mkenney/docker-npm/issues) if that change causes any issues.

#### 2016-07-13

* Re-structured automated the Docker Hub builds, they are no longer triggered by GitHub pushes. Instead they are triggered by a deployment script that is executed on successful `travis-ci` builds. This way, even if builds are failing the image on DockerHub should remain the last stable image at all times.
  * There may be an issue with API call throttling on the Docker Hub side, if that seems to be happening I'll dig in further.
* Fixed an issue with the path in the source URL that had been preventing successuful alpine builds for a few days.

Please [let me know](https://github.com/mkenney/docker-npm/issues) if you have any problems.

#### 2016-07-05

* Fixed a string-comparison issue on logins where the default shell is Bourne shell rather than Bourne again shell.

Please [let me know](https://github.com/mkenney/docker-npm/issues) if you have any problems.

#### 2016-06-29

* Added updating `npm` to the latest stable version in the `debian` image.
* Changed to compiling `node` from source in the `alpine` image because the version installed by `n` was compiled with a different prefix than the `apk` packages which made a mess. I set the build to use the same install prefix as the `node:latest` image (`/usr/local`).
* Added some simple checks to the travis-ci configuration to catch the 2016-06-28 issue with the missing `shadow` package.

Please [let me know](https://github.com/mkenney/docker-npm/issues) if you run into any problems.

#### 2016-06-28

* `alpine:latest` doesn't have the `shadow` available (at the moment) so the `/run-as-user` script wasn't functioning correctly. Added the `edge/testing` repo, installed `shadow` and also went ahead and updated `npm` to the latest available version (`3.10.2`).

Please [let me know](https://github.com/mkenney/docker-npm/issues) if you run into any problems.

#### 2016-06-23

* Added `bower` to the image and a [wrapper script](https://github.com/mkenney/docker-npm/blob/master/bin/bower) to the repository.
* Added a `node` [wrapper script](https://github.com/mkenney/docker-npm/blob/master/bin/node) to the repository.
* Added mounting your `~/.ssh/` directory into the container to support access to private repositories. If that directory is mounted, then `npm` and `bower` will run as the `uid`/`gid` that owns that `~/.ssh/` directory (hopefully you), otherwise it will run as the project directories `uid` and `gid` as usual.
* Updated all the wrapper scripts to use variables for the image tag and github branch to make merges simpler
* Created a [tagged](https://hub.docker.com/r/mkenney/npm/tags/) version of the image based on [`alpine:latest`](https://hub.docker.com/_/alpine/)

Please [let me know](https://github.com/mkenney/docker-npm/issues) if you run into any problems.

#### 2016-06-06

* Modified the `run-as-user` script so that it doesn't require specifying which user account in the container should be modified
  * Instead, always modify the `dev` user. This required updating both the image and the wrapper scripts, if you use the wrapper scripts you should run:
    * `sudo npm self-update`
    * `sudo gulp self-update`
    * `sudo grunt self-update`

#### 2016-06-03

Removed the `as-user` script (and renamed it `run-as-user`) and put it in a [separate repo](https://github.com/mkenney/docker-scripts/tree/master/container) as it's used in several images. [Let me know](https://github.com/mkenney/docker-npm/issues) if you have any trouble, this is the first image I've switched over.

#### 2016-05-25

##### Breaking changes

Added a wrapper script to the container that executes `npm`, `gulp` and `grunt` commands as a user who's `uid` and `gid` matches those properties on the current directory. This way any files are installed as the directory owner/group instead of root or a random user.

If you've been using the [previous version](https://github.com/mkenney/docker-npm/tree/deprecated/bin) of the included shell scripts from the project's `/bin` directory you will probably need to update the permissions of files created using them or the new scripts are likely to have permissions errors because previously the files would have been created by the `root` user. This command should take care of it for you but _make sure you understand what it will do **before** you run it_. I can't help you if you hose your system.

* From your **_project directory_**: `sudo chown -R $(stat -c '%u' .):$(stat -c '%g' .) ./`

If you haven't been using the included scripts, then you don't need to do anything.

### Source Repo

[mkenney/docker-npm](https://github.com/mkenney/docker-npm)

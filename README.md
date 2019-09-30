[![docker-badges.webbedlam.com](http://docker-badges.webbedlam.com/image/mkenney/npm)](https://hub.docker.com/r/mkenney/npm/)

# npm and related build and dev tools

[![MIT License](https://img.shields.io/github/license/mkenney/k8s-proxy.svg)](https://github.com/mkenney/docker-npm/blob/master/LICENSE) [![stability-mature](https://img.shields.io/badge/stability-mature-008000.svg)](https://github.com/mkenney/software-guides/blob/master/STABILITY-BADGES.md#mature) [![Build status](https://travis-ci.org/mkenney/docker-npm.svg?branch=master)](https://travis-ci.org/mkenney/docker-npm) [![Github issues](https://img.shields.io/github/issues-raw/mkenney/docker-npm.svg)](https://github.com/mkenney/docker-npm/issues) [![Github pull requests](https://img.shields.io/github/issues-pr/mkenney/docker-npm.svg)](https://github.com/mkenney/docker-npm/pulls)

Please feel free to [create an issue](https://github.com/mkenney/docker-npm/issues) or [open a pull request](https://github.com/mkenney/docker-npm/pull/new/master) if you need support or would like to contribute.

## Portable `node`, package managers and build tools

- [Tagged Images](#tagged-images)
- [About](#about)
- [Images](#images)
- [Installation](#installation)
- [Change log](#change-log)

## Announcements

### v1.1.0 released

2019-02-25

* Added `node` v11 images and tests
* Updated the shell scripts to default to `node-11-alpine` image (you can always use the `DOCKER_NPM_TAG` variable to use another image).

## Tagged Images

Images are tagged according to the installed Node version and operating system. Package versions are not pinned, instead [`npm`](https://npmjs.org/) is executed to install current versions of each package. If stability issues arise, I will pin package versions in a `Dockerfile` for that Node/OS version and create a image tagged as `stable` based on it. Please [let me know](https://github.com/mkenney/docker-npm/issues) if you run into this situation.

### Alpine

#### [`alpine`, `latest` Dockerfile](https://github.com/mkenney/docker-npm/blob/master/alpine/Dockerfile)

Based on [`node:alpine`](https://hub.docker.com/_/node/). This image should be considered under development and may not be as stable as versioned images.

#### [`node-11-alpine` Dockerfile](https://github.com/mkenney/docker-npm/blob/master/node-11-alpine/Dockerfile)

Based on [`node:11-alpine`](https://hub.docker.com/r/library/node/tags/11-alpine/).

#### [`node-10-alpine` Dockerfile](https://github.com/mkenney/docker-npm/blob/master/node-10-alpine/Dockerfile)

Based on [`node:10-alpine`](https://hub.docker.com/r/library/node/tags/10-alpine/).

#### [`node-9-alpine` Dockerfile](https://github.com/mkenney/docker-npm/blob/master/node-9-alpine/Dockerfile)

Based on [`node:9-alpine`](https://hub.docker.com/r/library/node/tags/9-alpine/).

#### [`node-8-alpine` Dockerfile](https://github.com/mkenney/docker-npm/blob/master/node-8-alpine/Dockerfile)

Based on [`node:8-alpine`](https://hub.docker.com/r/library/node/tags/8-alpine/).

#### [`node-7-alpine` Dockerfile](https://github.com/mkenney/docker-npm/blob/master/node-7-alpine/Dockerfile)

Based on [`node:7-alpine`](https://hub.docker.com/r/library/node/tags/7-alpine/).

#### [`node-6-alpine` Dockerfile](https://github.com/mkenney/docker-npm/blob/master/node-6-alpine/Dockerfile)

Based on [`node:6-alpine`](https://hub.docker.com/r/library/node/tags/6-alpine/).

### Debian

#### [`debian` Dockerfile](https://github.com/mkenney/docker-npm/blob/master/debian/Dockerfile)

Based on [`node:latest`](https://hub.docker.com/r/library/node/tags/latest/). This image should be considered under development and may not be as stable as versioned images.

#### [`node-11-debian` Dockerfile](https://github.com/mkenney/docker-npm/blob/master/node-11-debian/Dockerfile)

Based on [`node:11-stretch`](https://hub.docker.com/r/library/node/tags/11-stretch/).

#### [`node-10-debian` Dockerfile](https://github.com/mkenney/docker-npm/blob/master/node-10-debian/Dockerfile)

Based on [`node:10-wheezy`](https://hub.docker.com/r/library/node/tags/10-wheezy/).

#### [`node-9-debian` Dockerfile](https://github.com/mkenney/docker-npm/blob/master/node-9-debian/Dockerfile)

Based on [`node:9-wheezy`](https://hub.docker.com/r/library/node/tags/9-wheezy/).

#### [`node-8-debian` Dockerfile](https://github.com/mkenney/docker-npm/blob/master/node-8-debian/Dockerfile)

Based on [`node:8-wheezy`](https://hub.docker.com/r/library/node/tags/8-wheezy/).

#### [`node-7-debian` Dockerfile](https://github.com/mkenney/docker-npm/blob/master/node-7-debian/Dockerfile)

Based on[`node:7-wheezy`](https://hub.docker.com/r/library/node/tags/7-wheezy/).

### Other Images

#### [`node-7.7-alpine`, `7.0-alpine` Dockerfile](https://github.com/mkenney/docker-npm/blob/master/node-7.7-alpine/Dockerfile)

[![stability-locked](https://img.shields.io/badge/stability-locked-4b0088.svg)](https://github.com/mkenney/software-guides/blob/master/STABILITY-BADGES.md#locked) Based on [`node:7.7-alpine`](https://hub.docker.com/r/library/node/tags/7-alpine/), it  `node` v7.7 compiled from source. The `7.0-alpine` tagged version was accidentally upgraded over time to v7.7 and will remain so for the stability of existing users.

#### [`node-6.9-alpine`, `6.9-alpine` Dockerfile](https://github.com/mkenney/docker-npm/blob/master/node-6.9-alpine/Dockerfile)

[![stability-locked](https://img.shields.io/badge/stability-locked-4b0088.svg)](https://github.com/mkenney/software-guides/blob/master/STABILITY-BADGES.md#locked) Based on [`alpine:3.4`](https://hub.docker.com/r/library/alpine/tags/3.4/) with `node` v6.9 compiled from source.

#### [`node-7.0-debian`, `7.0-debian` Dockerfile](https://github.com/mkenney/docker-npm/blob/master/node-7.0-debian/Dockerfile)

[![stability-locked](https://img.shields.io/badge/stability-locked-4b0088.svg)](https://github.com/mkenney/software-guides/blob/master/STABILITY-BADGES.md#locked) Based on[`node:7.0-wheezy`](https://hub.docker.com/r/library/node/tags/7.0-wheezy/).

#### [`node-6.9-debian`, `6.9-debian` Dockerfile](https://github.com/mkenney/docker-npm/blob/master/node-6.9-debian/Dockerfile)

[![stability-locked](https://img.shields.io/badge/stability-locked-4b0088.svg)](https://github.com/mkenney/software-guides/blob/master/STABILITY-BADGES.md#locked) Based on[`node:6.9-wheezy`](https://hub.docker.com/r/library/node/tags/6.9-wheezy/).

## About

Essentially, this is just a set of [shell scripts](https://github.com/mkenney/docker-npm/tree/master/bin) that manage a [Node.js](https://nodejs.org/) docker image. The docker image includes a script ([`run-as-user`](https://github.com/mkenney/docker-scripts/tree/master/container)) that allows commands to write files as either the current user or the owner/group of the current directory, which the shell scripts take advantage of to make sure files are created with your preferred permissions rather than root.

#### Images & Wrapper Scripts

The [images](https://hub.docker.com/r/mkenney/npm/tags/) contain the latest stable `bower`, `generate-md`, `grunt`, `gulp`, `node`, `npm`, `npx`, and `yarn`, binaries for [`node`](https://hub.docker.com/_/node/). When using the [shell scripts](https://github.com/mkenney/docker-npm/tree/master/bin) available in the [source repository](https://github.com/mkenney/docker-npm), the current directory is mounted into `/src` inside the container and a [wrapper script](https://github.com/mkenney/docker-scripts/blob/master/container/run-as-user) executes the specified command as a user who's `uid` and `gid` matches those properties on that directory. This way any output is written as the directory owner/group instead of root or a random user.

The included [`run-as-user`](https://github.com/mkenney/docker-scripts/tree/master/container) script has three methods of determining which `uid` and `gid` to execute as:

* By default, it will execute with a `uid` and `gid` that matches the current directory (the one that gets mounted into `/src`).
* In order to take advantage of public key authentication when installing packages from private repositories, all the wrapper scripts will attempt to mount your `~/.ssh` directory into the container. When that is successful, the script will run as the `uid` and `gid` of the owner of `~/.ssh` (you).

  Most software that takes advantage of public key authentication protocols do so over SSH, and by default, send the current user name as the login name. Because this process is executing out of a segregated container, it knows nothing about the current user's name and will instead try to login as a user named `dev`. In order to work around this, you need to create a SSH configuration that specifies the correct username.

  In your `~/.ssh` folder create a file called `config`. In that file you need to specify the correct username. For example, to specify your login name for all hosts:

  ```txt
  Host *
      User mkenney
  ```

  You can easily be more explicit as well, specifying by host or with additional wildcards. [Google is your friend](https://duckduckgo.com/?q=ssh+config+file).

  ```txt
  Host github.com
      User mkenney
  ```

* You can also explicitly specify the `uid` and `gid` to use at runtime by defining the `PUID` and `PGID` environment variables when executing the container, this is quite useful in automated build systems:

  ```txt
  docker run \
      --rm \
      -it \
      -v $(pwd):/src:rw \
      -e "PUID=<user id>" \
      -e "PGID=<group id>" \
      mkenney/npm:latest <commands>
  ```

The included [wrapper scripts](https://github.com/mkenney/docker-npm/blob/master/bin) default to the latest node version and image tag I feel is stable, I will update the default tag as updates are released or stability issues warrant (`node-10-alpine` at the moment).

To specify a different image, you can define the image tag in your environment which will set a new default (you probably want to define this in your `.bashrc` or similar profile script):
```txt
export DOCKER_NPM_TAG=node-6.9-alpine
```

or you can easily specify it at runtime whenever necessary, for example:
```txt
$ DOCKER_NPM_TAG=node-6.9-alpine bower install
```

If you would to see like additional node modules and/or wrapper scripts added to this project please feel free to [create an issue](https://github.com/mkenney/docker-npm/issues) or [open a pull request](https://github.com/mkenney/docker-npm/pull/new/master).

#### Installation

This assumes that you already have [Docker](https://www.docker.com) installed. A running `docker` daemon is required. You probably want to be able to [run docker commands without sudo](https://docs.docker.com/engine/installation/linux/linux-postinstall/), but even if you excute the scripts with sudo files will be written with the appropriate `uid` and `gid`.

Wrapper scripts for several commands are available in the source repository:

* [`bower`](https://github.com/mkenney/docker-npm/blob/master/bin/bower)
* [`generate-md`](https://github.com/mkenney/docker-npm/blob/master/bin/generate-md)
* [`grunt`](https://github.com/mkenney/docker-npm/blob/master/bin/grunt)
* [`gulp`](https://github.com/mkenney/docker-npm/blob/master/bin/gulp)
* [`node`](https://github.com/mkenney/docker-npm/blob/master/bin/node)
* [`npm`](https://github.com/mkenney/docker-npm/blob/master/bin/npm)
* [`npx`](https://github.com/mkenney/docker-npm/blob/master/bin/npx)
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
  $ curl -L https://raw.githubusercontent.com/mkenney/docker-npm/master/bin/install.sh | bash -s gulp node-10-alpine $HOME/bin
  $ bash ./install.sh gulp node-10-alpine $HOME/bin
```

##### Updating

* `[command] self-update`

  Each of the scripts have a `self-update` command which pulls down the latest docker image (which all the scripts share) and then updates the shell script itself. If you don't have write permissions on the shell script you'll get a permissions error, you can run the self-update command with `sudo` if necessary.

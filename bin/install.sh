#!/bin/bash

INSTALL_SCRIPT_URL=https://raw.githubusercontent.com/mkenney/docker-npm/master/bin/install.sh
INSTALL_SCRIPT=/tmp/docker-npm-install
SELF=$0
COMMAND=$1
PREFIX=$3

#
# Loosely based on https://npmjs.org/install.sh, run as `curl | sh`
# http://www.gnu.org/s/hello/manual/autoconf/Portable-Shell.html
# Download the master install script and execute it locally
#
if [ "sh" == "$SELF" ] || [ "bash" == "$SELF" ]; then

    #
    # Download and execute the install script
    #
    curl -f -L -s $INSTALL_SCRIPT_URL > $INSTALL_SCRIPT.sh
    exit_code=$?
    if [ $exit_code -eq 0 ]; then
        if head $INSTALL_SCRIPT.sh | grep -q '404: Not Found'; then
            echo "Install failed: The installation script could not be found at $INSTALL_SCRIPT_URL"  >&2
            rm -f $INSTALL_SCRIPT.sh
            exit 404
        fi
        if ! [ -s $INSTALL_SCRIPT.sh ]; then
            echo
            echo "Install failed: Invalid or empty script at $INSTALL_SCRIPT_URL" >&2
            exit 1
        fi
        (exit 0)
    else
        echo
        echo "Install failed: Could not download 'install.sh' from $INSTALL_SCRIPT_URL" >&2
        exit $exit_code
    fi

    bash $INSTALL_SCRIPT.sh $@
    exit_code=$?
    rm -f $INSTALL_SCRIPT.sh
    exit $exit_code
fi

#
# Usage
#
function usage() {
    if [ "sh" == "$SELF" ] || [ "bash" == "$SELF" ]; then
        SELF="bash -s"
    fi

    echo "
    Usage
        $SELF COMMAND [PREFIX]

    Synopsys
        Install a mkenney/npm container execution script locally

    Options
        COMMAND  - Required, the name of the command to install (bower, gulp, npm, etc.)
        PREFIX   - Optional, the location to install the command script. Default '\$HOME/bin'

    Examples
        $ curl -L $INSTALL_SCRIPT_URL | bash -s gulp 7.0-alpine \$HOME/bin
        $ bash ./install.sh gulp 7.0-alpine \$HOME/bin"
}

#
# COMMAND is a required argument
#
if [ "" == "$COMMAND" ] || [ "install.sh" == "$COMMAND" ]; then
    usage
    exit 1
fi

#
# Set defaults
#
if [ "" == "$PREFIX" ]; then
    PREFIX=$HOME/bin
fi

COMMAND_URL=https://raw.githubusercontent.com/mkenney/docker-npm/master/bin/$COMMAND
COMMAND_TEMPFILE=/tmp/docker-npm-$COMMAND-wrapper

#
# Download and validate the script
#
curl -f -L -s $COMMAND_URL > $COMMAND_TEMPFILE
exit_code=$?
if [ $exit_code -ne 0 ]; then
    echo
    echo "Install failed: Could not download '$COMMAND' from $COMMAND_URL"
    exit $exit_code
fi
if grep -q '404: Not Found' $COMMAND_TEMPFILE; then
    usage
    echo
    echo "Not found: The $COMMAND script was not found at $COMMAND_URL";
    echo "Please verify that the COMMAND values are correct"
    exit 404
fi
if ! [ -s $COMMAND_TEMPFILE ]; then
    echo
    echo "Install failed: Invalid or empty '$COMMAND' script or download failed at $COMMAND_URL"
    exit $exit_code
fi

#
# Create the installation directory
#
mkdir -p $PREFIX
exit_code=$?
if [ 0 -ne $exit_code ]; then
    echo
    echo "Install failed: Could not create directory '$PREFIX'"
    exit $exit_code
fi

#
# Cat the tempfile into the command file instead of moving it so that
# symlinkys aren't destroyed
#
cat $COMMAND_TEMPFILE > $PREFIX/$COMMAND && chmod +x $PREFIX/$COMMAND
exit_code=$?
if [ 0 -ne $exit_code ]; then
    echo
    echo "Install failed: Could not update '$PREFIX/$COMMAND'"
    exit $exit_code
fi

#
# Cleanup the tempfile
#
rm -f $COMMAND_TEMPFILE
exit_code=$?
if [ 0 -ne $exit_code ]; then
    echo
    echo "Error: Could not delete tempfile '$COMMAND_TEMPFILE'"
    exit $exit_code
fi

echo
echo "$PREFIX/$COMMAND: Installation succeeded"
exit 0

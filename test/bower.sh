#!/bin/bash

PREFIX="        "
IMAGE_TAG=latest
if [ "" != "$1" ]; then
    IMAGE_TAG=$1
fi




CMD="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG"
echo "###########################################################################"
echo "###########################################################################"
echo "###########################################################################"
echo
echo "ls -laF /home/dev/.config/"
$CMD ls -laF /home/dev/.config/
echo
echo "ls -laF /home/dev/.config/configstore/"
$CMD ls -laF /home/dev/.config/configstore/
echo
echo "cat /run-as-user"
$CMD cat /run-as-user
echo
echo "cat /etc/group"
$CMD cat /etc/group
echo
echo "pwd"
$CMD pwd
echo
echo "whoami"
$CMD whoami
echo
echo "echo \$HOME"
$CMD echo $HOME
echo
echo "###########################################################################"
echo "###########################################################################"
echo "###########################################################################"
exit 1




CMD="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG /usr/local/bin/bower  --allow-root"

cd $PROJECT_PATH/test/resources
rm -rf bower_components

$CMD install
result=$?
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: '$CMD install'"
    exit $result
fi

ls bower_components
result=$?
if [ 0 -ne $result ]; then
    echo "${PREFIX}${PREFIX}${output}"
fi
rm -rf bower_components

exit $result

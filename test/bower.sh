#!/bin/bash

PREFIX="        "
IMAGE_TAG=latest
if [ "" != "$1" ]; then
    IMAGE_TAG=$1
fi

CMD="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG /run-as-user /usr/local/bin/bower  --allow-root"

cd $PROJECT_PATH/test/resources

#build testing

echo "ENV:"
echo "User $(whoami): $(id -u dev):$(id -g dev)"
echo "stats: $(stat -c '%u' `pwd`):$(stat -c '%g' `pwd`)"
ls -laF
echo
echo "CONTAINER:"
echo "whoami: $(docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG /run-as-user whoami)"
echo "uid: $(docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG /run-as-user id -u dev)"
echo "gid: $(docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG /run-as-user id -g dev)"

echo "/src uid: $(docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG /run-as-user stat -c '%u' /src)"
echo "/src gid: $(docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG /run-as-user stat -c '%g' /src)"
docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG /run-as-user ls -laF
exit 1

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

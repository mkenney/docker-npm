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
echo "User $(whoami): uid=$(id -u $(whoami)) gid=$(id -g $(whoami))"
echo "$(pwd): uid=$(stat -c '%u' `pwd`) gid=$(stat -c '%g' `pwd`)"
ls -laF
echo
echo "CONTAINER:"
echo "whoami: $(docker run --rm -ti -e PUID=$(id -u $(whoami)) -e PGID=$(id -g $(whoami)) -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG whoami)"
echo "uid: $(docker run --rm -ti -e PUID=$(id -u $(whoami)) -e PGID=$(id -g $(whoami)) -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG id -u dev)"
echo "gid: $(docker run --rm -ti -e PUID=$(id -u $(whoami)) -e PGID=$(id -g $(whoami)) -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG id -g dev)"

echo "/src uid: $(docker run --rm -e PUID=$(id -u $(whoami)) -e PGID=$(id -g $(whoami)) -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG stat -c '%u' /src)"
echo "/src gid: $(docker run --rm -e PUID=$(id -u $(whoami)) -e PGID=$(id -g $(whoami)) -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG stat -c '%g' /src)"
echo docker run --rm  -e PUID=$(id -u $(whoami)) -e PGID=$(id -g $(whoami)) -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG ls -laF
docker run --rm  -e PUID=$(id -u $(whoami)) -e PGID=$(id -g $(whoami)) -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG ls -laF
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

#!/usr/bin/env bash
PROJECT_NAME=audio-api

#Replace with your own file
source ../private-data/export-audio-vars.sh

git clone https://github.com/Pyrex-FWI/audio_api.git "$PROJECT_NAME"
#echo $?
cd $PROJECT_NAME
#If you don't export your ENV vars
#composer install -n --no-dev -vv --optimize-autoloader --no-scripts
#composer install -n --no-dev  --optimize-autoloader
cd ..

OS=$(uname -s)
if [ "$OS" == 'Darwin' ]; then
    eval "$(docker-machine env default)"
fi
if [[ "$(docker images -q yemistikris/audio-api 2> /dev/null)" == "" ]]; then
    echo "build docker image"
    docker build --rm -t yemistikris/audio-api:latest -f Dockerfile-NoSource .
else

    echo "Docker image yemistikris/audio-api:latest already exist"
fi
    docker run --rm --name=${PROJECT_NAME} -v ${PWD}/${PROJECT_NAME}:/var/sapar/audio-api/ --entrypoint composer --env-file ../private-data/vars  yemistikris/audio-api install --no-dev --optimize-autoloader --working-dir=/var/sapar/audio-api/
    docker run --rm --name=${PROJECT_NAME} -v ${PWD}/${PROJECT_NAME}:/var/sapar/audio-api/ --entrypoint composer --env-file ../private-data/vars  yemistikris/audio-api update --no-dev --optimize-autoloader --working-dir=/var/sapar/audio-api/

echo "Now you can run:"
echo "docker run -ti --rm --name=${PROJECT_NAME} -v ${PWD}/${PROJECT_NAME}:/var/sapar/audio-api/ -v /REPLACE_WITH_YOUR_PATH:/volume4/Pool/Franchise/Audio -v ${PWD}/${PROJECT_NAME}:/volume4/Pool/SmashVision --add-host mariadb:192.168.1.21 --env-file ../private-data/vars  yemistikris/audio-api deejay:discover"
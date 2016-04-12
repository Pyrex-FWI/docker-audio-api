# Install
 
 - mkdir private-data && cd private-data && touch export-vars.sh
 - set your custom environment var into private-data/export-vars.sh
 - mkdir my-app && cd my-app 
 - ```git clone https://github.com/Pyrex-FWI/docker-audio-api.git .```
 - chmod +x ./deploy.sh && ./deploy.sh
 
docker run -d --hostname my-rabbit --name some-rabbit -p 8080:15672 -p 5672:5672  -e RABBITMQ_DEFAULT_USER=YOUR_LOGIN -e RABBITMQ_DEFAULT_PASS=YOUR_PASSWORD rabbitmq:3-manag
ement

### Build docker image

Before start on MAC:

eval "$(docker-machine env default)"


docker stop audio-api && \
docker rm -f audio-api && \
docker rmi yemistikris/audio-api && \
docker build -t yemistikris/audio-api .

- To get ip of docker host you must run ```ip addr show docker0```

docker run -d -p 8082:80 --add-host mariadb:192.168.1.21 --name audio-api yemistikris/audio-api
docker run -d -p 8082:80 -v /volume3/temp/Pool:/volume4/Pool  --add-host mariadb:172.17.0.1 --name audio-api yemistikris/audio-api
docker exec -it audio-api bash

php app/console deejay:pool:download smashvision --start 1 --end 1 --dry -vv

docker exec -it audio-api  php app/console deejay:pool:download franchise_pool_audio --start 1 --end 10 --dry -vv


docker run -d -p 8082:80 -v /volume3/web/audio_api:/var/www/html --name audio-api yemistikris/audio-api

docker run -d -p 8082:80 -v /volume4:/volume4 -v /volume1:/volume1 --add-host mariadb:172.17.0.1 --name audio-api yemistikris/audio-api


docker build --force-rm --no-cache -t yemistikris/audio-api .


docker exec -it beets /bin/bash -c "beet import -As --resume --incremental /volume1/_archives/ && beet import -As --resume --incremental /volume1/archives/ && beet import -As --resume --incremental /volume4/Pool/"

docker exec -it beets /bin/bash -c "beet import -A --resume --incremental /volume1/_archives/ && beet import -A --resume --incremental /volume1/archives/ && beet import -A --resume --incremental /volume4/Pool/"


docker build --rm -t yemistikris/audio-api:latest -f Dockerfile-NoSource .


docker run -ti \
-v /Volumes/SSD_MAC/ddj:/Volumes/SSD_MAC/ddj \
-v /Users/yemistikris/PhpstormProjects/sapar-project/audio-api:/usr/src/myapp \
-v "$PWD":/volume4/Pool/Franchise/Audio \
-v "$PWD":/volume4/Pool/SmashVision \
--add-host mariadb:192.168.1.21 \
--env-file vars \
--name audio-api yemistikris/audio-api media:dump:collection --dump -vv --env dev


docker run -ti --rm --name=audio-api --add-host mariadb:172.17.0.1  \
-v /volume3/docker/my-app/audio-api:/var/sapar/audio-api/ \
--env-file ../private-data/vars  \
-v /volume4/Pool/:/volume4/Pool yemistikris/audio-api \
deejay:pool:download smashvision --start 1 --end 1 --env prod -v --dry
FROM php:7.0.2-apache
RUN apt-get update \
&& apt-get install -y --no-install-recommends git \
wget zlib1g-dev vim \
python \
id3v2 \
mediainfo && \
wget "https://bootstrap.pypa.io/get-pip.py" && \
python get-pip.py && \
pip install eyeD3 && \
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin && mv /usr/bin/composer.phar /usr/bin/composer && \
docker-php-ext-install bcmath mbstring zip pdo pdo_mysql  && \
cd /opt && git clone https://github.com/krakjoe/apcu && \
    cd apcu && \
    phpize && \
    ./configure --enable-apcu && \
    make && make install && \
    echo "extension=apcu.so" > /usr/local/etc/php/conf.d/ext-apcu.ini && \
    cd /opt && git clone https://github.com/krakjoe/apcu-bc && \
    cd apcu-bc && \
    phpize && \
    ./configure --enable-apc && \
    make && make install && \
    echo "\nextension=apc.so" >> /usr/local/etc/php/conf.d/ext-apcu.ini && \
    rm -r /var/lib/apt/lists/*



RUN sed -i 's#DocumentRoot /var/www/html#DocumentRoot /var/www/html/web#g' /etc/apache2/sites-available/000-default.conf
RUN sed -i 's#DocumentRoot /var/www/html#DocumentRoot /var/www/html/web#g' /etc/apache2/apache2.conf


WORKDIR /var/www/html/
#COPY ./app/config/parameters.yml.dist /var/www/html/app/conf/

ENV SYMFONY_ENV=prod
#ip addr show docker0
#ENV SYMFONY__DATABASE_HOST=mariadbx
ENV SYMFONY__DATABASE_PORT=null
ENV SYMFONY__DATABASE_NAME=sf_audio
ENV SYMFONY__DATABASE_USER=admin-app
ENV SYMFONY__DATABASE_PASWWORD=admin-app
ENV SYMFONY__SECRET=ThisTokenIsNotSoSecretChangeIt
ENV SYMFONY__ID3TOOL__MEDIAINFO__BIN=/usr/bin/mediainfo
ENV SYMFONY__ID3TOOL__EYED3__BIN=/usr/local/bin/eyeD3
ENV SYMFONY__ID3TOOL__ID3V2__BIN=/usr/bin/id3v2
ENV SYMFONY__ID3TOOL__METAFLAC__BIN=/usr/bin/metaflac
ENV SYMFONY__AV_DISTRICT__CREDENTIALS__LOGIN=yemistikris@hotmail.fr
ENV SYMFONY__AV_DISTRICT__CREDENTIALS__PASSWORD=xerypjd
ENV SYMFONY__FRANCHISE_POOL__CREDENTIALS__LOGIN=brubruno
ENV SYMFONY__FRANCHISE_POOL__CREDENTIALS__PASSWORD=maladede
ENV SYMFONY__SMASHVISION__CREDENTIALS__LOGIN=yemistikris@hotmail.fr
ENV SYMFONY__SMASHVISION__CREDENTIALS__PASSWORD=xerypjd
ENV AUDIO_API_VERSION=v1.0.0-alpha.2
RUN ln -s /usr/bin/mediainfo /usr/local/bin/

RUN rm -r ./* && git clone --branch $AUDIO_API_VERSION https://github.com/Pyrex-FWI/audio_api.git .
RUN git status && cp /var/www/html/app/config/parameters.yml.dist /var/www/html/app/config/parameters.yml

RUN chown -R www-data: /var/www/html && chmod -R 777 /var/www/html

RUN export
RUN composer install -nq --no-dev --optimize-autoloader --prefer-dist --profile

RUN rm -rf /var/www/html/app/cache/* && rm -rf /var/www/html/app/logs/* && \
php app/console cache:warmup && \
chown -R www-data: /var/www/html/app/cache/ && chown -R www-data: /var/www/html/app/logs/ 

RUN echo "date.timezone = Europe/Paris" >/usr/local/etc/php/php.ini
RUN cat /var/www/html/app/config/parameters.yml

FROM node:18-alpine as build-deps

WORKDIR /temp/build-deps

RUN apk add build-base python3 --no-cache

COPY ./package.json ./package-lock.json ./
RUN npm install --omit=dev --frozen-lockfile --verbose

FROM node:18-alpine

ENV APP_DIR=/opt/dc-music-bot

WORKDIR ${APP_DIR}

RUN apk add ffmpeg --no-cache

COPY --from=build-deps /temp/build-deps/node_modules ./node_modules

COPY ./slash ./slash
COPY ./index.js .

COPY ./bot-entrypoint.sh /usr/local/bin/bot-entrypoint.sh

ENTRYPOINT ["bot-entrypoint.sh"]
FROM node:16-bullseye-slim

WORKDIR /bot

COPY . .

RUN apt update
RUN apt install ffmpeg -y

RUN npm install ytdl-core@latest
RUN npm install

ENTRYPOINT ["/bin/bash","/bot/entrypoint.sh"]
# memakai image node versi 16 dengan
FROM node:16-bullseye-slim

# membuat folder /bot dan menjadikan nya folder yang aktif sekarang
WORKDIR /bot

# menyalin semua file dan folder ke docker container
COPY . .

# update list package dan menginstall ffmpeg
RUN apt update
RUN apt install ffmpeg -y

# install node module
RUN npm install

# set entrypoint script
ENTRYPOINT ["/bin/bash","/bot/entrypoint.sh"]
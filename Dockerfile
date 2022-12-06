# memakai image node versi 16 dengan
FROM node:16-bullseye-slim

# membuat folder /bot dan menjadikan nya folder yang aktif sekarang
WORKDIR /bot

# menyalin semua file dan folder ke docker container
COPY . .

# update list package dan menginstall ffmpeg
RUN apt-get update \
    apt-get install --no-install-recommends ffmpeg curl -y \
    apt-get clean \
    rm -rvf /var/cache/apt/archives /var/lib/apt

# install node module
RUN npm install \
    npm cache clean --force

# set entrypoint script
ENTRYPOINT ["/bin/bash","/bot/entrypoint.sh"]
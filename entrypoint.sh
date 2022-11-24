#!/bin/bash

help() {
    read -rd '' BANNER_HELP << EOM
    -h, --help \t\t\t menampilkan pesan help ini.
    \n-s, --server-id <server_id> \t id server atau guild.
    \n-a, --app-id <app_id> \t application id atau id dari bot.
    \n-t, --token <token> \t\t bot token.
    \n-l, --load-slash \t\t load slash command pada server, untuk pertama kali
    \n\t\t\t\t saja atau jika slash command tidak tampil pada server.
    \nnote: untuk parameter token pakai tanda kutip, example: -t "token"
EOM
    echo -ne $BANNER_HELP
}

VALID_ARGS=$(getopt --options h,s:,a:,t:,l --longoptions help,server-id:,app-id:,token:,load-slash -- "$@")

[ $# -eq 0 ] && help && exit 2

eval set -- "$VALID_ARGS"

while :
do
    case "$1" in
        -h | --help)
            echo -ne $BANNER_HELP; exit 0; break ;;
        -s | --server-id)
            export SERVER_ID=$2; shift 2 ;;
        -a | --app-id)
            export APPLICATION_ID=$2; shift 2 ;;
        -t | --token)
            export TOKEN=$2; shift 2 ;;
        -l | --load-slash)
            export LOAD="load"; shift ;;
        --) shift; break ;;
        *) echo "Unexpected option: $1"; help; exit 2
    esac
done

[ -z $SERVER_ID ] || [ -z $APPLICATION_ID ] || [ -z $TOKEN ] && echo -ne "parameter error\n" && help && exit 2 || true

if [ ! -z $LOAD ] && test $LOAD = "load"; then
    cd /bot
    node index.js load && /bin/bash service.sh
else
    cd /bot
    /bin/bash service.sh
fi
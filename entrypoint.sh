#!/bin/bash

read -rd '' BANNER_HELP << EOM
-h, --help \t\t\t menampilkan pesan help ini.
\n-s, --server-id <server_id> \t id server atau guild.
\n-a, --app-id <app_id> \t\t application id atau id dari bot.
\n-t, --token <token> \t\t bot token.
\n-l, --load-slash \t\t load slash command pada server, untuk pertama kali
\n\t\t\t\t saja atau jika slash command tidak tampil pada server.
EOM

[ -z "$@" ] && echo -ne $BANNER_HELP || true

VALID_ARGS=$(getopt -o hs:a:t: --long help,server-id:,app-id:,token: -- "$@")

eval set -- "$VALID_ARGS"

while [ : ]; do
    case "$1" in
        -h | --help)
            echo -ne $BANNER_HELP; shift ;;
        -s | --server-id)
            export SERVER_ID=$2; shift 2 ;;
        -a | --app-id)
            export APPLICATION_ID=$2; shift 2 ;;
        -t | --token)
            export TOKEN=$2; shift 2 ;;
        --) shift; break ;;
    esac
done

#!/bin/sh

if [ ! "${1:0:1}" = "-" ] && command -v $1 1>/dev/null; then
  command=$1
  shift
  exec $command "$@"
fi


help() {
    read -rd '' BANNER_HELP << EOM
    -h, --help \t\t\t menampilkan pesan ini.
    \n-a, --app-id <app_id> \t application id atau id dari bot.
    \n-t, --token <token> \t\t bot token.
    \n\t\t\t\t saja atau jika slash command tidak tampil pada server.
    \nnote: untuk parameter token pakai tanda kutip, example: -t "token"
EOM
    echo -ne $BANNER_HELP
}

VALID_ARGS=$(getopt --options h,a:,t: --longoptions help,app-id:,token: -- "$@")

[ $# -eq 0 ] && help && exit 2

eval set -- "$VALID_ARGS"

while :; do
  case "$1" in
      -h | --help)
          help && exit 0;;
      -a | --app-id)
          export APPLICATION_ID=$2; shift 2 ;;
      -t | --token)
          export TOKEN=$2; shift 2 ;;
      --) shift; break ;;
      *) echo "Unexpected option or command: $1"
        help
        exit 1
      ;;
  esac
done

if [ -z $APPLICATION_ID ] || [ -z $TOKEN ] || false && true; then
  echo "invalid parameter argument"
  help
  exit 1
fi

exec node index.js


if [ -z $1 ]; then
	echo "enter parameter"
	echo "SERVER_ID APPLICATION_ID TOKEN"
	echo "note, use quote for TOKEN"
	echo "ex : 3445454345 34636566534 \"hfsbvfhg.fhwguyuie-fj\""
	exit 1
fi

export SERVER_ID=$1
export APPLICATION_ID=$2
export TOKEN=$3

cd /bot
/bin/bash service.sh

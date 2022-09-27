if [ -z $1 ]; then
	echo "error parameter kosong"
	
	exit 1
fi

showHelp() {
	echo ""
	echo "SERVER_ID APPLICATION_ID TOKEN"
	echo "note : pakai tanda kutip untuk TOKEN"
	echo "ex : docker run -dit --name=container-name dc-music-bot:me 3445454345 34636566534 \"hfsbvfhg.fhwguyuie-fj\""
	echo "jika di server discord slash command tidak muncul tambah kan paramaeter \'load\' di akhir perintah"
	echo "ex : docker run -dit --name=container-name dc-music-bot:me 3445454345 34636566534 \"hfsbvfhg.fhwguyuie-fj\" load"
}

case "$1" in
	--help|-h|h)
		
	;;
esac




export SERVER_ID=$1
export APPLICATION_ID=$2
export TOKEN=$3

cd /bot
/bin/bash service.sh

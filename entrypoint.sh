showHelp() {
	echo "--help | -h => menampilkan pesan help ini"
	echo "SERVER_ID APPLICATION_ID TOKEN"
	echo "note : pakai tanda kutip untuk TOKEN"
	echo "ex : docker run -dit --name=container-name dc-music-bot:me 3445454345 34636566534 \"hfsbvfhg.fhwguyuie-fj\""
	echo "jika di server discord slash command tidak muncul tambah kan paramaeter 'load' di akhir perintah"
	echo "ex : docker run -dit --name=container-name dc-music-bot:me 3445454345 34636566534 \"hfsbvfhg.fhwguyuie-fj\" load"
}

if [ -z $1 ]; then
	echo "error parameter kosong"
	showHelp
	exit 1
fi



case "$1" in
	--help|-h|h)
		showHelp
	;;
esac




export SERVER_ID=$1
export APPLICATION_ID=$2
export TOKEN=$3
if [ ! -z $4 ] && test $4 = "load"; then
	export LOAD="load"
	cd /bot
	/bin/bash service.sh
	unset LOAD
	/bin/bash service.sh

else
	cd /bot
	/bin/bash service.sh
fi
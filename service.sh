SCDIR=${0%/*}
node index.js &
echo "$!" > pid
PID=`cat pid`
sleep 5
[ -f botname ] && export BOTNAME=`cat botname` || export BOTNAME="@Bot"

whatever() {
	cat log.txt | tail -1
}

while [ -d /proc/$PID ]; do
	d=`date`
	[ -f status ] && stats=`cat status` || stats=0
	if (( $stats == 2 )); then
		echo "$d -- $BOTNAME bot online again" >> log.txt
	whatever
	fi
	d=`date`
	while [ -d /proc/$PID ]; do
		[ ! -f count ] && c=0 || c=`cat count`
		((c+=1))
		echo $c > count
		if (( $c >= 100 )); then
			echo "$d -- $BOTNAME clear log file" > log.txt
			whatever
			echo "0" > count
			c=0
		fi
		echo "0" > status
		echo "$d -- $BOTNAME bot ok" >> log.txt
		whatever
		sleep 20
		d=`date`
	done
	echo "1" > status
	echo "$d -- $BOTNAME bot die/error" >> log.txt
	whatever
	echo "$d -- $BOTNAME restarting bot" >> log.txt
	whatever
	node index.js &
	echo "$!" > pid
	export PID=`cat pid`
	echo "2" > status
done

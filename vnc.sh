USER=$1
IP=$2
if [ "$USER" == "" ] || [ "$IP" == "" ];
then
	echo "vnc [USER] [IP] -p [PORT] -d [DESK]"
	exit 1
fi

shift 2
while true 
do 
	case "$1" in
		-p)
			PORT="$2"
			shift 2
			;;
		-d)
			DESK="$2"
			shift 2
			;;
		*)
			break
			;;
	esac
done

echo "user: $USER"
echo "port: $PORT"
if [ "$DESK" == "" ];
then
	DESK=1
fi
echo "desk: $DESK"

if [ "$PORT" != "" ];
then
	export VNC_VIA_CMD="/usr/bin/ssh -p $PORT -l $USER -f -L %L:%H:%R %G sleep 10"
	#echo "set ssh redirecting ... $VNC_VIA_CMD"
	vncviewer -via $IP localhost:$DESK
else
	echo "directly connecting ... "
	vncviewer $USER@$IP:$DESK
fi

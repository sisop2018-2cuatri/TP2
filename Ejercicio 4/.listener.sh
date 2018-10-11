#!/bin/bash

sigusr1(){
	echo "####USERSIGNAL1 atrapada####"
	echo "User: $USER"
	echo "Fecha: `date '+%Y/%m/%d'`"
	echo "Hora:`date '+%H:%M:%S'`"
	echo "CPU en uso: `top -b -n1 | grep "Cpu(s)" | awk '{print $2+$4+$6}'`%"
	echo "Memoria en uso: `free | grep "Mem:" | awk '{print $3}'` MB"
	echo "Memoria disponible `free | grep "Mem:" | awk '{print $4}'` MB"
}
sigusr2(){
	echo "####USERSIGNAL2 atrapada####"
	echo "User: $USER"
	echo "Fecha: `date '+%Y/%m/%d'`"
	echo "Hora:`date '+%H:%M:%S'`"
	echo "Estado de los filesistems: "
	echo "`df -Th`"
}
sigint(){
	echo "####SIGTERM atrapada####"
	echo "FECHA DE FINALIZACION DEL SCRIPT: `date '+%Y/%m/%d a las %H:%M:%S'`"
}

FECHA=`date '+%Y-%m-%d--%H:%M:%S'`
NOMBRE_LOG="$PWD/log/${FECHA}P$$.log"
mkdir -p "$PWD/log/"
touch "$NOMBRE_LOG"

trap 'sigusr1 >>"$NOMBRE_LOG"' USR1
trap 'sigusr2 >>"$NOMBRE_LOG"' USR2
trap 'sigint >>"$NOMBRE_LOG"; exit 0' TERM 

echo "FECHA DE EJECUCION DEL SCRIPT: `date '+%Y/%m/%d a las %H:%M:%S'`">>"$NOMBRE_LOG"
while true ; do
	true
done

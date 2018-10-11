#!/bin/bash

get_help(){
echo "`basename $0` versión 1.0.0"
echo "Programa de monitoreo de señales enviadas a un EventListener"
echo "-------------------"
echo "Descripcion: "
echo "Al ejecutar el script, se inicia en el background un EventListener, al cual se le pueden enviar señales (de las cuales solo SIGUSR1, SIGUSR2 e SIGTERM va a reconocer). Depende de cual señal reciba, ejecutara distintas rutinas: "
echo "Si recibe SIGUSR1, tendra que mostrar el nombre del usuario, fecha y hora del evento (timestamp), porcentaje de uso de la CPU, memoria utilizada y disponible"
echo "Si recibe SIGUSR2, tendra que mostrar el nombre del usuario, fecha y hora del evento (timestamp), información sobre el estado de utilización de todos los file systems que tenga el equipo"
echo "Si recibe SIGTERM, tendra que registrar la hora de finalización del proceso y terminar"
echo "-------------------"
echo "Uso: ./TP2-Ejercicio4.sh"
echo "-------------------"
echo "Ejemplos de uso:"
echo "Ejemplo 1: 
$./TP2-Ejercicio4.sh"
echo ">>2018-10-08--01:26:25 Ejecutando EventListener:"
echo ">>PID del listener:7370"
echo "Para probar si funciona usamos los comandos: "
echo '$kill -USR1 7370'
echo '$kill -USR2 7370'
echo '$kill -TERM 7370'
echo "Dentro de la carpeta /log/ en el directorio del script encontramos su log creado"
echo '$vi ./log/2018-10-08--01:26:25P7370.log'
echo "
FECHA DE EJECUCION DEL SCRIPT: 2018/10/08 a las 01:26:25
####USERSIGNAL1 atrapada####
User: maximiliano-rdl
Fecha: 2018/10/08
Hora:01:38:15
CPU en uso: 69%
Memoria en uso: 2.08729 GB
Memoria disponible 2.02904 GB
####USERSIGNAL2 atrapada####
User: maximiliano-rdl
Fecha: 2018/10/08
Hora:01:38:19
Estado de los filesistems: 
S.ficheros     Tipo     Tamaño Usados  Disp Uso% Montado en
udev           devtmpfs   1,4G      0  1,4G   0% /dev
tmpfs          tmpfs      285M   1,3M  283M   1% /run
/dev/sda1      ext4        30G   5,2G   23G  19% /
tmpfs          tmpfs      1,4G      0  1,4G   0% /dev/shm
tmpfs          tmpfs      5,0M      0  5,0M   0% /run/lock
tmpfs          tmpfs      1,4G      0  1,4G   0% /sys/fs/cgroup
tmpfs          tmpfs      285M    48K  285M   1% /run/user/1000
/dev/loop0     squashfs    87M    87M     0 100% /snap/core/4917
/dev/loop1     squashfs    35M    35M     0 100% /snap/gtk-common-themes/319
/dev/loop2     squashfs   141M   141M     0 100% /snap/gnome-3-26-1604/70
/dev/loop3     squashfs   2,4M   2,4M     0 100% /snap/gnome-calculator/180
/dev/loop4     squashfs    13M    13M     0 100% /snap/gnome-characters/103
/dev/loop5     squashfs    15M    15M     0 100% /snap/gnome-logs/37
/dev/loop6     squashfs   3,8M   3,8M     0 100% /snap/gnome-system-monitor/51
####SIGTERM atrapada####
FECHA DE FINALIZACION DEL SCRIPT: 2018/10/08 a las 01:38:23"
echo "-------------------"
echo "Salida: Fecha y hora de ejecucion del EventListener y su PID para poder enviarle señales mas comodamente. Todo el output del EventListenes se escribe en un log en la carpeta /log/ donde su nombre se define por su fecha y hora de inicializacion y numero de PID asignado"
echo "-------------------"
echo "Notas:"
echo "Materia Sistemas Operativos"
echo "Trabajo Práctico N°2"
echo "Ejercicio 4"
echo "Script: ./TP2-Ejercicio4.sh"
echo "-------------------"
echo "Integrantes:"
echo "	Avila, Leandro - 35.537.983"
echo "	Di Lorenzo, Maximiliano - 38.166.442"
echo "	Lorenz, Lautaro - 37.661.245"
echo "	Mercado, Maximiliano - 37.250.369"
echo "	Sequeira, Eliana - 39.061.003"
  	# fin mensaje de ayuda
}
if [[ $1 == -h ]] || [[ $1 == -help ]] || [[ $1 == -? ]]; then
get_help
exit 0
fi


FECHA=`date '+%Y-%m-%d--%H:%M:%S'`
echo "$FECHA Ejecutando Proceso de escucha de signals: " 
./.listener.sh &
echo "PID del Proceso: "$!

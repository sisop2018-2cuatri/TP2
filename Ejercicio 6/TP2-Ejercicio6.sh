#! /bin/bash

# mensaje de ayuda
if [[ $1 == -h ]] || [[ $1 == -help ]] || [[ $1 == -? ]]; then
	echo "`basename $0` versión 1.0.0"
	echo "Monitorea eventos en los archivos dentro de un directorio"
	echo "Uso: ./TP2-Ejercicio6.sh directorio extensiones"
	echo "Parametros:"
	echo '	$1: path del directorio en donde se monitorearán los archivos'
	echo '	$2: tipo(s) de archivo(s) a monitorear, puede usar \* para incluir todos los tipos'
	echo "Opcional: puede usar los comodines (*?) en los tipos de archivo"
	echo "Ejemplos de uso:"
	echo "	ejemplo 1: ./TP2-Ejercicio6.sh ~/midirectorio/ \*"
	echo "	ejemplo 2: ./TP2-Ejercicio6.sh ./midirectorio .doc"
	echo "	ejemplo 3: ./TP2-Ejercicio6.sh ./midirectorio/ .doc,.xls"
	echo "	ejemplo 4: ./TP2-Ejercicio6.sh ./midirectorio/subdir/ .txt,.doc,.xls"
	echo "	ejemplo 5: ./TP2-Ejercicio6.sh ./midirectorio/subdir/ .t*"
	echo "	ejemplo 6: ./TP2-Ejercicio6.sh ./midirectorio/subdir/ .ab*,.txt"
	echo "	ejemplo 7: ./TP2-Ejercicio6.sh ./midirectorio/subdir/ .txt,.doc,.xls?"
	echo "Salida: para cada evento se obtendrá en terminal un mensaje como el siguiente"
	echo "	[%Y-%m-%d %H:%M:%S] archivo EVENTO"
	echo "Requiere: inotify-tools"
	echo ""
	echo "Sistemas Operativos"
	echo "-------------------"
	echo "Trabajo Práctico N°2"
	echo "Ejercicio 6"
	echo "Script: ./TP2-Ejercicio6.sh"
	echo "-------------------"
	echo "Integrantes:"
	echo "	Avila, Leandro - 35.537.983"
	echo "	Di Lorenzo, Maximiliano - 38.166.442"
	echo "	Lorenz, Lautaro - 37.661.245"
	echo "	Mercado, Maximiliano - 37.250.369"
	echo "	Sequeira, Eliana - 39.061.003"

  	# fin mensaje de ayuda
  	exit 0
fi

# el parámetro $1 debe ser el path del directorio para analizar
DIRECTORIO=$1 

# validar el directorio ingresado
# notar el doble [[]] en el if, es para permitir ingreso de path con espacios
if ! [[ -d $DIRECTORIO ]]; then
	echo "ERROR: el primer parámetro debe ser un directorio del sistema"
	exit 1
else
	echo "directorio $DIRECTORIO"
fi

# en $2 solicitamos las extensiones de los archivos para monitorear
EXTENSIONES=$2

# validar que el segundo parametro no esté vacio
if [ -z "$EXTENSIONES" ]; then 
	echo "ERROR: el segundo parametro debe indicar los tipos de archivo para monitorear"
	echo "INFORMARCIÓN ADICIONAL: para todos los tipos de archivo puede usar \*"
	exit 1
fi

# monitoreo de archivos según su tipo
# -----------------------------------
declare -a TIPOS_ACEPTADOS=() # tipos de archivos aceptados
if [ "$EXTENSIONES" == "*" ]; then
	# si ingresaron \* monitorear todos los archivos
	echo "monitorear los archivos independientemente de que tipo sean"

	# indicar que todos los tipos son aceptados para monitorear
	TIPOS_ACEPTADOS[0]="TODOS"
else
	# se deberán monitorear múltiples extensiones
	echo "listado de extensiones ingresadas:"
	
	IFS=',' read -ra ADDR <<< "$EXTENSIONES"
	for i in "${ADDR[@]}"; do
		extension="extensión ["$i"]"

		# validar que la extensión comience con punto
		if ! [[ $i == .* ]]; then 
			echo "ERROR: la "$extension" debe comenzar con el caracter punto (.)"
			exit 1
		fi

		# si la extensión fue aceptada
		echo " - "$extension
		TIPOS_ACEPTADOS+=($i)
	done
fi

# contiene el último evento mostrado
ULTIMO_EVENTO="" 

# ejecutar comando de monitoreo (requiere inotify-tools)
inotifywait --format "%e %f %T" --timefmt "%F %T" --monitor $DIRECTORIO |
  while read evento nombre fechahora; do  # cuando ocurre un evento
	flag_monitorear_evento=0 # vale 1 cuando es un evento que debemos monitorerar

	if [[ ${TIPOS_ACEPTADOS[0]} == TODOS ]]; then 
		# si debo monitorear todos los archivos del directorio
		flag_monitorear_evento=1
	else 
		# verificar si el archivo del evento es de un tipo que debo monitorear
		for i in "${TIPOS_ACEPTADOS[@]}"; do
			if [[ $nombre == *$i ]]; then 
				# si es un tipo de archivo a monitorear
				flag_monitorear_evento=1
			fi
		done
	fi

	# si el evento es en un archivo monitoreado
	if [ $flag_monitorear_evento == 1 ]; then
		nuevo_evento="[$fechahora] $nombre $evento"
		# si el evento a mostrar es distinto al último mostrado
		if ! [[ $ULTIMO_EVENTO == $nuevo_evento ]]; then
			# mostrar datos del evento
			ULTIMO_EVENTO=$nuevo_evento
			echo $ULTIMO_EVENTO
		fi
	fi
done
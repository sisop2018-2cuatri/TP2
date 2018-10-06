#! /bin/bash

# el parámetro $1 debe ser el path del directorio para analizar
DIRECTORIO=$1 

# validar el directorio ingresado
# notar el doble [[]] en el if, es para permitir ingreso de path con espacios
if ! [[ -d $DIRECTORIO ]]; then
	echo "ERROR: el primer parámetro debe ser un directorio del sistema"
	exit 1
else
	echo "directorio aceptado"
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
if [ "$EXTENSIONES" == "*" ]; then
	# si ingresaron \* monitorear todos los archivos
	echo "monitorear los archivos independientemente de que tipo sean"
else
	# se deberán monitorear múltiples extenciones
	
fi

# else
#	echo "ERROR: el(los) tipo(s) de archivo ingresado(s) no fueron aceptado(s)"
#	exit 1
# fi






















































































































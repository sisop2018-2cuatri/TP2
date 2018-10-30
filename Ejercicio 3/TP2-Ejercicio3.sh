#!/bin/bash
# "Sistemas Operativos"
# "-------------------"
# "Trabajo Práctico N°2"
# "Ejercicio 3"
# "Script: ./TP2-Ejercicio3.sh"
#"-------------------"
#"Integrantes:"
#"	Avila, Leandro - 35.537.983"
#"	Di Lorenzo, Maximiliano - 38.166.442"
#"	Lorenz, Lautaro - 37.661.245"
#"	Mercado, Maximiliano - 37.250.369"
#"	Sequeira, Eliana - 39.061.003"

get_help(){
 echo ""
    echo 'Ejemplo: ./TP2-Ejercicio3.sh carta_modelo.txt valores.csv'
    echo ""
    echo 'Parametro1: ruta del archivo txt con la carta con los tags a reemplazar'
    echo ""
    echo 'Parametro2: ruta del archivo csv separado por ";" con los valores a reemplazar en los tags de las cartas'
    echo ""
    echo 'Descripcion: Este scrip toma el primer archivo pasado por parametro y reemplaza las palabras que empiezan con "@ej" por los valores del segundo archivo que coinciden con el nombre, se generan las nuevas cartas por cada registro del segundo archivo, y se guardan en una carpeta que se crea en el directorio donde se corre el script'
echo ""
exit 0
}


if [ "$1" = "-h" ] || [ "$1" = "-?" ] || [ "$1" = "-help" ]
 then
 get_help
 exit 1
fi

#Validar cantidad de paramentros
if [ $# -eq 2 ]
then
	#Validar si existe el archivo
	if [ ! -f "$1" ] || [ ! -f "$2" ]
	    then
		echo "Archivo no existe"
		exit 0
	    else
		#archivo vacio?
		if [ ! -s "$1" ] || [ ! -s "$2" ]
		then
		    echo "Archivo Vacio"
		    exit 0
		fi
	    fi	
else
	    echo "La cantidad de parámetros ingresados no es correcta"
	    echo "Utilizar -h/-?/-help para ver la ayuda"
	    exit 0
fi

declare -a header
i=1
#Fecha para los nombres de los archivos
	dt=`date +"%Y%m%d%H%M"`
#Carpeta para las cartas
	folder="${0%/*}/Cartas_$dt"
	echo "Folder: $folder"
	mkdir "$folder"
while IFS= read -r line
do
#Proceso la primer linea
   if [ $i -eq 1 ]
   then   
      IFS=';' read -r -a header <<< "$line"
#Para formar el nombre del archivo de salida
      for idx in "${!header[@]}";
      do
	if [ "${header[idx]}" = "Nombre" ]
	then
		idxnom=$idx
	fi
	if [ "${header[idx]}" = "Apellido" ]
	then
		idxape=$idx
	fi
      done
   else
#Proceso las otras lineas
      IFS=';' read -r -a val <<< "$line"
#Cartas
	file_new="$folder/aviso_${val[idxape]}_${val[idxnom]}_$dt.txt"
	echo "Carta: $file_new"
	cat $1 > "$file_new"
 #Recorrer los titulos
      for index in "${!header[@]}";
      do
	title="@${header[index]}"	
	new=${val[index]}
        sed -i -e "s|${title}\b|${new}|gI" "$file_new"
      done
   fi
let "i++"
done < "$2";








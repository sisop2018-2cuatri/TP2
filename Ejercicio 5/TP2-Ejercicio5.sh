#!/bin/bash

verificar_path()
{
  if [ -f $1 ]
  then
    echo 'Ok'
  else
  echo "que paso"
    touch personas.txt ; echo 'IdPersona;DNI;Apellido_y_Nombre;idPais' > personas.txt;    
  fi

  if [ -f $2 ]
  then 
    echo 'Ok'
  else
    touch paises.txt ; echo 'IdPais;Nombre' > paises.txt;
  fi
}

dirPersonas='personas.txt'
dirPaises='paises.txt'

verificar_path $dirPersonas $dirPaises 

case $1 in
	 
	 -d|-D)
	    
		DNI=$2
		awk  -F ";" '$2==var {print $0}' var="$DNI" $dirPersonas;;
		
	 -a|-A)
         
         awk -F ";" '$1=="" {printf $1";"$2";"$3";"$4}' $1>$1;;
         
     -e|-E)
         
         #awk -F ";" '$2 != 35537983 {print}' $1;;
         awk '/35537983/ {while (/35537983/) ; next} 1' $1;;
         
     -p|-P)
         
         #awk -F ";" '$2 != 35537983 {print}' $1;;
         awk - F ";" ' $4==1 {a[$1]=$4; next} $2 in a {print $1,$2,$3,a[$2]}' OFS=';' $2 $1;;
         
	*)    exit;;
esac

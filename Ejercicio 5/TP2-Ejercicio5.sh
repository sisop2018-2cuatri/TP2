#!/bin/bash


get_help() {
   
    echo ""
    echo 'Nombre: ./TP2-Ejercicio5.sh'
    echo ""
    echo 'Parametro: <-d|-D> --- este parametro es utilizado para listar una persona en base al DNI'
    echo '           <-a|-A> --- este parametro es utilizado para agregar una persona al archivo en base al DNI, Apellido, Nombre, Nombre_Pais'
    echo '	     <-e|-E> --- este parametro es utilizado para eliminar a una persona del archivo  en base al DNI'
    echo '           <-p|-P> --- este parametro  es utilizado para mostrar todas las personas del mismo pais en base al nombre del mismo'
    echo ""
    echo 'Ejemplo: ./TP2-Ejercicio5.sh -d 1234567'
    echo '         ./TP2-Ejercicio5.sh -a 6667778 Gomez Peter'
    echo ' 	   ./TP2-Ejercicio5.sh -e 6667778'
    echo ' 	   ./TP2-Ejercicio5.sh -p Argentina' 
    echo ""
    echo 'Descripcion: Este script simula la gestion de una base de datos con un archivo csv en el cual se pueden listar, agregar o eliminar personas'
    echo ""
    echo ""
    echo "Sistemas Operativos"
    echo "-------------------"
    echo "Trabajo Práctico N°2"
    echo "Ejercicio 5"
    echo "Script: ./TP2-Ejercicio5.sh"
    echo "-------------------"
    echo "Integrantes:"
    echo "	Avila, Leandro - 35.537.983"
    echo "	Di Lorenzo, Maximiliano - 38.166.442"
    echo "	Lorenz, Lautaro - 37.661.245"
    echo "	Mercado, Maximiliano - 37.250.369"
    echo "	Sequeira, Eliana - 39.061.003"
    echo ""
    # fin mensaje de ayuda
    exit 0
}

verificar_parametros_1()
{
  
  if [ $# -ne 2 ]
    then
	echo 'Cantidad de parametros invalido'
	exit -1
    fi
}



verificar_parametros_2()
{
 if [[ $# -ne 5 && $4 =~ ^[a-zA-Z]+@[a-zA-Z] ]]
    then
	echo 'Cantidad de parametros invalido'
	exit -1
    fi
   
}

verificar_path()
{
  if [ -f $1 ]
  then
    echo ''
  else
    touch personas.txt ; echo 'IdPersona;DNI;Apellido_y_Nombre;IdPais' > personas.txt;    
  fi

  if [ -f $2 ]
  then 
    echo ''
  else
    touch paises.txt ; echo 'IdPais;Nombre' > paises.txt;
  fi
}

dirPersonas='personas.txt'	
dirPaises='paises.txt'

verificar_path $dirPersonas $dirPaises 

case $1 in
	 

	 -h|-help)
		
		get_help;;
	
	 -d)
	    	

		verificar_parametros_1 $@ 
		IFS=";" tokens=( `grep $2 $dirPersonas` )
	
		if [ ${#tokens[@]} -eq 0 ]
		then
		  echo "DNI $2 Inexistente"

		else
		  join -1 4 -2 1 -t \; $dirPersonas $dirPaises | awk -v var=$2 -F ";" ' $3==var {print $2";"$3";"$4","$5,$6}'
		  
		fi
;;		
	      
	 -a)
         	verificar_parametros_2 $@
		IFS=';' tokens=( `grep $5 $dirPaises` )
		 
		if [ ${#tokens[@]} -gt 0 ]
		then		 
                numLineasPais=${tokens[0]}
		   
		else
		numLineasPais=$(wc -l < "$dirPaises")
		   awk -v pathPaises=$dirPaises -v idPais=$numLineasPais -v nombrePais=$5 'NR==idPais {print idPais, nombrePais >> pathPaises }' OFS=";" $dirPaises
		fi
  
		IFS=';' tokens=( `grep $2 $dirPersonas` )
		 
		if [ ${#tokens[@]} -eq 0 ]
		then		 

		numLineas=$(wc -l < "$dirPersonas")
		
		 awk -v path=$dirPersonas -v IdPersona=$numLineas -v DNI=$2 -v Apellido=$3 -v Nombre=$4 -v IdPais=$numLineasPais -F ";" ' NR==IdPersona { print IdPersona";"DNI";"Apellido","Nombre";"IdPais  >> path}' $dirPersonas
                
		else
			echo "DNI duplicado"
		fi
		
		;;
        
     -e)
        
	 verificar_parametros_1 $@
	 IFS=";" tokens=( `grep $2 $dirPersonas` ) 
	 
	if [ ${#tokens[0]} -gt 0 ]
	  then
	    awk -v var=$2 -F ";" '$2 != var {print $0}' $dirPersonas > temp
	    rm $dirPersonas
	    mv temp $dirPersonas
	 else
	   echo 'DNI Inexistente'
	fi;;
         
     -p)
         
         verificar_parametros_1 $@
	 IFS=';' tokens=( `grep $2 $dirPaises` ) 

	if [ ${#tokens[0]} -gt 0 ]
	then         
	  join -1 4 -2 1 -t \; $dirPersonas $dirPaises | awk -v var=$2 -F ";" ' $5==var {print $2,$3,$4,$5}' OFS=';'
	else
	  echo 'No hay personas de ese pais'         
	fi;;

	*)    echo "Opción incorrecta"
	      echo "Elija -d DNI , para seleccionar un dni."
              echo "Elija -e DNI , para eliminar un registro."
              echo "Elija -a DNI Apellido NOmbre NombrePais , para agregar un registro."
              echo "Elija -p NombrePais , para seleccionar registros de ese pais."
;;
esac

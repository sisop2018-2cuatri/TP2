#!/bin/bash


get_help() {
    
    #mensaje de ayuda
    echo "`basename $0` version 1.0.0" 
    echo "Calcula fibonacci hasta un numero maximo que se envia por parametro"
    echo "Uso: ./TP2-Ejercicio2.sh numeroMaximo"
    echo "Parametros:"
    echo ' $1: numero entero que sirve como maximo valor a calcular en la serie'
    echo "Ejemplos de uso:"
    echo "./TP2-Ejercicio2.sh 5"
    echo "Salida: se mostrara por pantalla el numero de la serie anterior al numero maximo o el mismo en caso de estar en la serie, a su vez se guardara en un archivo salida.txt el resultado de cada paso calculado en la serie"
    
    #fin de mensaje de ayuda
    exit 0
}

verificar_parametros(){

if [ $# -ne 1 ]
 then 
 echo 'La cantidad ingresada de parametros no es correcta'
 echo 'Utilizar -h/-?/-help para ver la ayuda'
 exit -1
fi

if [[ $1 == -h ]] || [[ $1 == -help ]] || [[ $1 == -? ]];
 then
 get_help
fi
}

Calcular ()
{
  
 if [[ $2 -le $3 ]];
 then
 echo "Ejecucion $4: $2" >> "`pwd`/salida.txt"
 Calcular $2 $(expr $1 + $2) $3 $(expr $4 + 1)	
 else
 echo "Ejecucion exitosa... valores guardados en `pwd`/salida.txt"
 fi
}

verificar_parametros $1

if [ -f "`pwd`/salida.txt" ];
then
rm "`pwd`/salida.txt"
fi

if [[ $1 -eq 0 ]];
then
touch "`pwd`/salida.txt"
echo "Archivo salida.txt creado"
else
Calcular 0 1 $1 1
fi
exit 0



#!/bin/bash


get_help() {
   
    echo 'Nombre: ./TP2-Ejercicio2.sh <CantMax>'
    echo 'Parametro: <CantMax> --- es un parametro con la cantidad maxima de veces a calcular'
    echo 'Ejemplo: ./TP2-Ejercicio2.sh 5'
    echo '-------------------------------------------------------------------'
    echo 'Descripcion: Este script muestra de manera recursiva un parametro calculado una cantidad maxima de veces y guarda la secuencia de pasos en un archivo salida.txt'
    exit
}

verificar_parametros(){

if [ $# -ne 1 ]
 then 
 echo 'La cantidad ingresada de parametros no es correcta'
 echo 'Utilizar -h/-?/-help para ver la ayuda'
 exit -1
fi

if [ $1 = '-h' -o $1 = '-?' -o $1 = '-help' ]
 then
 get_help
 exit 1
fi
}

Calcular ()
{
 if [ ! $3 -eq 0 ];
 then
 echo "Ejecucion $4:  ( Parametro 1 = $1 | Parametro 2 = $2 | Parametro 3 = $3 )" >> salida.txt
 Calcular $2 $(expr $1 + $2) $(expr $3 - 1) $(expr $4 + 1)
 else
 #si no vuelvo a imprimir esta linea no muestra el ultimo paso porque salio antes.
 echo "Ejecucion $4:  ( Parametro 1 = $1 | Parametro 2 = $2 | Parametro 3 = $3 )" >> salida.txt
 echo $2
 fi
}

verificar_parametros $1
Calcular 0 1 $1 1
exit 0



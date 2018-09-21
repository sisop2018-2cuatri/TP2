#!/bin/bash

#a) Este script realiza la suma aritmetica entre argumentos recursivamente.

#c) Las comillas doble y simples se usan para cadenas. Las ' interpretan todo como texto mientras que las " pueden interpretar variables. El acento grave sirve para obtener el resultado de la ejecucion de un comando.

#d) El comando let permite crear variables numericas y realizar operaciones aritmeticas en la misma.
#   El comando expr evalua condiciones aritmeticas
#   El comando test sirve para evaluar una expresión, condición, comprobar los atributos de ficheros y realizar comparaciones de  cadenas y aritméticas. Devolviendo un valor de cero 0 (true) ó uno 1 (false).

#e) if [Condicion]
#     then <comandos>
#   fi

#   for iterador in <lista>
#      do <comandos>
#   done

#   while [Condicion]
#   do 
#     <comandos>
#   done

#f) if [$1 -gt 100]
#   then 
#    echo "El numero es mayor a 100"
#   fi

#  for name in $names
#   do 
#     echo $name
#   done

#  while [$counter -le 10]
#  do
#    echo $counter
#    ((counter++))
#  done


Calcular ()
{
 if [ ! $3 -eq 5 ];
 then
 Calcular $2 $(expr $1 + $2) $(expr $3 + 1)
 else
 echo $2
 fi
}
if [ ! $# -eq 0 ];
then
 echo "Este script no admite parametros"
 exit 1
fi

Calcular 0 1 0
exit 0

#!/bin/bash

verificar_path()
{
  if [ -f $1 ]
  then
    echo 'Ok'
  else
    touch $1 ; echo 'IdPersona;DNI;Apellido_y_Nombre;idPais' > $1;    
  fi

  if [ -f $2 ]
  then 
    echo 'Ok'
  else
    touch $2 ; echo 'IdPais;Nombre' > $2;
  fi
 exit 0
}

verificar_path $1 $2 

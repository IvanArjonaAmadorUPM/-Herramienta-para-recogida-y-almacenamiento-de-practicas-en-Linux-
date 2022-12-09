function opcion1(){
echo "Menú 1 - Programar recogida de prácticas"

  read -p "Asignatura cuyas prácticas desea recoger:" asignatura
  read -p "Ruta para las cuentas de los alumnos:" directorio_origen
  read -p "Ruta para almacenar prácticas:" directorio_destino

  echo
  echo "Se va a programar la recogida de las prácticas de $asignatura para mañana a las 8:00. Origen: $directorio_origen. Destino: $directorio_destino."
  echo

  read -p "¿Está de acuerdo (s/n)?" confirmation

  if [ "$confirmation" = "s" ]; then
    movePrac $asignatura $directorio_origen $directorio_destino
    else
     read -p "¿quiere volver a escribir los parámetros (s/n)?" repetir
     if [ "$repetir" = "s" ]; then
       opcion1
     fi
  fi

}

function movePrac(){

# Comprobar si el directorio origen existe
if [ ! -d "$2" ]; then
  echo "Error: el directorio origen no existe, vuelve a introducir la información"
  crearTraza "No existe el directorio de origen $2 donde deberían encontrarse las prácticas de los alumnos"
  opcion1
  exit 1
fi

# Crear el directorio destino si no existe
if [ ! -d "$directorio_destino" ]; then
    echo "el directorio de destino $3 no existe"
    echo "se procede a crear el directorio $3"
    mkdir -p "$directorio_destino"
    crearTraza "No existía el directorio de destino para mover las prácticas. Se ha creado el directorio $3"
fi

linea_comando="0 8 * * * /home/alumno/Escritorio/recoge-prac.sh $asignatura $directorio_origen $directorio_destino"

# Agregar la tarea al planificador cron
 echo "$linea_comando" | crontab
 echo "Se ha programado la recogida de las prácticas de $asignatura para mañana a las 8:00. Origen: $directorio_origen. Destino: $directorio_destino"
}

function opcion2(){
  echo "Menú 2 - Empaquetar prácticas de la asignatura"

  read -p "Asignatura cuyas prácticas desea empaquetar:" asignatura
  read -p "Ruta absoluta del directorio de prácticas:" ruta

  echo
  echo "Se va a empaquetar las prácticas de la asignatura $asignatura presentes en el directorio $ruta."
  echo

  read -p "¿Está de acuerdo (s/n)?" confirmation

  if [ "$confirmation" = "s" ]; then
    if [ -d $ruta ]; then
      empaquetar $asignatura $ruta
    else
      echo "El directorio $ruta no existe"
      echo
    fi
  else
     read -p "¿quiere volver a escribir los parámetros (s/n)?" repetir
     if [ "$repetir" = "s" ]; then
       opcion2
     fi
  fi

}

function empaquetar(){
  fechaActual=$(date "+%y%m%d")
  tar -czf "/home/prac/backups/$1-$fechaActual.tgz" $2
  crearTraza "Se ha empaquetado la asignatura $1 en el directorio /home/prac/backups"
}

function opcion3(){
  read -p "Asignatura de la que queremos obtener la información " asignatura
  fichero = $(ls -t /home/prac/backups/$asignatura* | head -1)


  if [ -f $fichero ]; then
    info_fichero=$(stat "$fichero")
    tamaño=$(ls -l $fichero | awk '{print $5}')
    echo "El fichero generado es $fichero y ocupa $tamaño bytes."
    else
      crearTraza "El fichero no ha sido encontrado"
  fi
}
function crearTraza(){
    ruta_archivo_trazas="/home/prac/informe-prac.log"
    fecha_hora=$(date +"%Y-%m-%d %H:%M:%S")
    echo "$fecha_hora $1" >> "$ruta_archivo_trazas"
}
fin=1

echo "ASO 22/23 - Práctica 6"
echo "Iván Arjona Amador"
echo "Gestión de prácticas"
echo "------------------------"

while [ $fin -eq "1" ]
  do
    echo "Menú"
    echo -e "\t 1) Programar recogida de prácticas"
    echo -e "\t 2) Empaquetado de prácticas de una asignatura"
    echo -e "\t 3) Ver tamaño y fecha del fichero de una asignatura"
    echo -e "\t 4) Finalizar programa"

    read -p "Opción: " opcion

    if [ "$opcion" -eq "1" ]; then
      opcion1
    fi

    if [ "$opcion" -eq "2" ]; then
      opcion2
    fi

    if [ "$opcion" -eq "3" ]; then
      opcion3
    fi

    if [ "$opcion" -eq "4" ]; then
      echo "El programa se cerrará"
      fin=0
    fi
  done




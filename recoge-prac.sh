
  lista=$(ls $2)
  for i in $lista
  do
    if [ -f "$2/$i/prac.sh" ];then
       cp "$2/$i/prac.sh" "$3/$i.sh"
    else
      crearTraza  "$i no tiene la practica en su escritorio"
    fi
  done



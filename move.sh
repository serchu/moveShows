#!/bin/bash

#Dar permisos para poder mover y que en XBMC se puedan descargar los subtitulos:
downloadPath=/media/fd5b5a96-f03b-46b9-94be-a04ce971d3a7/torrent/finish/;
cd $downloadPath;
chmod 777 *
echo "Permisos dados a los archivos de la carpeta descargas";


#Mover el archivo a la carpeta correspondiente:
#TODO: Bucle para que mueva todos los archivos buscados y no sólo uno
#TODO: Periscope para que descargue el subtitulo antes de mover el archivo a su carpeta correspondiente
carpetas=("The Big Bang Theory" "How I Met Your Mother" "Sherlock" "The Walking Dead");
claves=("Big.Bang" "How.I.Met" "Sherlock" "The.Walking.Dead");

for i in {0..3}
        do
                claveActual=${claves[i]};
                carpetaActual=${carpetas[i]};
                echo $claveActual;
                echo $carpetaActual; #Muestra lo que se está buscando

                ARCHIVO=$(ls | grep $claveActual);
                #echo $ARCHIVO; #Muestra el nombre del archivo que se va a mover

                NUM=$(ls | grep $claveActual | wc -l);
                echo $NUM; #Muestra el numero de archivos que coinciden con lo buscado

                if [ $(ls | grep $claveActual | wc -l) = 0 ];
                        then 
                                echo No hay archivos para mover;
                        else
                                cd "$ARCHIVO"
                                video=$(ls | grep .mkv);
                                periscope -l es $video;
                                cd ..;
                                mv "$ARCHIVO" "/media/fd5b5a96-f03b-46b9-94be-a04ce971d3a7/torrent/finish/Series/$carpetaActual/";
                                echo Movido correctamente el archivo: "$ARCHIVO";
                fi
        done
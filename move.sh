#!/bin/bash

#Dar permisos para poder mover y que en XBMC se puedan descargar los subtitulos:
downloadPath=/media/fd5b5a96-f03b-46b9-94be-a04ce971d3a7/torrent/finish/;
cd $downloadPath;
chmod 777 *
echo "--------------------------------------"
echo "Permisos dados a los archivos de la carpeta descargas";
echo "--------------------------------------"
echo "--------------------------------------"

#Mover el archivo a la carpeta correspondiente:
#TODO: Bucle para que mueva todos los archivos buscados y no sólo uno
carpetas=("The Big Bang Theory" "Sherlock" "The Walking Dead" "Fargo" "Game of Thrones");
claves=("Big.Bang" "Sherlock" "The.Walking.Dead" "Fargo" "Game.of.Thrones");

for i in {0..4}
        do
                claveActual=${claves[i]};
                carpetaActual=${carpetas[i]};
                echo $claveActual;
                echo $carpetaActual; #Muestra lo que se está buscando

                NUM=$(ls | grep $claveActual | wc -l);
                echo $NUM; #Muestra el numero de archivos que coinciden con lo buscado
                
                if [ $NUM = 0 ];
                        then 
                                echo No hay archivos para mover;
                        else
                                ARCHIVO=$(ls | grep $claveActual);
                                #Subtitle:
                                cd "$ARCHIVO"
                                video=$(ls | grep .mkv);
                                periscope -l es $video;
                                cd ..;
                                #Move
                                mv "$ARCHIVO" "/media/fd5b5a96-f03b-46b9-94be-a04ce971d3a7/torrent/finish/Series/$carpetaActual/";
                                echo Movido correctamente el archivo: "$ARCHIVO";
                fi
        echo "--------------------------------------"
        done
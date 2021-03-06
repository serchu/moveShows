#!/bin/bash

# Give permissions to the episodes

downloadsPath=/media/fd5b5a96-f03b-46b9-94be-a04ce971d3a7/torrent/finish
destinoPath=/media/fd5b5a96-f03b-46b9-94be-a04ce971d3a7/torrent/finish/Series

chmod 777 $downloadsPath/*
echo "--------------------------------------"
echo "Changed permissions to the episodes for moving them later";
echo "--------------------------------------"
echo "****************************************"

#Move the episodes from the downloads directory to the appropiate folder:
echo $(date +"%d/%m/%Y - %H:%M") "Script starts.." >> $downloadsPath/shows_log.txt
tvShowsList=$(cat $downloadsPath/shows.txt)

for show in $tvShowsList; do
        claveAsociada= #TODO: Mirar como hacer para definir la clave de búusqueda
        if [ ! -d $destinoPath/$show ]; then 
                mkdir $destinoPath/$show #Crear directorio destino de la serie si este no existe
        fi
        echo "Searching episodes for $show ...."
        numCaps=$(ls $downloadsPath | grep $claveAsociada | wc -l)
        echo $numCaps
        case $numCaps in
                0) echo "There's no episodes for $show" ;;

                1) echo "There's 1 episode for $show"
                        #TODO: Mirar si lo enontrado es archivo o carpeta, pues a veces va con carpeta y otras el archivo de video suelto
                        # En caso de encontrar un archivo mover directamente y luego buscar subtitulos
                        episode_folder=$(ls $downloadsPath | grep $claveAsociada)
                        #TODO: mirar archivo con mayor tamaño o alguna otra cosa para determinar el video, en vez de .mkv
                        video_file=$(ls $downloadsPath/$episode_folder | grep .mkv) 
                        echo "Searching subtitles for episode: $video_file"
                        periscope -l es $downloadsPath/$episode_folder/$video_file
                        mv $downloadsPath/$episode_folder $destinoPath/$show
                        echo "Moved episode succesfully: $episode_folder"
                        echo $(date +"%d/%m/%Y - %H:%M") " ->> Episode $episode_folder moved succesfully" >> $downloadsPath/shows_log.txt
                        ;;

                *) echo "There's 2 or more episodes for $show"
                        $episodes_list=$(ls $downloadsPath | grep $claveAsociada)
                        for episode in episodes_list; do
                                video_file=$(ls $downloadsPath/$episode | grep .mkv)
                                periscope -l es $downloadsPath/$episode/$video_file
                                mv $downloadsPath/$episode $destinoPath/$show
                                echo Moved episode succesfully: $episode
                                echo "----------------"
                        done
                        echo "Moved $numCaps episodes of $show "
                        echo $(date +"%d/%m/%Y - %H:%M") " ->> $numCaps episodes of $show moved succesfully" >> $downloadsPath/shows_log.txt
                        ;;
        esac
        echo "****************************************"
done

echo $(date +"%d/%m/%Y - %H:%M") "Script ends.." >> $downloadsPath/shows_log.txt

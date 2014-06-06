#!/bin/bash

# Give permissions to the episodes

downloadsPath=/media/fd5b5a96-f03b-46b9-94be-a04ce971d3a7/torrent/finish
destinoPath=/media/fd5b5a96-f03b-46b9-94be-a04ce971d3a7/torrent/finish/Series

chmod 777 $downloadsPath/*
echo "--------------------------------------"
echo "Changed permissions to the episodes for moving them later";
echo "--------------------------------------"
echo "--------------------------------------"

#Move the episodes from the downloads directory to the appropiate folder:

tvShowsList=$(cat shows.txt)

for show in $tvShowsList; do
        echo "Searching episodes for $show"
        numCaps=$(ls $downloadsPath | grep $claveAsociada | wc -l)
        echo $numCaps
        case $numCaps in
                0 ) echo "There's no episodes for $show" ;;

                1 ) echo "There's 1 episode for $show"
                        #TODO: Mirar si lo enontrado es archivo o carpeta, pues a veces va con carpeta y otras el archivo de video suelto
                        episode_folder=$(ls $downloadsPath | grep $claveAsociada)
                        video_file=$(ls $downloadsPath/$episode_folder | grep .mkv) #TODO: mirar archivo con mayor tamaño o alguna otra cosa para determinar el video
                        periscope -l es $video_file
                        mv $downloadsPath/$episode_folder $destinoPath/$show
                        echo Moved episode succesfully: $episode_folder
                        ;;

                * ) echo "There's 2 or more episodes for $show"
                        $episodes_list=$(ls $downloadsPath | grep $claveAsociada)
                        for episode in episodes_list; do
                                video_file=$(ls $downloadsPath/$episode | grep .mkv)
                                periscope -l es $video_file
                                mv $downloadsPath/$episode $destinoPath/$show
                                echo Moved episode succesfully: $episode
                        done
                        ;;
        esac
done
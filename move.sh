#!/bin/bash

######################## GLOBAL VARIABLES ########################

downloadsPath=/media/fd5b5a96-f03b-46b9-94be-a04ce971d3a7/torrent/finish
destinoPath=/media/fd5b5a96-f03b-46b9-94be-a04ce971d3a7/torrent/finish/Series

######################## FUNCTIONS ########################

function moveEpisode { # $1 - Name of the Show
        
        resul=$1

        if [ ! -d $downloadsPath/$resul ]; 
                then
                        # If it's not directory... Create a directory named as the episode but without the extension of the video
                        episode_folder=$(echo $resul | cut -d '.' f1) # Delete the extension of the video file
                        mkdir $downloadsPath/$episode_folder # Create the folder for the episode
                        mv $downloadsPath/$episode $downloadsPath/$episode_folder # Move the episode to that folder
                else    
                        episode_folder=$(echo $resul)
        fi

        #TODO: mirar archivo con mayor tamaño o alguna otra cosa para determinar el video, en vez de .mkv                        
        video_file=$(ls $downloadsPath/$episode_folder | grep .mkv) 
        echo "Searching subtitles for episode: $video_file"
        periscope -l es $downloadsPath/$episode_folder/$video_file

        mv $downloadsPath/$episode_folder $destinoPath/$show
        echo "Episode moved succesfully: $episode_folder"
        echo "----------------"
}




######################## MAIN ########################


chmod 777 $downloadsPath/*
echo "--------------------------------------"
echo "Changed permissions to the episodes for moving them later";
echo "--------------------------------------"
echo "****************************************"

#Move the episodes from the downloads directory to the appropiate folder:
echo $(date +"%d/%m/%Y - %H:%M") "Script starts.." >> $downloadsPath/shows_log.txt

while read show ; do
        claveShow=$(echo $show | tr " " .)
        echo $claveShow
        if [ ! -d $destinoPath/$show ]; then 
                mkdir $destinoPath/$show #Crear directorio destino de la serie si este no existe
        fi
        echo "Searching episodes for $show ...."
        numCaps=$(ls $downloadsPath | grep "$claveShow" | wc -l)
        echo $numCaps
        case $numCaps in
                0) echo "There's no episodes for $show" ;;

                1) echo "There's 1 episode for $show"

                        resul=$(ls $downloadsPath | grep "$claveShow")
                        moveEpisode $resul

                        echo $(date +"%d/%m/%Y - %H:%M") " ->> Episode $episode_folder moved succesfully" >> $downloadsPath/shows_log.txt
                        ;;

                *) echo "There's $numCaps episodes for $show"

                        resul_list=$(ls $downloadsPath | grep "$claveShow")

                        for resul in resul_list; do
                                moveEpisode $resul
                        done

                        echo "Moved $numCaps episodes of $show "
                        echo $(date +"%d/%m/%Y - %H:%M") " ->> $numCaps episodes of $show moved succesfully" >> $downloadsPath/shows_log.txt
                        ;;
        esac
        echo "****************************************"
done < $downloadsPath/shows.txt


echo $(date +"%d/%m/%Y - %H:%M") "Script ends.." >> $downloadsPath/shows_log.txt

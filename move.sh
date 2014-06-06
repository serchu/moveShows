#!/bin/bash

# Give permissions to the episodes

downloadPath=/media/fd5b5a96-f03b-46b9-94be-a04ce971d3a7/torrent/finish/
chmod 777 $downloadPath/*
echo "--------------------------------------"
echo "Changed permissions to the episodes for moving them later";
echo "--------------------------------------"
echo "--------------------------------------"

#Move the episodes from the downloads directory to the appropiate folder:

tvShowsList=$(cat shows.txt)

for show in $tvShowsList; do
        echo "Searching episodes for $show"
        numCaps=$(ls | grep $claveAsociada | wc -l)
        echo $numCaps
done
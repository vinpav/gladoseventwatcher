#!/bin/bash
# This script watches for file creations in the specified folder and sends them by email

if [ "$1" == "start" ]; then
inotifywait -m $2 -e create |
    while read path action file; do
        echo "The file '$file' appeared in directory '$path' via '$action'"
        echo "The file '$file' appeared in directory '$path' via '$action'" | mail -s "Glados watch event" $3 -A $path$file
    done
elif [ "$1" == "stop" ]; then
	echo "Shutting down Glados watcher on directory '$path'"
	killall *gladosfilewatcher*
else
	echo "Usage : ./gladosfilewatcher.sh start|stop folder_to_watch notification_email"
fi

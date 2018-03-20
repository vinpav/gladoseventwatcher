#!/bin/bash
# This script watches for file creations in the specified folder and sends them by email

if [ "$1" == "start" ]; then
	echo "Setting watcher on " $2
	if [ $# == 3 ]; then
		echo "Gladosfilewatcher will notify " $3
	else
		echo "Notifier email not set : logging to output file only"
	fi

	inotifywait -m $2 -e create |
    while read path action file; do
        echo "The file '$file' appeared in directory '$path' via '$action'"
				if [ $# == 3 ]; then
					echo "Sending mail to "$3
			        	echo "The file '$file' appeared in directory '$path' via '$action'" | mail -s "Glados watch event" $3 -A $path$file
				fi
    done
elif [ "$1" == "stop" ]; then
	echo "Shutting down Glados watcher on directory '$path'"
	killall *gladosfilewatcher*
else
	echo "Usage : ./gladosfilewatcher.sh start|stop folder_to_watch notification_email"
fi

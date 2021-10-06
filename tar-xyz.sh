#!/bin/bash

checkifstar(){
# turns out star has no version option
#if ! star -v &> /dev/null 
if [ ! -f /usr/bin/star ] 
then 
	echo "Star is not installed, please install and run again"
	exit 2
fi 

starvalue=$(file "$1" | awk -F '.' '{print $2}' | awk -F ' ' '{print $1}')

if [ "$starvalue" == "star:" ]
then
	echo "is star"
	if [ "$2" == "unzip" ]
	then
		star -x -f="$1"
	elif [ "$2" == "view" ]
	then
		star -t -f="$1"
	else
		star -xattr -H=exustar -c -f="$2" "$1"
		echo "star created"
		file "$2" 
	fi
	exit 0
fi
}

if [ -z "$1"  ]
then
    echo -e "Supply a directory or file when running the script\n"
    echo "Example: tar-xyz.sh /dir OR tar-xyz.sh file"
    exit 2
else
    ls -ald $1 || ls -al $1
    echo -e "Options\n1) Create gzip archive \n2) Create bzip archive\n3) Create xz archive\n4) Create star archive\n5) View\n6) Unzip\n7) Exit"
    read -r OPTION
    clear
    if [ "$OPTION" == "1" ] || [ "$OPTION" == "2" ] || [ "$OPTION" == "3" ] || [ "$OPTION" == "4" ]
    then  
        echo -e "Please supply a filename for your archive"
        read -r FILENAME
    fi
fi

case "$OPTION" in
    1)
        tar cvfz "$FILENAME" "$1"
        echo "gzip created"
        file "$FILENAME"
        exit 0
        ;; 
    2) 
        tar cvfj "$FILENAME" "$1" 
        echo "bzip created"
        file "$FILENAME"
        exit 0
        ;;
    3)
        tar cvfJ "$FILENAME" "$1" 
        echo "xz created"
        file "$FILENAME"
        exit 0
        ;;
    4) 
	checkifstart "$1" "$FILENAME"
	;;
    5)
	checkifstar "$1" "view"
        tar tvf "$1"
        exit 0
        ;;
    6)
	checkifstar "$1" "unzip"
        tar xvf "$1"
        exit 0
        ;;
    *)
        echo "Goodbye!"
        sleep .4 
        clear
        echo "..."
        sleep .5
        clear
        echo ".."
        sleep .5
        clear
        echo "."
        sleep .5
        clear
        echo " "
        clear
        exit 0
        ;;
esac

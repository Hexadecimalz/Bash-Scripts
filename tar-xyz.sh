#!/bin/bash

if [ -z "$1"  ]
then
    echo -e "Supply a directory or file when running the script\n"
    echo "Example: tar-xyz.sh /dir OR tar-xyz.sh file"
    exit 2
else
    ls -ald $1 || ls -al $1
    echo -e "Options\n1) Create gzip archive \n2) Create bzip archive\n3) Create xz archive\n4) View\n5) Unzip\n6) Exit"
    read -r OPTION
    clear
    if [ "$OPTION" == "1" ] || [ "$OPTION" == "2" ] || [ "$OPTION" == "3" ]
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
        tar tvf "$1"
        exit 0
        ;;
    5)
        tar xvf "$1"
        exit 0
        ;;
    *)
        echo "Goodbye!"
        sleep 1 
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

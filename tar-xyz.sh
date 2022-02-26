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

if [ "$starvalue" == "star:" ] || [ "$2" == "archive" ]
then
	if [ "$2" == "unzip" ]
	then
		star -x -f="$1"
	elif [ "$2" == "view" ]
	then
		star -t -f="$1"
	else
		star -xattr -H=exustar -c -f="$3" "$1"
		echo "star created"
		file "$3" 
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
    read -r option
    clear
    if [ "$option" == "1" ] || [ "$option" == "2" ] || [ "$option" == "3" ] || [ "$option" == "4" ]
    then  
        echo -e "Please supply a filename for your archive"
        read -r filename
    fi
fi


isstar=$(file "$1" | awk -F '.' '{print $2}' | awk -F ' ' '{print $1}')

if [ "$isstar" == "star:" ] 
then
	isstar=1 
fi

case "$option" in
    1)
        tar cvfz "$filename" "$1"
        echo "gzip created"
        file "$filename"
        exit 0
        ;; 
    2) 
        tar cvfj "$filename" "$1" 
        echo "bzip created"
        file "$filename"
        exit 0
        ;;
    3)
        tar cvfJ "$filename" "$1" 
        echo "xz created"
        file "$filename"
        exit 0
        ;;
    4) 
	checkifstar "$1" "archive" "$filename"
	;;
    5)
	if [ "$isstar" == "1" ] 
	then
		checkifstar "$1" "view"
	else
		tar tvf "$1" 
	fi 
        exit 0
        ;;
    6)
	if [ "$isstar" == "1" ]
	then
		checkifstar "$1" "unzip"
	else
	        tar xvf "$1"
	fi
        exit 0
        ;;
    *)
        echo "Goodbye!"
        sleep .2
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

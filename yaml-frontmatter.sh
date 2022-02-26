#!/usr/bin/env bash 
# Interactively creates files for Zettlr notes based on the pattern module-x-x
# Adds Yaml frontmatter to the beginning of each file to save some time 
# Front matter also creates some h2 section headings as well
frontmatter(){
frontmatter=$(cat <<EOF
---
title: $1 $2
keywords:
- kw
...

## 

## 

## 

##  

EOF
)
echo "$frontmatter" >> $3
}

createfiles(){
	for (( i=1; i<=$2; i++ )) 
	do 
		echo "What is the section($i)'s name?" 
		read "name"
		filename=module-$1-$i.md
		touch $filename
		frontmatter "$1-$i" "$name" "$filename"
		echo "Module $1 creation is complete" 
	done
}

createmodule(){
echo "Which module/chapter should we create?"
read "MODULENUM" 
echo "How many lesson groups in this module/chapter?" 
read "LESSONS"
createfiles "$MODULENUM" "$LESSONS"
}

createmodule

while true
do 
	clear
	echo "Would you like to create another module/chapter? Yes / No?"
	read "RESPONSE"
	case $RESPONSE in
		Yes | Y | y | 1)createmodule;;
		*)echo "Goodbye" && clear && break;;
	esac
done

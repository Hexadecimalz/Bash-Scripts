#/usr/bin/env bash
# Sed Stars 
# In Python you can fairly easily print out a lot of characters by multiplication
# The idea here is to create a fuction to print a character a consistent number of times
# I'm sure there are better ways to do this, but it was fun to try with sed. 
sedstars(){
stars="$1"
andstring=""
for (( i=1;i<=$stars;i++ )) 
do
	andstring+="& "
done
echo "*" | sed "s+*+$andstring+"
}


sedstars 25 
sleep .5
sedstars 24
sleep .5 
sedstars 23
sleep .5 
sedstars 22
sleep .5 
sedstars 21
sleep .5 
sedstars 20 
sleep .5 
sedstars 19
sleep .5 
sedstars 18
sleep .5 
sedstars 17
sleep .5 
sedstars 16
sleep .5 
sedstars 15
sleep .5 
sedstars 14
sleep .5 
sedstars 13
sleep .5 
sedstars 12
sleep .5 
sedstars 11
sleep .5 
sedstars 10
sleep .5 
sedstars 9
sleep .5 
sedstars 8


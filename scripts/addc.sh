#!bin/bash

if [ $# = 0 ]; then
	echo "Usage: {$0} new_file_name"
	exit 1
fi

sed "s/FILENAME/$1/g" ~/scripts/templates/cfile.c > ./src/$1.c
sed "s/FILENAME/${1^^}/g" ~/scripts/templates/cheader.h > ./lib/$1.h

sed -i "s|OBJFILES\s:=|OBJFILES\t:= build/$1.o\n\t\t\t\t|g" ./Makefile


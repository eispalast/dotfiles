#!/bin/bash

if [ $# = 0 ]; then
	echo "Usage: {$0} project_name"
	exit 1
fi

mkdir -p build src lib

sed "s/PROJECT_NAME/$1/g" ~/scripts/templates/main.c >> ./src/$1.c 
sed "s/PROJECT_NAME/$1/g" ~/scripts/templates/Makefile >> ./Makefile 
~/scripts/cdebug $1

# init git repo if not yet there
git status 2> /dev/null 
if [ $? -ne 0 ]; then
    touch .gitignore
    git init
fi




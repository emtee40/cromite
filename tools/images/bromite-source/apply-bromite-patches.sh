#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

sudo apt install sed

cd chromium/src

echo -e ${RED} ------- remove v8 subrepo ${NC}
rm -rf v8/.git
git add -f v8
git commit -m ":NOEXPORT: v8 repo"

echo -e ${RED} ------- apply patches ${NC}
for file in $(cat ../../cromite/build/bromite_patches_list.txt) ; do

   if [[ "$file" == *".patch" ]]; then
	#if [[ "$file" == *"Automated-domain-substitution"* ]]; then
	#	echo -e ${RED} " -> Excluding $file" ${NC}
	#	continue
	#fi
	
	echo -e ${RED} " -> Apply $file" ${NC}

	REPL="0,/^---/s//FILE:"$(basename $file)"\n---/"
	cat ../../cromite/build/patches/$file | sed $REPL | git am

	if [ $? -ne 0 ]
	then
            echo -e "Error on ../../cromite/build/patches/${file}"
            exit 1
	fi

	echo " "
    fi
    
done

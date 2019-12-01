Command for Linux system

./file.sh  - file execution


	to find the command we need. In this case we use conveyor with command grep
	How it works - command history return string type information with data,
	then we follow this information to grep and as result command return for us
	lines with occurrences 'head' in history   

===================
conveyor (|)
history | grep ls -n
history | grep 'ls' -n    - it is possible to use '' for atributes 
'|' this symbol means that output result from 'history' follow to input to 
command 'grep'
==============	

cal - 		calendar with current date
date - 	current date and time
	date +%A   current weekday
	date +%B   current month

wget [direct url path to file] downloader for linux. Allow user to download file
	wget https://download.cdn.viber.com/cdn/desktop/Linux/viber.deb	

man [function] - manual(instraction) for function
pwd      - my current location
chmod +x(executable file)   change attribute for file
	chmod +x hello-world.sh
		#!/bin/bash
		echo "Hello World"
	"Hello World"
	
rm -r(recursively)   remove file or dirrectory recursively	

Compress (not archive) files / folders
tar -cvf(compress verbose file) [filename(result)] [filename(to comress)]
tar -tf(test file) [filename]
tar -xvf(extract verbose file) [filename]

BASH_VERSION  

======================================================
VARIABLES

user=$(whoami)            => whoami (returns the usersID)
input=/home/$user
If after variable need to insert the other characters, this variable necessary to
cover with curly braces
output=/tmp/${user}_home_$(date +%Y-%m-%d_%H%M%S).tar.gz
======================================================
Input, Output and Error Redirections

Some ways to redirecting the output error massages

ls -lR > dir-tree.list
Redirect all list of the dir tree  to file dir-tree.list

If we need to redirect error messages to text file
ls -lR 2> dir-tree.list

if we need to append messages to text file
ls -lR 2>> dir-tree.list

if we need to redirect any messages to text file
ls -lR 2>&1 dir-tree.list

==============================================================================
Find method

find $1 -type f   method  finds items type file    
find $1 -type d   method  finds items type dirrectory

===================================================
if else Statemants

if [ $num_a -lt $num_b ]; then
    echo "$num_a is less than $num_b!"
fi

===================================================
Positional argument parameters









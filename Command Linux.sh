Command for Linux system

./file.sh  - file execution
nano - simple additor of text file
	nano [filename.txt] if file does not exist, nano create new file

mv [file_in] [file_out] rename the file
ln -s [target] [shortcut_file]  - create the shortcutF
	ln -s /home/django/kofee.ini /etc/uwsgi/vassals/
ls - 		list of dirrectory

htop [system and resource information]

head [-5] [name of file]- read 5 strings of file from head
	head -5 posit.sh
tail [5] [name of file] - read 5 strings of file from down
	tail -5 posit.sh
tail -f posit.sh - allow user to read file in online mode	
grep ['slug'][filename] - serch occurrences of slug inside the file
	grep 'echo' posit.sh
	grep aditional keys -c - quantity of occurrences
	grep		        -n - full string of occurrences
history  - shows the commands inserted into the bash
	history | grep head  - returns the history inputs for bash with command head
	For Example we need to find command which we insert into he bash, but the 
	time life of the terminal is too long and we need to spend a lot of time
	to find the command we need. In this case we use conveyor with command grep
	How it works - command history return string type information with data,
	then we follow this information to grep and as result command return for us
	lines with occurrences 'head' in history   

read -p [same as input in python]
	read -sp [for password purposes hide input]
	
==============
Konnectors
&&  First command executed always, second command executed only if First
	command completes successfully
||  First command executed always, second command executed only if First
	command does not completes
;   Commands always executed 
	Example
					$ true && echo Hello
				  		Hello
					$ false || echo Hello
						Hello
					$ echo Hello ; ls
						Hello
  						test.txt file1.txt file2.txt 
===================

===================
Conveyor or Pipes
(|) allow us to connect output from first comand to input second command
Example
ls -l | head -15    [show the list of first 15 files(dirrectories)]
history | grep ls -n
history | grep 'ls' -n    - it is possible to use '' for atributes 

==============	

cal - 		calendar with current date
date - 	current date and time
	date +%A   current weekday
	date +%B   current month

wget [direct url path to file] downloader for linux. Allow user to download file
	wget https://download.cdn.viber.com/cdn/desktop/Linux/viber.deb	

man [function] - manual(instraction) for function
pwd      - my current location
which python - commant to show location of programm
chmod +x(executable file)   change attribute for file
	chmod +x hello-world.sh  
	chmod 753  - 7[owner of file] 5[grooup]  3[permission thet they have]
		#!/bin/bash
		echo "Hello World"
	"Hello World"
	
rm   remove file 
rmdir remove dirrectory	

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









# Cheat sheet
## Documentation
	info
	man		-	used to view documentation.
		-man -k socket
		-man 7 socket
		-gnome-help man:printf
	#/usr/share/doc
	GNOME: gnome-help or yelp
	KDE: khelpcenter

## Packages
	gnome-tweaks 		-	old gnome GUI
	gnome-extensions-app -	new gnome GUI
	sudo apt install gedit-plugins
	sudo systemctl disable cups - print service

## Wildcards
	Wildcard    Result
	? 	        Matches any single character
	*           Matches any string of characters
	[set]       Matches any character in the set of characters, for example     [adf] will match any occurrence of a, d, or f
	[!set]      Matches any character not in the set of characters
	|			User for pipes

## File Streams

	stdin	-	value 0		-	Standard Input (as keyboard)
	stdout	-	value 1		-	Standard Outpt (as terminal)
	stderr	-	value 2		-	Standard Error (as log file)

	Example for send value 1 and 2 within same command
	df -hT >& all-output-file

## Basic utilities

	cat		-	used to type out a file (or combine files)
	head	-	used to show the first few lines of a file.
	tail	-	used to show the last few lines of a file.
	less -N	-	used to view file content

## Locate apps

	which docker	-	/usr/local/bin/docker
	whereis docker	-	docker: /usr/bin/docker /usr/lib/docker /etc/docker /usr/local/bin/docker /usr/libexec/docker /usr/share/man/man1/docker.1.gz

## Directories and files

	pwd			-	Displays the present working directory
	cd ~ or cd 	-	Change to your home directory (shortcut name is ~ (tilde))
	cd .. 		-	Change to parent directory (..)
	cd -		-	Change to previous directory (- (minus))
	cd /		-	Changes your current directory to the path you supply
	tree -d 	-	Displays a tree view of the filesystem
	ls –laF		-	List all files also hidden, show symlinks
	file * 		-	Reveal object type
	mv			-	Rename a file or directory
	rm			-	Remove a file 
	rm –rf		-	Forcefully remove a directory
	cat /dev/urandom > test.txt		-	Create a random file with content - https://vaibhavsingh1993.github.io/blog/2017/11/05/random-vs-urandom/

## Alter files

	touch -t 12091600 myfile	-	Edit metadata file creation
	ln file1 file2				-	Create a hard link
	ln -s file1 file3			-	Create a soft lin

## File Ownership

	chown	Used to change user ownership of a file or directory
	chgrp	Used to change group ownership
	chmod	Used to change the permissions on the file, which can be done separately for owner, group and the rest of the world (often named as other)

	chmod uo+x,g-w somefile

## Locate and Find

	locate zip | grep bin
	updatedb	-	Update index for locate command
		- Des de crontab - /etc/crontab - /etc/cron.daily
		- Executa - /etc/cron.daily/locate

	Find
	Type: f - file , l - symlink , d - directory, iname (also ignore the case of file names)
	Options:
		- ctime - last metada change
		- atime - last accessed
		- mtime - last writen
		n = exact time, +n greater, -n less
	#Arxius a /var/log que son mes de 10MB dona mida i mostra permisos per arxiu
	sudo find /var/log/ -size +10M -iname "*journal*" -type f -exec du -sh {} \; -exec ls -alh {} \;
	#Arxius modificats els últims 60min a directori Documents
	sudo find /home/username/Documents -mmin -60

## Packages - RPM - DPKG

	#Install package
	rpm -i foo.rpm	dpkg --install foo.deb

	#Install package, dependencies
	dnf install foo	apt-get install foo

	#Remove package
	rpm -e foo.rpm	dpkg --remove foo.deb

	#Remove package, dependencies
	dnf remove foo	apt-get autoremove foo

	#Update package
	rpm -U foo.rpm	dpkg --install foo.deb

	#Update package, dependencies
	dnf update foo	apt-get install foo

	#Update entire system
	dnf update	apt-get dist-upgrade

	#Show all installed packages
	rpm -qa or dnf list installed	dpkg --list

	#Get information on package
	rpm -qil foo	dpkg --listfiles foo

	#Show packages named foo
	dnf list "foo"	apt-cache search foo

	#Show all available packages
	dnf list	apt-cache dumpavail foo

	#What package is file part of?
	rpm -qf file	dpkg --search file

## Processes

	ps -elfj --forest | less -N
	sudo renice -5 2691
	jobs -l
	top
		Command	Output
			t	Display or hide summary information (rows 2 and 3)
			m	Display or hide memory information (rows 4 and 5)
			A	Sort the process list by top resource consumers
			r	Renice (change the priority of) a specific processes
			k	Kill a specific process
			f	Enter the top configuration screen
			o	Interactively select a new sort order in the process list
	at
	sleep
	crontab

## Disk

	df -hT
	mount 
	lsblk -e7
	blkid

## Comparing files

	diff -c file1 file2
	cmp (diff for binary files)
	#Working with co-workers
	diff3 my-file.yaml ori-file.yaml your-file.yaml
	#Create patch for file
	diff -Nur originalfile newfile > patchfile
	diff -c file1 file2 cmp (diff for binary files)
	#Apply the patch
	patch --dry-run -p1 < patchfile			-	For entire path
	patch --dry-run originalfile patchfile	-	Single file

## Backup and De/compress

	rsync --dry-run -r project-X archive-machine:archives/project-X
	rsync --dry-run --progress -avrxH  --delete sourcedir destdir

View content from compressed file

```
	zcat, zless, zdiff and zgrep
```

	gzip	-	The most frequently used Linux compression utility
		gzip *	Compresses all files in the current directory; each file is compressed and renamed with a .gz extension.
		gzip -r projectX	Compresses all files in the projectX directory, along with all files in all of the directories under projectX.
		gunzip foo	De-compresses foo found in the file foo.gz. Under the hood, the gunzip command is actually the same as gzip –d.

	bzip2	-	Produces files significantly smaller than those produced by gzip - Deprecated

	xz		-	The most space-efficient compression utility used in Linux
		Compress directory to path
			tar cf projects.tar.xz --use-compress-program='xz -6v' /path
		Decompress safe
			xz -dk *.xz ; tar -xf projects.tar
		
		xz *	Compresses all of the files in the current directory and replaces each file with one with a .xz extension.
		xz foo	Compresses foo into foo.xz using the default compression level (-6), and removes foo if compression succeeds.
		xz -dk bar.xz	Decompresses bar.xz into bar and does not remove bar.xz even if decompression is successful.
		xz -dcf a.txt b.txt.xz > abcd.txt	Decompresses a mix of compressed and uncompressed files to standard output, using a single command.
		xz -d *.xz	Decompresses the files compressed using xz

	zip		-	Is often required to examine and decompress archives from other operating systems
		zip backup *	Compresses all files in the current directory and places them in the backup.zip.
		zip -r backup.zip ~	Archives your login directory (~) and all files and directories under it in backup.zip.
		unzip backup.zip	Extracts all files in backup.zip and places them in the current directory.

	tar
		tar zcvf backup.tar.gz ~		-	Full backup
		tar -xf projects.tar			-	extract
		tar xvf mydir.tar				-	Extract all the files in mydir.tar into the mydir directory.
		tar zcvf mydir.tar.gz mydir		-	Create the archive and compress with gzip.
		tar jcvf mydir.tar.bz2 mydir	-	Create the archive and compress with bz2.
		tar Jcvf mydir.tar.xz mydir		-	Create the archive and compress with xz.
		tar xvf mydir.tar.gz			-	Extract all the files in mydir.tar.gz into the mydir directory.
		NOTE: You do not have to tell tar it is in gzip format.

```
	Password protected
	7za a backups_password.7z backups_original.zip -pPasSwOrD
```

## Disk-to-Disk Copying (dd)

	dd if=/dev/sda of=sda.mbr bs=512 count=1 - Backup MBR
	dd if=/dev/sda of=/dev/sdb - Clone disk sda to sdb

## Users

Arxius utils:

	cat /etc/passwd
	cat /etc/shells
	cat /etc/groups
	/etc/sudoers
	/etc/sudoers.d/

Identificar usuaris

	whoami
	who -a 
	w
	id username
	last

First login to linux order files 

	~/.bash_profile
	~/.bash_login
	~/.profile 

New shell

	~/.bashrc
	~/.bash_aliases

Manage users

	#/etc/shells
	sudo useradd -m -s /bin/bash -G sudo test
	sudo userdel test
	sudo userdel -r test (Delete also home folder)

Manage groups

	sudo groupadd groupname
	sudo groupdel groupname

	usermod -a -G groupname username
		-a - evita overwrite de grup
		-g Si es vol modificar gid
		-n Si es vol modificar nom

	usermod -G username username - Per treure de tots els grups

su and sudo

	su - substitute user

Variables entorno

	set, env, or export

	#Show the value of a specific variable	
	echo $SHELL

	#Export a new variable value	
	export VARIABLE=value (or VARIABLE=value; export VARIABLE)

	#Add a variable permanently	
	#Edit ~/.bashrc and add the line
	export VARIABLE=value

	#To apply type source ~/.bashrc or just . ~/.bashrc (dot ~/.bashrc); or just start a new shell by typing bash


## History 

	!75 - Ejecuta comando numero 75 del history


## Manipulating text

	cat - concatenate
	tac - invierte orden de las lineas
	echo
	sed
	awk
	grep

cat

	cat file1 file2 > file
	tac file1 file2 > file

	#Create file
	cat > filename (Ctrl+D to write exit)

	cat << EOF > myfile
	line one
	line two
	line three
	EOF


echo 

	The –e option, along with the following switches, is used to enable special character sequences, such as the newline character or horizontal tab:

	\n represents newline
	\t represents horizontal tab.

	#Create file
	echo line one > myfile
	echo line two >> myfile
	echo line three >> myfile

Compressed files

	Command	Description
	zcat compressed-file.txt.gz	To view a compressed file
	zless somefile.gz
	or
	zmore somefile.gz	To page through a compressed file
	zgrep -i less somefile.gz	To search inside a compressed file
	zdiff file1.txt.gz file2.txt.gz	To compare two compressed files


#### Modify stream input

	.(dot)	Match any single character
	a|z	Match a or z
	$	Match end of a line
	^	Match beginning of a line
	*	Match preceding item 0 or more times

sed

	# -e for multiple sed changes
	# -i make irreversible
	sudo sed -e s/com/local/g /etc/ldap/ldap.conf > test
	echo "I hate you" | sed s/hate/love/ > test

	sed s/pattern/replace_string/ file	Substitute first string occurrence in every line
	sed s/pattern/replace_string/g file	Substitute all string occurrences in every line
	sed 1,3s/pattern/replace_string/g file	Substitute all string occurrences in a range of lines
	sed -i s/pattern/replace_string/g file Save changes for string substitution in the same file

awk

The -F option allows you to specify a particular field separator character. For example, the /etc/passwd file uses ":" to separate the fields, so the -F: option is used with the /etc/passwd file.

	awk '{ print $0 }' /etc/passwd	Print entire file
	awk -F: '{ print $1 }' /etc/passwd	Print first field (column) of every line, separated by a colon
	awk -F: '{ print $1 $7 }' /etc/passwd	Print first and seventh field of every line

sort

	sort <filename>	Sort the lines in the specified file, according to the characters at the beginning of each line
	sort -u Sort checks for unique values after sorting the records (lines) 	
	sort -r <filename>	Sort the lines in reverse order
	cat file1 file2 | sort	Combine the two files, then sort the lines and display the output on the terminal
	sort -k 3 <filename>	Sort the lines by the 3rd field on each line instead of the beginning



uniq

	To remove duplicate entries from multiple files at once, use the following command:
	sort file1 file2 | uniq > file3
	or
	sort -u file1 file2 > file3
	To count the number of duplicate entries, use the following command:
	uniq -c filename

paste

	paste file1 file2 > file3			-	paste content
	paste -d ',' file1 file2 > file3	-	paste with delimiter
	paste -s  file1 file2 > file3		-	paste content vertical

join

	join file1 file2			- 	combine the files without repeating the data of common columns
	
split

	split american-english dictionary

grep

	#Restrict to those that use the tcp protocol.
	grep ftp /etc/services | grep tcp
	#Restrict to those that do not use the tcp protocol, while printing out the line number	
	grep -n ftp /etc/services | grep -v tcp
	#Get all strings that start with ts or end with st.	
	grep -e ^ts -e st$ /etc/services 
	grep [0-9] <filename>	Print the lines that contain the numbers 0 through 9
	grep -C 3 [pattern] <filename>	Print context of lines (specified number of lines above and below the pattern) for matching the pattern. Here, the number of lines is specified as 3

	grep -Eo '[a-z]+.sh$' 1>>




strings

	It is useful in locating human-readable content embedded in binary files
	strings book1.xls | grep my_string


tr

	tr abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ	Convert lower case to upper case
	tr '{}' '()' < inputfile > outputfile	Translate braces into parenthesis
	echo "This is for testing" | tr [:space:] '\t'	Translate white-space to tabs
	echo "This   is   for    testing" | tr -s [:space:]
	Squeeze repetition of characters using -s
	echo "the geek stuff" | tr -d 't'	Delete specified characters using -d option
	echo "my username is 432234" | tr -cd [:digit:]	Complement the sets using -c option
	tr -cd [:print:] < file.txt	Remove all non-printable character from a file
	tr -s '\n' ' ' < file.txt	Join all the lines in a file into a single line

tee

	ls -l | tee newfile

wc

	–l	Displays the number of lines
	-c	Displays the number of bytes
	-w	Displays the number of words

cut

	#Will show the 3rd column
	ls -l | cut -d" " -f3

## Network

Important files

	/etc/resolv.conf
	/etc/hosts
	/etc/hostname
	/etc/network/ - Debian systems
		nmcli - For NetworkManager
		nmtui - For NetworkManager
	/etc/sysconfig/network - RedHat/SUSE

DNS resolution

	host DNS-entry
	nslookup DNS-entry
	dig DNS-entry

Interfaces

	ifconfig - net-tools
	ip

ip 

	ip a	- address
	ip r	- route

route

	With old route command or ip route
	Show current routing table	$ route –n or ip route
	Add static route	$ route add -net address or ip route add
	Delete static route	$ route del -net address or ip route del
	
traceroute

	traceroute hostname

Other tools

	ethtool		-	Queries network interfaces and can also set various parameters such as the speed
	netstat		-	Displays all active connections and routing tables; useful for monitoring performance and troubleshooting
	nmap		-	Scans open ports on a network; important for security analysis
	tcpdump		-	Dumps network traffic for analysis
	iptraf		-	Monitors network traffic in text mode
	iftop		-	Gives a continuously updated display
	dig			-	Tests DNS workings; a good replacement for host and nslookup


Download/Info

	wget
	curl

FTP

	ftp
	sftp

SSH

	ssh
	scp

PDF

	sudo systemctl disable cups
	http://localhost:631

	pdf2ps file.pdf	Converts file.pdf to file.ps
	ps2pdf file.ps	Converts file.ps to file.pdf

	#qpdf
	qpdf --empty --pages 1.pdf 2.pdf -- 12.pdf	Merge the two documents 1.pdf and 2.pdf. The output will be saved to 12.pdf.
	qpdf --empty --pages 1.pdf 1-2 -- new.pdf	Write only pages 1 and 2 of 1.pdf. The output will be saved to new.pdf.
	Rotate page 1 of 1.pdf 90 degrees clockwise and save to 1r.pdf.
	qpdf --rotate=+90:1 1.pdf 1r.pdf
	Rotate all pages of 1.pdf 90 degrees clockwise and save to 1r-all.pdf
	qpdf --rotate=+90:1-z 1.pdf 1r-all.pdf
	qpdf --encrypt mypw mypw 128 -- public.pdf private.pdf	Encrypt with 128 bits public.pdf using as the passwd mypw with output as private.pdf.
	qpdf --decrypt --password=mypw private.pdf file-decrypted.pdf	Decrypt private.pdf with output as file-decrypted.pdf.


	#Other tools
	pdfinfo 
	It can extract information about PDF files, especially when the files are
	very large or when a graphical interface is not available.
	flpsed 
	It can add data to a PostScript document. This tool is specifically useful
	for filling in forms or adding short comments into the document.
	pdfmod 
	It is a simple application that provides a graphical interface for modifying
	PDF documents. Using this tool, you can reorder, rotate, and remove pages;
	export images from a document; edit the title, subject, and author;
	add keywords; and combine documents using drag-and-drop action.



## Security tips

	su - change to super user
	sudo - execute commands with granted permissions
	/var/log/secure or /var/log/messages - RedHat/SUSE
	/var/log/auth - Debian

	#sudo statement
	who where = (as_whom) what

	#Edit sudoerrs with
	# visudo /etc/sudoers
	# visudo -f /etc/sudoers.d/student

	To encode:
	echo -n test | sha512sum

	chage - to set expiration passwd and others

















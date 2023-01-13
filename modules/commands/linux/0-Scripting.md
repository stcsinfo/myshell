# Cheat sheet
## Scripting

Return values

Environment variable to check status 

    $?
        0 - executed succed
        2 - error

    ls /etc/logrotate.conf
    echo $?

Multiple commands

Thus, the three commands in the following example will all execute, even if the ones preceding them fail:

    $ make ; make install ; make clean

If the first command fails, the second one will never be executed. A final refinement is to use the || (or) operator, as in:

    $ make && make install && make clean

In this case, you proceed until something succeeds and then you stop executing any further steps.

    $ cat file1 || cat file2 || cat file3


Redirections


    >   -   output over/write file
    >>  -   Append to file
    wc < /etc/passwd    -   Read input


Parameters

    $0	Script name
    $1	First parameter
    $2, $3, etc.	Second, third parameter, etc.
    $*	All parameters
    $#	Number of arguments

Command substitution

    By enclosing the inner command in $( ) - sum=$(( "$sum"+"$i" ))
    By enclosing the inner command with backticks (`)
    Ex: ls /lib/modules/$(uname -r)/

Environment variables

    env
    set
    printenv

Export variables

    export  -   show exported variables
    export VAR=value
    or
    VAR=value ; export VAR

Functions

    function_name () {
    	sum=$(( "$sum"+"$i" ))
    }

If statement

Full list of file conditions: man 1 test

    if [[ -f $1 ]]
    then
        statements
    else
        statements
    fi

elif statement

    if [[ sometest ]] ; then
        echo Passed test1 
    elif [[ somothertest ]] ; then
        echo Passed test2
    elif [[ somothertest ]] ; then
        echo Passed test3
    else
        statement
    fi


Boolean expressions

    &&	AND	The action will be performed only if both the conditions evaluate to true.
    ||	OR	The action will be performed if any one of the conditions evaluate to true.
    !	NOT	The action will be performed only if the condition evaluates to false. 

Note that if you have multiple conditions strung together with the && operator, processing stops as soon as a condition evaluates to false. For example, if you have A && B && C and A is true but B is false, C will never be executed.

Likewise, if you are using the || operator, processing stops as soon as anything is true. For example, if you have A || B || C and A is false and B is true, you will also never execute C.



Test Boolean expressions

    -eq	Equal to
    -ne	Not equal to
    -gt	Greater than
    -lt	Less than
    -ge	Greater than or equal to
    -le	Less than or equal to



Test Strings

    ==  -   compare

Arithmetic Expressions

    echo $((x+1))


## String Manipulation 

	[[ string1 > string2 ]]	Compares the sorting order of string1 and string2.
	[[ string1 == string2 ]]	Compares the characters in string1 with the characters in string2.
	myLen1=${#string1}	Saves the length of string1 in the variable myLen1.

	# Selecciona n caracteres del string
	variable=${string:0:n}
	# Todos los caracteres despues del primer punto
	variable=${string#*.}


## Case statement 

	case "$expression" in
	   "yes") execute commands;;
	   "no") execute commands;;
	   "y" | "Y" | "YES" ) execute commands;;
	   "n" | N" | "NO" ) execute commands;;
	   * )       execute some default commands or nothing ;;
	esac




## Looping constructs

```
for variable-name in list
do
    execute one iteration for each item in the list until the list is finished
done
```
```
while [ condition is true ]
do
    Commands for execution
done
```
```
until [ condition is false ]
do
    Commands for execution
    ----
done
``


## Debug

	# All script
	bash –x ./script_file

	# Part of code
	set -x    # turns on debugging
	...
	set +x    # turns off debugging



## Creating Temporary Files and Directories


	TEMP=$(mktemp /tmp/tempfile.XXXXXXXX)	To create a temporary file
	TEMPDIR=$(mktemp -d /tmp/tempdir.XXXXXXXX)	To create a temporary directory


## Discarting output


	$ ls -lR /tmp > /dev/null

	In the above command, the entire standard output stream is ignored, but any errors will still appear on the console. However, if one does:

	$ ls -lR /tmp >& /dev/null

	both stdout and stderr will be dumped into /dev/null.


## Random numbers/data

	$RANDOM
	/dev/random - very high quality randomness is required, slow
	/dev/urandom - faster and suitable (good enough) for most cryptographic purposes


























































































































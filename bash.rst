==============
Bash scripting
==============

Linux脚本中的shebang (#!)
=========================

在 Linux 中，shebang(#!) 是脚本开始时的一个特殊行，它告诉操作系统在执行脚本时要使用哪个解释器。

Shebang 行有几个优点，比如允许用户把脚本和文件当作命令，隐藏执行细节，允许使用某个特定版本的解释器。

"#!/bin/false" 指令是一个特殊的shebang指令，它立即退出并返回一个错误的状态，防止某些系统文件在其适当的上下文之外运行。

Run the Last Command as Root
============================

.. code-block:: bash

    sudo !!

    su -c "!!"

Clear Your Shell History
========================

.. code-block:: bash

    history -c

Use Vim to Edit Files over the Network
======================================

.. code-block:: bash

    vim scp://remote-user@remote-host//parth/to/file

Append Text to a File Using Sudo
================================

.. code-block:: bash

    echo text | sudo tee -a file

Change the Case of a String
===========================

.. code-block:: bash

    tr [:upper:] [:lower:]

    tr [:lower:] [:upper:]


Display Your Command Search Path in a Human Readable Format
===========================================================

.. code-block:: bash

    echo $PATH | tr ':' '\n'

Serve File in the Current Directory via a Web Interface
=======================================================

.. code-block:: bash

    python3 -m http.server

Save a file you edited in vim without the needed permissions
============================================================

.. code-block:: bash

    :w !sudo tee %

Delete all empty lines from a file with vim
===========================================

.. code-block:: bash

    :g/^$/d

Find all active IP addresses in a network
=========================================

.. code-block:: bash

    nmap -sP 192.168.0.*

Copy stdin to your X11 buffer
=============================

.. code-block:: bash

    ssh user@host cat /path/to/some/file | xclip

Download an entire static website to your local machine
=======================================================

.. code-block:: bash

    wget --recursive --page-requisites --convert-links www.moyagraphix.coza


Change to the previous working directory
========================================

.. code-block:: bash

    cd -

mtr - better than traceoute and ping combined
=============================================

.. code-block:: bash

    mtr google.com

Start a tunnel from some machine's port 80 to your local port 2001
==================================================================

.. code-block:: bash

    ssh -N -L2001:localhost:80 somemachine

Quick access to the ascii table
===============================

.. code-block:: bash

    man ascii

Make directory tree
===================

.. code-block:: bash

    mkdir -p work/{d1,d2}/{src,bin,bak}

Press Any Key to Continue
=========================

.. code-block:: bash

    read -sn 1 -p "Press any key to continue..."

Delete all files in a folder that don't match a certain file extension
======================================================================

.. code-block:: bash

    rm !(*.foo|*.bar|*.baz)

Compare two directory trees
===========================

.. code-block:: bash

    diff <(cd dir1 && find | sort) <(cd dir2 && find | sort)

Search recursively to find a word or phrase in certain file types, such as C code
=================================================================================

.. code-block:: bash

    find . -name "*.[ch]" -exec grep -i -H "search pharse" {} \;

Instead of writting a multiline if/the/else/fi sonstruct you can do that by one line
====================================================================================

.. code-block:: bash

    [[ test_condition ]] && if_true_do_this || otherwise_do_that

Copy your ssh public key to a server from a machine that doesn't have ssh-copy-id
=================================================================================

.. code-block:: bash

    cat ~/.ssh/id_rsa.pub | ssh user@machine "mkdir ~/.ssh; cat >> ~/.ssh/authorized_keys"

Recursively change permissions on files, leave directories alnoe
================================================================

.. code-block:: bash

    find . -type f -exec chmod 644 {} \;

How to establish a remote Gne screen session that you can re-connect to
=======================================================================

.. code-block:: bash

    ssh -t user@some.domain.com /usr/bin/screen -xRR

Execute a command with a timeout
================================

.. code-block:: bash

    timeout 10 sleep 11

Replace spaces in filenames with underscores
============================================

.. code-block:: bash

    rename 'y/ /_/' *

Save an HTML page and covert it to a .pdf file
==============================================

.. code-block:: bash

    wget $URL | htmldoc --webpage -f "$USRL".pdf - ; xpdf "$URL".pdf &

Create a Text File from the Command Line without Using an Editor
================================================================

.. code-block:: bash

    cat > file
    ...
    <ctrl-d>

Get Your Public IP from the Command Line Using Curl
===================================================

.. code-block:: bash

    curl ifconfig.me

    curl ifconfig.me/ip

    curl ifconfig.me/host


SSH into a Remote System without a Password
===========================================

.. code-block:: bash

    ssh-keygen
    ssh-copy-id remote-host
    ssh remote-host

Compare the Differences between a Remote and Local file
=======================================================

.. code-block:: bash

    ssh remote-host cat /path/to/remotefile | diff /path/to/localfile -

Find out Which Programs Are Listening on Which Ports
====================================================

.. code-block:: bash

    sudo netstat -nutlp

Automatically Answer Yes to Any Comamnd
=======================================

.. code-block:: bash

    yes | command

    yes "string" | command


Quickly Make a Backup of a file
===============================

.. code-block:: bash

    cp file{,.bak}

Empty a File That Is Being Written To
=====================================

.. code-block:: bash

    > file

    cat /dev/null > file

Delete Empty Directories
========================

.. code-block:: bash

    find . type d -empty -delete

Extract the Nth Line from a File
================================

.. code-block:: bash

    $ ./deploy.sh
    ./deploy.sh: line 74: /usr/local/bin/patch: No such file or directory

    $ awk 'NR==74' deploy.sh
    /usr/local/bin/patch $NEW_HOST




Introduction
============

This is a quick reference to getting started with Bash scripting.

#. Learn bash in y minutes: https://learnxinyminutes.com/docs/bash
#. Bash Guide: http://mywiki.wooledge.org/BashGuide

Example
=======

.. code-block:: bash

   #!/bin/bash
   name="John"
   echo "Hello $name!"

Variables
=========

.. code-block:: bash

   name="John"
   echo $name   # see bellow
   echo "$name"
   echo "${name}!"

Generally quote your variables unless they contain wildcards to expand or command fragments.

.. code-block:: bash

   wildcard="*.txt"
   options="iv"
   cp -$options $wildcard /tmp

String quotes
=============

.. code-block:: bash

   name="John"
   echo "Hi $name"  #=> Hi John
   echo 'Hi $name'  #=> Hi $name

Shell execution
===============

.. code-block:: bash

    echo "I'm in $(pwd)"
    echo "I'm in `pwd`"     # obsolescent -- 逐渐被废弃的，逐渐过时的

Conditional execution
=====================

.. code-block:: bash

    git commit && git push
    git commit || echo "Commit failed"

Function
========

.. code-block:: bash

    get_name() {
        echo "John"
    }

    echo "You are $(get_name)"

Conditionals
============

.. code-block:: bash

    if [[ -z "$String" ]]; then
        echo "String is empty"
    elif [[ -n "$String" ]]; then
        echo "String is not empty"
    fi

Strict mode
===========

.. code-block:: bash

    set -euo pipefail

Brace expansion
===============

.. code-block:: bash

    echo {A,B}.js

+------------+---------------------+
| Expression | Description         |
+============+=====================+
| `{A,B}`    | Same as `A B`       |
+------------+---------------------+
| `{A,B}.js` | Same as `A.js B.js` |
+------------+---------------------+
| `{1..5}`   | Same as `1 2 3 4 5` |
+------------+---------------------+

Parameter expansions
====================

.. code-block:: bash

    name="John"
    echo "${name}"
    echo "${name/J/j}"      #=> "john"  (substitution -- 替换)
    ehco "${name:0:2}"      #=> "Jo"    (slicing -- 切片)
    ehco "${name::2}"       #=> "Jo"    (slicing)
    echo "${name::-1}"      #=> "Joh"   (slicing)
    echo "${name:(-1)}"     #=> "n"     (slicing from right)
    echo "${name:(-2):1}"   #=> "h"     (slicing from right)
    echo "${food:-Cake}"    #=> $food or "Cake"

    length=2
    echo "${name:0:length}" #=> "Jo"

.. code-block:: bash

    str="/path/to/foo.cpp"

    echo "${str%.cpp}"      #=> /path/to/foo
    echo "${str%.cpp}.o"    #=> /path/to/foo.o
    echo "${str%/*}"        #=> /path/to

    echo "${str##*.}"       #=> cpp         (extension)
    echo "${str##*/}"       #=> foo.cpp     (basepath)
    echo "${str#*/}"        #=> path/to/foo.cpp

    echo "${str/foo/bar}"   #=> /path/to/bar.cpp

    base=${str##*/}         #=> foo.cpp     (basepath)
    dir=${str%base}         #=> /path/to/   (dirpath)

.. code-block:: bash

    str="Hello world"
    echo "${str:6:5}"       # "world"
    echo "${str: -5:5}"     # "world"
    echo "${str:(-5):5}"    # "world"

Substitution
============

+-------------------+---------------------+
| Code              | Description         |
+===================+=====================+
| `${foo%suffix}`   | Remove suffix       |
| `${foo#prefix}`   | Remove prefix       |
+-------------------+---------------------+
| `${foo%%suffix}`  | Remove long suffix  |
| `${foo/%suffix}`  | Remove long suffix  |
+-------------------+---------------------+
| `${foo##prefix}`  | Remove long prefix  |
| `${foo/#prefix}`  | Remove long prefix  |
+-------------------+---------------------+
| `${foo/from/to}`  | Replace first match |
| `${foo//from/to}` | Replace all         |
+-------------------+---------------------+
| `${foo/%from/to}` | Replace suffix      |
| `${foo/#from/to}` | Replace prefix      |
+-------------------+---------------------+

Comments
========

.. code-block:: bash

    # Single line comment

    : '
    This is a
    multi line
    comment
    '

Substrings
==========

+-----------------+--------------------------------+
| Expression      | Description                    |
+=================+================================+
| `${foo:0:3}`    | Substring _(position, length)_ |
+-----------------+--------------------------------+
| `${foo:(-3):3}` | Substring from the right       |
+-----------------+--------------------------------+

Length
======

+------------+------------------+
| Expression | Description      |
+============+==================+
| `${#foo}`  | Length of `$foo` |
+------------+------------------+

Manipulation
============

.. code-block:: bash

    str="HELLO WORLD!"
    echo "${str,}"          #=> "hELLO WORLD!"      (lowercase 1st letter)
    echo "${str,,}"         #=> "hello world!"      (all lowercase)

    str="hello world!"
    echo "${str^}"          #=> "Hello world!"      (uppercase 1st letter)
    echo "${str^^}"         #=> "HELLO WORLD!"      (all uppercase)


Default values
==============

+-------------------+----------------------------------------------------------+
| Expression        | Description                                              |
+===================+==========================================================+
| `${foo:-val}`     | `$foo`, or `val` if unset (or null)                      |
+-------------------+----------------------------------------------------------+
| `${foo:=val}`     | Set `$foo` to `val` if unset (or null)                   |
+-------------------+----------------------------------------------------------+
| `${foo:+val}`     | `val` if `$foo` is set (and not null)                    |
+-------------------+----------------------------------------------------------+
| `${foo:?message}` | Show error message and exit if `$foo` is unset (or null) |
+-------------------+----------------------------------------------------------+


Loops
=====

.. code-block:: bash

    # Basic for loop
    for i in /etc/rc.*; do
        echo "$i"
    done

    # C-like for loop
    for (( i = 0 ; i < 100 ; i++)); do
        echo "$i"
    done

    # Ranges
    for i in {1..5}; do
        echo "Welcome $i"
    done

    # With step size
    for i in {5..50..5}; do
        echo "Welcome $i"
    done

    # Readding lines
    while read -r line; do
        echo "$line"
    done <file.txt

    # Forever
    while true; do
        ...
    done

Functions
=========

.. code-block:: bash

    # Defining functions
    myfunc() {
        echo "Hello $1"
    }

    # Same as above (alternate syntax)
    function myfunc() {
        echo "Hello $1"
    }

    myfunc "John"

    # Returning values
    myfunc() {
        local myresult='some value'
        echo "$myresult"
    }

    result=$(myfunc)

    # Raising errors
    myfunc() {
        return 1
    }

    if myfunc; then
        echo "success"
    else
        echo "failure"
    fi

Arguments
=========

+------------+------------------------------------------------+
| Expression | Description                                    |
+============+================================================+
| `$#`       | Number of arguments                            |
+------------+------------------------------------------------+
| `$*`       | All positional arguments (as a single word)    |
+------------+------------------------------------------------+
| `$@`       | All positional arguments (as separate strings) |
+------------+------------------------------------------------+
| `$1`       | First argument                                 |
+------------+------------------------------------------------+
| `$_`       | Last argument of the previous command          |
+------------+------------------------------------------------+

.. note::
    `$@` and `$*` must be quoted in order to perform as described. Otherwise, they do exactly the same thing (arguments as separate string).

Conditionals
============

Note that `[[` is actually a command/program that returns either `0` (true) or `1` (false). Any program that obeys the same logic (like all base utils, such as `grep(1)` or `ping(1)`) can be used as condition, see examples.

+--------------------------+-------------------------------+
| Condition                | Description                   |
+--------------------------+-------------------------------+
| `[[ -z STRING ]]`        | Empty string                  |
+--------------------------+-------------------------------+
| `[[ -n STRING ]]`        | Not empty string              |
+--------------------------+-------------------------------+
| `[[ STRING == STRING ]]` | Equal                         |
+--------------------------+-------------------------------+
| `[[ STRING != STRING ]]` | Not equal                     |
+--------------------------+-------------------------------+
| `[[ NUM -eq NUM ]]`      | Equal                         |
+--------------------------+-------------------------------+
| `[[ NUM -ne NUM ]]`      | Not equal                     |
+--------------------------+-------------------------------+
| `[[ NUM -lt NUM ]]`      | Less than                     |
+--------------------------+-------------------------------+
| `[[ NUM -le NUM ]]`      | Less than or equal            |
+--------------------------+-------------------------------+
| `[[ NUM -gt NUM ]]`      | Greater than                  |
+--------------------------+-------------------------------+
| `[[ NUM -ge NUM ]]`      | Greater than or equal         |
+--------------------------+-------------------------------+
| `[[ STRING =~ STRING ]]` | Regexp                        |
+--------------------------+-------------------------------+
| `(( NUM < NUM ))`        | Numeric conditions            |
+--------------------------+-------------------------------+

+----------------------+--------------------------+
| Condition            | Description              |
+----------------------+--------------------------+
| `[[ -o noclobber ]]` | If OPTIONNAME is enabled |
+----------------------+--------------------------+
| `[[ ! EXPR ]]`       | Not                      |
+----------------------+--------------------------+
| `[[ X && Y ]]`       | And                      |
+----------------------+--------------------------+
| `[[ X || Y ]]`       | Or                       |
+----------------------+--------------------------+

+-------------------------+--------------------------+
| Condition               | Description              |
+-------------------------+--------------------------+
| `[[ -e FILE ]]`         | Exists                   |
+-------------------------+--------------------------+
| `[[ -r FILE ]]`         | Readable                 |
+-------------------------+--------------------------+
| `[[ -h FILE ]]`         | Symlink                  |
+-------------------------+--------------------------+
| `[[ -d FILE ]]`         | Directory                |
+-------------------------+--------------------------+
| `[[ -w FILE ]]`         | Writeable                |
+-------------------------+--------------------------+
| `[[ -s FILE ]]`         | Size is > 0 bytes        |
+-------------------------+--------------------------+
| `[[ -f FILE ]]`         | File                     |
+-------------------------+--------------------------+
| `[[ FILE1 -nt FILE2 ]]` | 1 is more recent than 2  |
+-------------------------+--------------------------+
| `[[ FILE1 -ot FILE2 ]]` | 2 is more recent than 1  |
+-------------------------+--------------------------+
| `[[ FILE1 -ef FILE2 ]]` | Smage files              |
+-------------------------+--------------------------+











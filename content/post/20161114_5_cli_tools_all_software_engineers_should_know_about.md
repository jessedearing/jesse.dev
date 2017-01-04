+++
date = "2016-11-14T22:07:24-08:00"
title = "5 CLI Tools all software engineers should know about"
description = ""
tags = ["Command line", "Operating Systems", "System Administration", "Software Development"]
+++

The following CLI tools, I have found to be extremely useful when dealing with
systems to quickly find the information I need. Please note that all these
commands are being run from OS X and are the BSD commands not the GNU commands
that typically ship with a standard Linux distro.

## 5. xargs
xargs simply takes strings separated by whitespace and passes those into the
command specified. A simple example would be:

```
ls | xargs -n 2 echo
```
By default the command is echo, but for the sake of demonstration let's add it
explicitly. The -n 2 will only pass 2 of the inputs at a time as arguments.
Let’s say you have the files a.txt, b.txt, c.txt, d.txt, e.txt and f.txt in the
directory where you run this. The output will look like:

```
a.txt b.txt
c.txt d.txt
e.txt f.txt
```

This is because xargs is effectively running:

```
echo a.txt b.txt
echo c.txt d.txt
echo e.txt f.txt
```

You can also control where xargs substitutes the input in the command line by
using the -I argument.

For example, you can append .bak to all of your files by the following command
line:

```
ls | xargs -I % -- mv % %.bak
```

## 4. find
find simply lists files. The benefit that you get over ls is that it can
traverse whole directory trees and you can find specific files. It can be used
to find specific file extensions, files larger than a specific size, files
created or modified after a certain date, or files of a particular type
(directories, regular files, symbolic links, etc.).

For example, I'm going to find all the files ending in `_test.go` which
indicates a test file in Go.

```
find . -name '*_test.go'
```

This can be piped into into other commands or find has both and `-exec` argument
where you can tell find to run a command with the filename interpolated or
`-delete` to delete files.

## 3. head/tail
head and tail will display lines from the beginning and end of files
(respectively).

head is a bit more simple than tail. It just displays the number of lines you
specify starting from the top of a file. Since files all have a start determined
at file creation that doesn't change until the file points to a different place
on disk when the file is re-created. head is useful when you have a large file,
but you just need to view the first portion of the file.

tail will display the last lines of a file. When tail is used with the -f
argument, it reads the last few lines and waits for more lines to be appended to
the file. tail is tremendously helpful when viewing logs as most of the time you
don't care about the top of the log file, you just care about the last few
seconds, minutes, or hours.

## 2. jq
jq is one of the newest tools that is finding it's way to standard installs
everywhere. jq will parse JSON and let you query it using expressions. As
JSON-based APIs become more prominent in services, jq will let you query
specific values without having to write code in Python, Ruby, or Perl to parse a
single JSON field.

jq is not installed on OS X (and most Linux distros) by default and will require
being installed via Homebrew.

Here's a runnable example using jq against the Github API:

```
curl 'https://api.github.com/repos/stedolan/jq/commits?per_page=5' | jq '.[].commit.message'
```

This will list the last 5 commit messages of the https://github.com/stedolan/jq repo.

## 1. awk
awk is a Turing-complete interpreter and is capable of a lot, but at the very
least awk can be used to find positional text and print it out. Here is a common
one-liner I personally use when interacting with Docker. The following example
will remove all exited containers.

```
docker ps -a | grep Exited | awk '{ print $1; }' | xargs -n 1 docker rm
```

Or you can remove the grep and use awk's regular expressions:

```
docker ps -a | awk '/Exited/ { print $1; }' | xargs -n 1 docker rm
```

## 0. man
There's a lot of ways to make your time on the command line easier but you'll
need to read up on how. Since man is always there you'll always have
documentation right at your fingertips.

```
man xargs
man find
man tail
man head
man jq
man awk
# and even...
man man
```

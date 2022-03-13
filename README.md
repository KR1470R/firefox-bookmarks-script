# firefox-bookmarks-script

## Overview

this project was made to make life easier in solving Mozilla Firefox problems. Mozilla doesn't restore previous session,
so you can lose all your value bookmarks. You can manage your bookmarks the way you want using **bookmrk** tool.

Let's create three groups: ***zno-study***, ***prog-study*** and ***entertainment***, so you can store your bookmarks
as ***zno-study*** — for school bookmarks, ***prog-study*** — for programming bookmarks and ***entertainment*** — for
your films and other stuff. Of course, if you need only one of these groups, for example, ***entertainment*** you may
use only one group, ***other groups*** gonna be ignored if they are empty. It means that each of the group in the
bookmarks is a separate Firefox window with your saved bookmarks!

## Content

1. [Requirements][1]
2. [Instruction][2]
    1) [Installation][2.1]
    2) [Usage][2.2]
    3) [Supported OS][2.3]
    4) [Uninstall][2.4]
    5) [TODO][2.5]
3. [License][3]

## Requirements

All what you need is **Mozilla Firefox Browser** and **zsh** (maybe **bash** fits and works fine, but i haven't
tested [it won't work, i've tested]).

## Instruction

### Installation

Clone repository

```shell
git clone https://github.com/KR1470R/firefox-bookmarks-script.git && \ 
cd firefox-bookmarks-script
```

Install tool via `setup.sh`

```shell
./setup.sh -i
```

**Step 1:**

> *Do you want to install startup launcher of your saved bookmarks to your firefox?[Y/n]*

This step will install script that will be run auto launch bookmarks at startup system.(Must have)

**Step 2:**

> *Do you want to install bookmarks manager?[Y/n]*

On this step installation script will setup environment for itself. Everything should work fine.

### Usage

_Bookmrks_ help page:

```shell
bookmrk -h
```

    Usage: bookmrk -h | --license or [type bookmark] -a | -r | -c | -l [bookmark]
         -h help                       Show this text
         --license                     Show license page
         type bookmark                 One of the group of bookmarks(i.e prog, ent or zno) 
         -a add bookmark               Add bookmark to the group
         -r remove specific bookmakr   Remove bookmark by specific url from argument
         -c clear all bookmarks        Remove all bookmarks from the list of group
         -l remove last bookmark       Remove last bookmark from the list of group
         bookmark                      URL for some site(i.e www.example.com)

For instance, you could add some bookmarks to the **prog-study group** which will be executed at every system startup:

```shell
bookmrk prog -a www.example.com 
```

You can do it with every group of bookmark.

Here is the table of bookmarks types that we we have put to the command:

| Parameter type name | Bookmark type fullname |
|---------------------|------------------------|
| prog                | prog-study             |
| zno                 | zno-study              |
| ent                 | entertainment          |

And what about removing bookmarks from a specific group? You can remove specific bookmark from specific group (for
example, `prog-study`):

```shell
bookmrk prog -r www.example.com
```   

You can also remove only the most recent bookmark from a specific group:

```shell
bookmrk prog -l
```

Or you can also remove the entire list of bookmarks from the group you need:

```shell
bookmrk prog -c
```

That all is okay, but what if you wanna list bookmarks for the specific group?

```shell
bookmrk prog -L 
```

### Supported OS

1. Linux (Arch/Debian/Fedora/etc.)
2. ~~Windows~~
3. ~~OS X~~

Unsupported systems maybe turn to supported soon...

### Uninstall

To uninstall **bookmrk** and **startup script**, you must go back to our repository with **setup.sh** and type:

```shell
./setup.sh -u
```

All files, including config files, will be removed.

### TODO

1. ~~Reformat files according to the styleguide~~
2. ~~Reformat `README.md`~~
3. Refactor files adhering to the rules of the POSIX standard

## License

MIT License

Copyright (c) 2022 KR1470R

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit
persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[1]:https://github.com/KR1470R/firefox-bookmarks-script#requirements

[2]:https://github.com/KR1470R/firefox-bookmarks-script#instruction

[2.1]:https://github.com/KR1470R/firefox-bookmarks-script#installation

[2.2]:https://github.com/KR1470R/firefox-bookmarks-script#usage

[2.3]:https://github.com/KR1470R/firefox-bookmarks-script#supported-os

[2.4]:https://github.com/KR1470R/firefox-bookmarks-script#uninstall

[2.5]:https://github.com/KR1470R/firefox-bookmarks-script#todo

[3]:https://github.com/KR1470R/firefox-bookmarks-script#license

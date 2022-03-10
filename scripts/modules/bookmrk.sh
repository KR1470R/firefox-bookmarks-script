#!/bin/bash
#
#
#                   _________-----_____
#        _____------           __      ----_
# ___----             ___------              \
#    ----________        ----                 \
#  ______________-----__    |             _____)
#   ---------------------                /    \
#  -----  _______-----    ___--          \  O /)\
#   ------_______      ---____            \__/  /
#          _______-----__    \ --    _          /\
#                       --__--__     \_____/   \_/\
#                               ----|   /          |
#                                   |  |___________|
#                                   |  | ((_(_)| )_)
#                                   |  \_((_(_)|/(_)
#                                   \             (
#                                    \_____________)
#                                    
#                    Made by KR1470R
#                    
#                        

# global variable to state type of bookmark.
declare type
# global variable to state relative path to *.bookmarks file.
declare path_to_bookmarks

### Define type of bookmark and save it to global var $type.
# AND
### Define path to bookmark and save it to global var $path_to_bookmarks
function define_bookmark_metadata() {
	if [[ $1 == 'ent' ]]
	then
		type="entertainment"
	elif [[ $1 == 'prog' ]] 
	then
		type="prog-study"
	elif [[ $1 == 'zno' ]]
	then
		type="zno-study"
	else
		echo "Uknown bookmark type!"
		exit 1
	fi
	echo "Defined $type"
	path_to_bookmarks=$(readlink -f ~)"/.config/firefox-bookmarks/bookmarks/"${type}".bookmarks"
}

### Check either list of bookmarks empty or not
function check_empty() {
	if [[ $(cat "$path_to_bookmarks" | wc -c) -lt 3 ]]; then
		return 0
	else
		return 1
	fi
}

### Add bookmark
# $1 - bookmark - link for a site 
###
function add_bookmark(){
	while read -r line; do
		if [[ "$line" == "$1" ]]; then
			echo "$1 has already added to $type group."
			exit 1
		fi
	done < $path_to_bookmarks
	bash -c "echo -e $'$1\n' >> $path_to_bookmarks; mac2unix -q $path_to_bookmarks"
	echo "Added bookmark $1 into the $type.bookmarks."
	exit 0
}

### Remove all bookmarks
function clear_bookmarks(){
	if check_empty; then
		echo "List of the $type is alredy empty"
	else 
		bash -c "echo '' > $path_to_bookmarks"
		mac2unix -q $path_to_bookmarks
		echo "$path_to_bookmarks has been clearned."
		exit 0
	fi
}

### Remove last element from bookmarks list
function remove_last_bookmark() {
	if check_empty; then
		echo "List of the $type is alredy empty"
		exit 1
	else 
		local last_bookmark=$(tail -n 2 "$path_to_bookmarks")
		bash -c "tail -n 2 "$path_to_bookmarks" | wc -c | xargs -I {} truncate $path_to_bookmarks -s -{}"
		mac2unix -q $path_to_bookmarks
		echo -ne "Removed last bookmark from ${type}: $last_bookmark\n\n"
		exit 0
	fi
}

### Remove specify bookmark from list
# $1 - bookmark
###
function remove_specific_bookmark() {
	if check_empty; then
		echo "List of the $type is alredy empty"
		exit 1
	else
		local is_found=$(grep -oG $(printf $1) $path_to_bookmarks)
		if [[ ! -z $is_found  ]]
		then
			local temp_data=$(grep -vG $(printf $1) $path_to_bookmarks)
			local temp_data2
			IFS=$'\n'
			for line in $temp_data; do
				temp_data2+=$line"\n\n"
			done
			bash -c "echo -e $temp_data2 | sed '$ d' > $path_to_bookmarks; mac2unix -q $path_to_bookmarks"
			echo "Removed $1 from $type"
			exit 0
		else 
			echo "$1 not found in $type."
			exit 1
		fi
	fi
}

### Show all bookmarks from specific group
function list_bookmarks() {
	if check_empty; then
		echo "List of the $type is empty"
	else
		cat "$path_to_bookmarks"
	fi
}
 
### Show help page
function help() {
	echo "Usage: bookmrk -h | --license or [type bookmark] -a | -r | -c | -l [bookmark]"
	echo '     -h help                       Show this text'
	echo '     --license                     Show license page'
	echo '     type bookmark                 One of the group of bookmarks(i.e prog, ent or zno) '
	echo '     -a add bookmark               Add bookmark to the group'
	echo '     -r remove specific bookmakr   Remove bookmark by specific url from argument'
	echo '     -c clear all bookmarks        Remove all bookmarks from the list of group'
	echo '     -l remove last bookmark       Remove last bookmark from the list of group'
	echo '     bookmark                      URL for some site(i.e www.example.com)'
	return 0
}

function show_license() {
	cat << LICENSE
MIT License

Copyright (c) $(date +"%Y") KR1470R

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
LICENSE
	return 0
}


##################### Main #######################

if [[ $# -eq 0 ]]
then
	echo "No options found!"
	help
	exit 1
fi
if [[ $1 == "-h" ]]; then 
	help
	exit 0
elif [[ $1 == "--license" ]]; then
	show_license
	exit 0
fi
define_bookmark_metadata $1
shift
options="a:r:chlL"
while getopts $options opt; do
	case $opt in
		a) add_bookmark $OPTARG;;
		r) remove_specific_bookmark $OPTARG;;
		c) clear_bookmarks;;
		l) remove_last_bookmark;;
		h) help;;
		L) list_bookmarks;;
		*) 
			echo "Uknown option $OPTARG"
			help
			exit 1
		;;
	esac
done

##################################################

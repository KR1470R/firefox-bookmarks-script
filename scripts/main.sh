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

declare -A file_sequence=(
	["zno_study_bookmarks"]="zno-study" 
	["prog_study_bookmarks"]="prog-study"
	["entertainment_bookmarks"]="entertainment"
)
declare root_folder=~/.config/firefox-bookmarks

links=()

echo "Starting..."

for varname in "${!file_sequence[@]}"
do
	path_to_bookmarks=$root_folder/bookmarks/${file_sequence[$varname]}.bookmarks
	path_to_logs=$root_folder/logs/${file_sequence[$varname]}.logs
	if [[ $(cat "$path_to_bookmarks" | wc -c) -lt 3 ]]; then
		echo ">>> ${file_sequence[$varname]} is empty. Passing..."
		continue
	fi
	echo "Getting from $path_to_bookmarks..."
	while read -r line; do
		links+=$line" "
		echo $line
	done < $path_to_bookmarks
	echo "Running firefox with ${file_sequence[$varname]} bookmarks..."
	nohup firefox $(for link in "${links[@]}"; do echo $link; done) > $path_to_logs 2> $path_to_logs
	links=()
done

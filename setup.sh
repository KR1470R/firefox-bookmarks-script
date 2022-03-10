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

declare root_folder=~/.config/firefox-bookmarks

declare shell_rc="$(readlink -f ~)/.$(sed -E -e 's/\/bin\/|\/usr\/bin\///g' <<< $SHELL)""rc"

function install() {
	echo "Started installation..."
	if [ ! -d "${root_folder}" ]; then 
		echo "firefox-bookmarks not found, trying to create it..." 
		mkdir -p $root_folder
		mkdir "$root_folder/bookmarks"
		touch "$root_folder/bookmarks/"{entertainment,prog-study,zno-study}".bookmarks"
		mkdir "$root_folder/logs"
	fi 

	printf "Do you want to install startup launcher of your saved bookmarks to your firefox?[Y/n]: "
	read -r install_startup_launcher
	if [[ $install_startup_launcher =~ [yY](es)* ]]; then
		sudo cp ./scripts/main.sh /usr/bin/autostart-firefox-bookmarks.sh
		sudo chmod +x /usr/bin/autostart-firefox-bookmarks.sh
 		echo "if [[ -z $DISPLAY ]]; then bash /usr/bin/autostart-firefox-bookmarks.sh; fi" >> $shell_rc
		echo "Installed successfully."
	else
		echo "Canceled."
	fi

	printf "Do you want to install bookmarks manager?[Y/n]: "
	read -r install_bookmarks_manager
	if [[ $install_bookmarks_manager =~ [yY](es)* ]]; then
		sudo cp ./scripts/modules/bookmrk.sh /usr/bin/bookmrk
		echo "Installed successfully."
	else
		echo "Canceled."
	fi
	exit 0
}	

function uninstall() {
	echo "Started uninstalling..."
	rm -rf $root_folder
	echo "Removed $root_folder"
	sudo rm /usr/bin/autostart-firefox-bookmarks.sh
	echo "Removed /usr/bin/autostart-firefox-bookmarks.sh"
	local clerned_rc="$(grep -vGU "bash /usr/bin/autostart-firefox-bookmarks.sh" $shell_rc)"
	echo -e "$clerned_rc" > $shell_rc; mac2unix -q $shell_rc
	echo "Removed startup command runs saved bookmarks"
	sudo rm /usr/bin/bookmrk
	echo "Removed /usr/bin/bookmrk"
	echo "Finished"
	exit 0
}

function help() {
	echo "Usage: $0 -h | -u | -i"
	echo "     -h help          Show this page"
	echo "     -u uninstall     Uninstall bookmrk and startup script"
	echo "     -i install       Install bookmrk and startup script"
	return 0
}

if [[ $# -eq 0 ]]
then
	echo "No options found!"
	exit 1
fi

options="hui"
while getopts $options opt; do
	case $opt in
		h) help;;
		u) uninstall;;
		i) install;;
		*) 
			echo "Uknown option $OPTARG"
			exit 1
		;;
	esac
done


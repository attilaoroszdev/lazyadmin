#!/bin/bash

# Lazy Admin
#
# Copyright © 2017, Attila Orosz
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

installtarball=./files-v2.0-min.tar.gz


# Installer function(s)

function set_symlink_dir {

	echo
	echo
	echo "Please specify where to symlink, so that you can start la-menus as a command."
	echo "If you want no symlinking, just type \"none\" (without the quotes)"
	echo
    read -p "> " symlinkdir
	while true; do
		if [[ "$symlinkdir" == "none" ]]; then
			symlinking="false"
			echo
			echo "No symbolic link will be created."
			sleep 1
			break
		else
			if [[ -d $symlinkdir ]]; then
				echo
				echo "A symbolic link will be created in"
				echo
				echo "$symlinkdir"
				symlinking="true"
				sleep 1
				break
			else
				echo
				echo "Not a valid directory, try again."
				echo
				read -p "> " symlinkdir
			fi
		fi

	done
}



# Start install script

clear

if [[ -f $installtarball ]]; then
    echo
    echo "Found archive..."
else
    echo
    echo "Archive missing or broken, exiting..."
    exit 65
fi


echo
echo "This is the installer for Lazy Admin, a tool for admins who are lazy."
echo
echo "By the time you've finished customozing it, you will know why it is bad to be "
echo "lazy, but for now, please provide some valuable details for installation".
echo
echo "First I need you to tell me, wether you want me to create a user"
echo "specific installation in $HOME/.LazyAdmin_Minimal/, or install globally"
echo "in /opt/LazyAdmin_Minimal/"
echo
echo "1 - Install for current user only"
echo "2 - Install for all users"
read -p "> " -n 1 installtype


while true; do

	case $installtype in

	1)
		installtype="local"
		installdir="$HOME"
		break
		;;
	2)
		installtype="global"
		installdir="/opt/LazyAdmin_Minimal/"
		break
		;;
	*)
	echo
	echo "Come on, it's a simple enough choice. 1 or 2?"
	echo
	read -p "Choose 1, or 2> " -n 1 installtype
	;;

	esac
done

echo
echo "You will find your starter file named \"mladmin\" in"
echo
echo "$installdir"
echo
echo "when this installer finishes."
echo
echo "Please confirm if it's OK to symlink the starter file in /usr/local/bin"
echo
read -p "(y/n) > " -n 1 isitok

while true; do

	case $isitok in

	"y" | "Y")
	    echo
	    echo "A symlink will be created in /usr/local/bin"
	    echo
		symlinking="true"
		symlinkdir="/usr/local/bin"
		break
		;;
	"n" |"N")
		set_symlink_dir
		break
		;;
	*)
	echo
	echo "Please go again. Y or N?"
	echo
	read -p "(y/n) > " -n 1 isitok
	;;

	esac
done


if [[ "$installdir" == "$HOME" ]]; then

    installdir="$HOME/.LazyAdmin_Minimal"

fi


echo
echo "Extracting Lazy Admin system and user files..."


if [[ -d "$HOME/.config/LazyAdmin_Minimal/" ]]; then
	echo
	echo "A user config directory already exists. Can I purge it?"
    echo "This will delete all your previous configurations, so be careful."
    echo "(If you are upgrading from a previous version, it's probably better to say no...)"
    echo "Type \"yes\" (without the quotes) to proceed with purging, or anything else to"
    echo "keep the config files"
    echo
	read -p "(yes/no) > " isitok
	if [[ "$isitok" == "yes" || "$isitok" == "YES" || "$isitok" == "Yes" ]]; then
		echo
		echo
		echo "Purging old configs..."
		mv "$HOME/.config/LazyAdmin_Minimal/user" "$HOME/.config/LazyAdmin_Minimal/user.OLD"
		echo
		echo "Just kidding. I renamed the old configs and preserved it in case you'd change you mind later'"
		sleep 1
	else
		echo
		echo
		echo "Using old configs can lead to unexpected behavour..."
		echo "if you encounter problems, run the installer again, and purge old config files"
		sleep 1
	fi

else
	echo
	echo "Creating config directory for user..."
	mkdir "$HOME/.config/LazyAdmin_Minimal/"
	sleep 1
	echo
	echo "Done."
	sleep 1
fi

userfilesdir="$HOME/.config/LazyAdmin_Minimal"

echo
echo "Extracting files..."



if [[ $installtype = "local" ]]; then

if [[ -d "$HOME/.LazyAdmin_Minimal/" ]]; then

        rm -rf "$HOME/.LazyAdmin_Minimal/"

   fi

   mkdir "$HOME/.LazyAdmin_Minimal/"
   installdir="$HOME/.LazyAdmin_Minimal"

   tar xvzC "$installdir" -f $installtarball "core"



else

    echo
    echo "Attempting to access /opt. Need root"
    echo

    if [[ -d "/opt/LazyAdmin_Minimal/" ]]; then

       sudo rm -rf "/opt/LazyAdmin_Minimal/"

    fi


    sudo mkdir "/opt/LazyAdmin_Minimal/"
    installdir="/opt/LazyAdmin_Minimal"

    sudo tar xvzC "$installdir" -f $installtarball "core"


fi


# Store the tarball in case of global install (we might need it later)
# Needs to be done bfpore injectting values

if [[ installtype == "global" ]]; then

    sudo sed -i "s|COREDIRPLACEHOLDER|CORE_DIR=\"$installdir/core\"|" "$installdir/core/includes-min.la"

else

    sed -i "s|COREDIRPLACEHOLDER|CORE_DIR=\"$installdir/core\"|" "$installdir/core/includes-min.la"


fi



echo
echo "Extracing finished."
echo

if [[ $installtype="local" ]]; then

    launcherdir="$HOME"

else

    launcherdir=$"installdir"


fi


echo "I will put the starter file in $installdir"
sleep 1


if [[ -f "$launcherdir/mladmin" ]]; then
	echo
	echo "Starter file already exists. Removing..."

	if [[ $installtype == "global" ]]; then

	    sudo rm "$launcherdir/mladmin"

	else

		rm "$launcherdir/mladmin"

	fi

	sleep 1
fi

echo
echo "Creating new starter file: $launcherdir/mladmin"
echo



if [[ $installtype = "global" ]]; then

    sudo tar xvzC "$launcherdir" -f $installtarball --strip=1 "launcher/mladmin"
    sudo sed -i "s|COREDIRPLACEHOLDER|CORE_DIR=\"$installdir/core\"|" "$launcherdir/mladmin"

else

    tar xvzC "$launcherdir" -f $installtarball --strip=1 "launcher/mladmin"
    sed -i "s|COREDIRPLACEHOLDER|CORE_DIR=\"$installdir/core\"|" "$launcherdir/mladmin"

fi

sleep 1

echo
echo "Done."
echo

echo "Attempting to make la-menus executable."
echo "(If this step fails, you will need to do this manually)"

if [[ installtype == "gobal" ]]; then

    sudo chmod 0755 "$launcherdir/mladmin"

else

    chmod ug+rwx "$launcherdir/mladmin"

fi

sleep 1
echo
echo "Done (unless you got an error here)."


sleep 1
if [[ "$symlinking" == "true" ]]; then
	echo
	echo "Now creating symlink in  $symlinkdir."
	echo "It is likely a system directory, so sudo will be used..."
	echo


    if [[ -f "$symlinkdir/mladmin" ]]; then


        sudo rm "$symlinkdir/mladmin"

    fi


	sudo ln -s "$launcherdir/mladmin" "$symlinkdir/mladmin"
	sleep 1
	echo
	echo "All done!"
	echo "You can now start Lazy Admin by Typing 'ladmin' as a command."
	echo "Check help for customizaton info and options."
else
	echo
	echo "All done!"
	echo "You can now start lazy Admin by typing (sh) $launcherdir/mladmin"
	echo "Check help for customizaton info and options."

fi


echo
echo "Cleaning up temporary files (getting rid of the evidence)..."

# Get rid of the evidence...
rm $installtarball
rm ./install-min.sh

echo
echo "Done."
sleep 1
echo
echo "Installation seems to have finished."
echo "Now press anything to go back to doing whatever it was you did before..."
read -n 1 -s keypress

exit 0

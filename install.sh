#!/bin/bash
clear

if [[ -f "./lazy_admin_0.2b.tar.gz" ]]; then
 echo
 echo "Found archive..."
else
 echo
 echo "Archive missing or broken, exiting..."
 exit 65
fi


function set_symlink_dir {

	echo
	echo
	echo "Please specify where to symlink, so that you can start la-menus as a command."
	echo "If you want no symlinking, just type \"none\" (without the quotes)"
	echo
    rad -p "> " symlinkdir
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

echo
echo "This is the installer for Lazy Admin, a tool for admins who are lazy."
echo
echo "By the time you've finished customozing it, you will know why it is bad to be "
echo "lazy, but for now, please provide a default installation directory to put the "
echo "starter file, or press <Enter> to put it into your home directory:"
echo
echo "$HOME"
echo
read -p "> " installdir

if [[ "$installdir" == "" ]]; then
	installdir="$HOME"
else
	if [[ -d "$installdir" ]]; then
		echo
	else
		echo
		echo "Not a directory. installing to your home directory instead."
		installdir="$HOME"
	fi
fi

echo
echo "You will find your starter file named \"la-menus\" in"
echo
echo "$installdir"
echo
echo "Please confirm if it's OK to symlink the starter file in /usr/bin"
echo
read -p "(y/n) > " -n 1 isitok

while true; do

	case $isitok in

	"y" | "Y")
		symlinking="true"
		symlinkdir="/usr/bin"
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

echo
echo "Extracting Lazy Admin system and user files..."


if [[ -d $HOME/.config/lazy_admin ]]; then
	echo
	echo "Config directory already exists. Can I purge it?"
    echo "This will delete all your cnfigurations, so be careful."
    echo "(If you are upgrading from a previous version, it's probably better to say no...)"
    echo
	read -p "(y/n) > " -n 1 isitok
	if [[ "$isitok" == "y" ]]; then
		echo
		echo
		echo "Purging old configs..."
		rm -rf  $HOME/.config/lazy_admin
		sleep 1
	else
		echo
		echo
		echo "Using old config can lead to unexpected behavour..."
		echo "if you encounter problems, run the installer again, and purge old config files"
		sleep 1
	fi

else
	echo
	echo "Making config directory..."
	mkdir $HOME/.config/lazy_admin
	sleep 1
	echo
	echo "Done."
	sleep 1
fi

echo
echo "Extractng files..."

tar xvzC $HOME/.config/ -f ./lazy_admin_0.1b.tar.gz

echo
echo "Extract seems to have finished. No error check here, so not sure..."
echo
echo "Entering installation directory:"
echo
echo "$installdir"
sleep 1
cd $installdir

if [[ -f "./la-menus" ]]; then
	echo
	echo "Starter file already exists. Removing..."

	rm ./la-menus
	sleep 1
fi

echo
echo "Creating new starter file:"
echo
echo "$installdir/la-menus"
touch ./la-menus

echo "#!/bin/bash" >> ./la-menus
echo "" >> ./la-menus
echo ". $HOME/.config/lazy_admin/core/la-menu-defaults" >> ./la-menus
echo ". $HOME/.config/lazy_admin/core/la-menu-functions" >> ./la-menus
echo ". $HOME/.config/lazy_admin/user/la-function-aliases" >> ./la-menus
echo "" >> ./la-menus
echo "main \"$@\"" >> ./la-menus
sleep 1
echo
echo "Done."
echo

echo "Attempting to make la-menus executable."
echo "(If this step fails, you will need to do this manually)"

chmod ug+rwx ./la-menus

sleep 1
echo
echo "Done (unless you got an error here)."
sleep 1
if [[ "$symlinking" == "true" ]]; then
	echo
	echo "Now creating symlink in  $symlinkdir."
	echo "It is likely a system directory, so sudo will be used..."
	echo
	sudo ln -s $installdir/la-menus $symlinkdir/la-menus
	sleep 1
	echo
	echo "All done!"
	echo "You can now start Lazy Admin by Typing la-menus as a command."
	echo "Check help for customizaton info and options."
else
	echo
	echo "All done!"
	echo "You can now start lazy Admin by typing sh $installdir/la-menus"
	echo "Check help for customizaton info and options."

fi
echo
echo "Now press anything to go back to doing whatever it was you did before..."
read -n 1 -s keypress

exit 0

#!/bin/bash

# Lazy Admin
#
# Copyright © 2017, Attila Orosz, http://wayoflinux.com
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

installtarball=./files-v2.1-minimal.tar.gz

# Installer function(s)

if [[ "$(whoami)" == "root" ]]; then 

    echo
    echo "you should run this installer as a normal user."
    echo "Root privileges will be obtained as and when needed."
    echo "I will exit now..."
    echo
        exit 69

fi


# Run some function or script or command or anythign as root,
# either with or without sudo
function run_as_root {

    if [[ -z $preferredrootcommand ]]; then
        echo
        echo "Will need root privileges to run some parts."
        echo "How do you like to become root"
        echo
        echo "1 - su"
        echo "2 - sudo"
        echo "3 - I'm not sure..."
        echo
        read -p "Pick one > " -n 1 usesudo
        echo " "

        while true; do

            case $usesudo in

            "1")
                preferredrootcommand="su"
                
                break
                ;;
                
            "2")
                preferredrootcommand="sudo"
                
                break
                ;;
            "3")
                if groups "$(whoami)" | grep &>/dev/null '\bsudo\b'; then
                    
                    echo
                    echo "Your user can use sudo, setting it as preference..."
                    echo

                    preferredrootcommand="sudo"

                else

                    echo
                    echo "Your user can't use sudo, setting 'su' as preference..."
                    echo

                    preferredrootcommand="su"

                fi   
                break

                ;;
            
            *)
                echo
                echo "Please go again. Pick 1 - 3:"
                echo
                read -p "(1, 2, or 3) > " -n 1 usesudo
                ;;

            esac
        done
    fi
    
    commandsuffix=""

    echo
    echo "I need to become root now."

    if [[ $preferredrootcommand == "su" ]]; then
        
        echo "Plase provide root pasword when prompted"
        echo
        
        su -c "$1; exit"

    else 
        
        echo "Please provide sudo password if prompted"
        echo
        
        sudo -- sh -c "$1"                

    fi

}


function set_symlink_dir {

    echo
    echo
    echo "Please specify where to symlink, so that you can start la-menus as a command."
    echo "If you want no symlinking, just type \"none\" (without the quotes)"
    echo
    read -p "> " symlinkdir
    while true; do
        if [[ "$symlinkdir" == "none" ]]; then
            symlinking=false
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
                symlinking=true
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
echo "This is the installer for Lazy Admin."
echo
echo "First I need you to tell me, wether you want me to create a user"
echo "specific installation in $HOME/.LazyAdmin/, or install globally"
echo "in /opt/LazyAdmin/"
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
        installdir="/opt/LazyAdmin/"
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
echo "You will find your starter file named \"ladmin\" in"
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
        symlinking=true
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

    installdir="$HOME/.LazyAdmin"

fi


echo
echo "Extracting Lazy Admin system and user files..."


if [[ -d "$HOME/.config/LazyAdmin/" ]]; then
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

        if [[ -d "$HOME/.config/LazyAdmin/user.OLD" ]]; then

            rm -rf "$HOME/.config/LazyAdmin/user.OLD"
        fi

        mv "$HOME/.config/LazyAdmin/user" "$HOME/.config/LazyAdmin/user.OLD"
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
    mkdir "$HOME/.config/LazyAdmin/"

    sleep 1
    echo
    echo "Done."
    sleep 1
fi

userfilesdir="$HOME/.config/LazyAdmin"

echo
echo "Extracting files..."

tar xvzC "$userfilesdir" -f $installtarball "user"


if [[ $installtype == "local" ]]; then

   if [[ -d "$HOME/.LazyAdmin/" ]]; then

        rm -rf "$HOME/.LazyAdmin/"

   fi

   mkdir "$HOME/.LazyAdmin/"
   installdir="$HOME/.LazyAdmin"

   tar xvzC "$installdir" -f $installtarball "core"
    
   sed -i "s|COREDIRPLACEHOLDER|CORE_DIR=\"$installdir/core\"|" "$installdir/core/includes.la"

   
else

    echo
    echo "Attempting to access /opt. Need root"
    echo

    installdir="/opt/LazyAdmin"

    if [[ -d $installdir ]]; then

        echo "Replacing old installation"

        run_as_root "rm -rf /opt/LazyAdmin && mkdir -p /opt/LazyAdmin && tar xvzC \"$installdir\" -f $installtarball 'core'; sed -i \"s|COREDIRPLACEHOLDER|CORE_DIR=$installdir/core|\" \"$installdir/core/includes.la\""
    
    else
      
       run_as_root "mkdir -p /opt/LazyAdmin && tar xvzC \"$installdir\" -f $installtarball 'core'; sed -i \"s|COREDIRPLACEHOLDER|CORE_DIR=$installdir/core|\" \"$installdir/core/includes.la\""
     

    fi


fi

echo
echo "Extracing finished."
echo

if [[ $installtype == "local" ]]; then

    launcherdir="$HOME"

else

    launcherdir="$installdir"


fi


echo "I will put the starter file in $launcherdir"
sleep 1


if [[ -f "$launcherdir/ladmin" ]]; then
    echo
    echo "Starter file already exists. Removing..."

    if [[ $installtype == "global" ]]; then

       run_as_root rm "$launcherdir/ladmin"

       
    else

        rm "$launcherdir/ladmin"

    fi

    sleep 1
fi

echo
echo "Creating new starter file: $launcherdir/ladmin"
echo

if [[ $installtype == "global" ]]; then

    run_as_root "tar xvzC \"$launcherdir\" -f $installtarball --strip=1 \"launcher/ladmin\"; sed -i \"s|COREDIRPLACEHOLDER|CORE_DIR=$installdir/core|\" \"$launcherdir/ladmin\""

    
else

    tar xvzC "$launcherdir" -f $installtarball --strip=1 "launcher/ladmin"
    sed -i "s|COREDIRPLACEHOLDER|CORE_DIR=\"$installdir/core\"|" "$launcherdir/ladmin"

fi

sleep 1

echo
echo "Done."
echo

echo "Attempting to make la-menus executable."
echo "(If this step fails, you will need to do this manually)"

if [[ installtype == "gobal" ]]; then

    run_as_root "chmod 0755 \"$launcherdir/ladmin\""
    
else

    chmod 0755 "$launcherdir/ladmin"

fi

sleep 1
echo
echo "Done (unless you got an error here)."


sleep 1
if symlinking; then
    echo
    echo "Now creating symlink in  $symlinkdir."
    echo "It is likely a system directory, so root will be needed..."
    echo


    if [[ -f "$symlinkdir/ladmin" ]]; then

       run_as_root "rm \"$symlinkdir/ladmin\"; ln -s \"$launcherdir/ladmin\" \"$symlinkdir/ladmin\""

    else 

        run_as_root "ln -s \"$launcherdir/ladmin\" \"$symlinkdir/ladmin\""

    fi
    
    sleep 1
    echo
    echo "All done!"
    echo "You can now start Lazy Admin by Typing 'ladmin' as a command."
    echo "Check help for customizaton info and options."
else
    echo
    echo "All done!"
    echo "You can now start lazy Admin by typing (bash) $launcherdir/ladmin"
    echo "Check help for customizaton info and options."

fi


echo
echo "Done."
sleep 1

echo
echo "Installation seems to have finished."
echo "You can start LazyAdmin by typing"
echo
echo "ladmin"
echo
echo "as a command."
echo "Now press anything to go back to doing whatever it was you did before..."
read -n 1 -s keypress

exit 0
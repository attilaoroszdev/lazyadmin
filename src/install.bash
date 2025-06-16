#!/bin/bash

# Lazy Admin
#
# Copyright © 2017-2025, Attila Orosz
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

installtarball=./files-v3.0.tar.gz

# Installer function(s)

if [[ "$(whoami)" == "root" ]]; then 
    echo
    echo "You should run this installer as a normal user."
    echo "Root privileges will be obtained as and when needed."
    echo "I will exit now..."
    echo
    
    exit 65
fi


# Run some function or script or command or anythign as root,
# either with or without sudo
run_as_root() { 
    if [[ -z $preferred_root_command ]]; then
        echo
        echo "Will need root privileges to run some parts."
        echo "How do you like to become root"
        echo
        echo "1 - su"
        echo "2 - sudo"
        echo "3 - I'm not sure..."
        echo
        read -p "Pick one > " -n 1 use_sudo
        echo " "

        while true; do
            case $use_sudo in
                "1")
                    preferred_root_command="su"
                    break
                    ;; 
                "2")
                    preferred_root_command="sudo"
                    break
                    ;;
                "3")
                    if groups "$(whoami)" | grep &>/dev/null '\bsudo\b'; then
                        echo
                        echo "Your user can use sudo, setting it as preference..."
                        echo
                        preferred_root_command="sudo"
                    else
                        echo
                        echo "Your user can't use sudo, setting 'su' as preference..."
                        echo
                        preferred_root_command="su"
                    fi   
                    break
                    ;;
                *)
                    echo
                    echo "Please go again. Pick 1 - 3:"
                    echo
                    read -p "(1, 2, or 3) > " -n 1 use_sudo
                    ;;
            esac
        done
    fi
    
    echo
    echo "I need to become root now."

    if [[ $preferred_root_command == "su" ]]; then
        echo "Plase provide root pasword when prompted"
        echo
        su -c "$@; exit"
    else 
        echo "Please provide sudo password if prompted"
        echo
        sudo -- bash -c "$@"      
    fi
}


set_symlink_dir() { 
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


# This currently means `sed` and `tar`, and the latter is only necessary for this installer to work.. 
# While these come rpesinstalled in most systems, it never hurts to chekc
check_for_essential_dependencies() {     
    while true; do
        echo
        echo "Checking if we have 'tar'..."
        sleep 1

        if hash tar 2>/dev/null; then
            echo
            echo "Of course, we do. Why wouldn't we...?"
            break
        else
            echo
            echo "It looks like 'tar' is missing."
            echo "Seriously, what kind of systemn is this???)"
            echo
            echo "Do you want to install 'tar' now? (I wil try to use apt)"
            echo
            read -p "(y/n) > " -n 1 installtar

            if [[ $installtar == "y" || $installtar == "Y" ]]; then
                run_as_root "apt install tar"
            elif
                [[ $installtar == "n" || $installtar == "N" ]]; then
                echo
                echo "Awright, suit yourself. But I cannot go on without tar, sorry."
                echo 
                echo "I will now exit. Come back when you have 'tar'". 
                exit 65
            else
                echo
                echo "You want to try that again."
                echo "It's really quite simple: Press y for 'yes', or n for 'no'". 
                echo "(You know, on the keyboard.)"
                echo
                read -p "(y/n) > " -n 1 installtar
            fi
        fi
    done
}


check_for_external_dependencies() { 
    if hash pandoc 2>/dev/null; then
        pandoc_installed=true
    fi

    if hash lynx 2>/dev/null; then
        lynx_installed=true
    fi

    if hash xdotool 2>/dev/null; then
        xdotoolinstalled=true
    fi

    if [[ $pandoc_installed && $lynx_installed && $xdotoolinstalled ]]; then
        echo
        echo "All non-essential dependencies are satisfied, nothing to do..."
    else
        echo
        echo "Some non-essential dependencies are missing:"

        if [[ ! $pandoc_installed ]]; then
            echo "  - pandoc"
            pandocinpackage="pandoc"
        fi

        if [[ ! $lynx_installed ]]; then
            echo "  - lynx"
            lynxpackage="lynx"
        fi

        if [[ ! $xdotoolinstalled ]]; then
            echo "  - xdotool"
            xdotoolpackage="xdotool"
        fi

        echo
        echo "Want to install them now? (I wil try to use apt)"
        echo
        read -p "(y/n) > " -n 1 isitok

        if [[ $isitok == "y" || $isitok == "Y" ]]; then
            run_as_root "apt install $pandocinpackage $lynxpackage $xdotoolpackage"
        fi
    fi
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

echo "Before we start, I need to verify is essential dependencies are met"

check_for_essential_dependencies

echo
echo "This is the installer for Lazy Admin."
echo
echo "First I need you to tell me, wether you want me to create a user"
echo "specific installation in $HOME/.LazyAdmin/, or install Lazy Admin globally"
echo "for everyone in /opt/LazyAdmin/"
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
echo "You will find your launcher file named \"ladmin\" in"
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
        echo "Just kidding. I renamed the old configs and preserved it in case you'd change you mind later"
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

if [[ "$(whoami)" != "root" ]]; then
    chown -R "$currentuser":"$currentuser" "$userfilesdir"
fi

if [[ $installtype == "local" ]]; then

    if [[ -d "$HOME/.LazyAdmin/" ]]; then
        rm -rf "$HOME/.LazyAdmin/"
    fi

    mkdir "$HOME/.LazyAdmin/"
    installdir="$HOME/.LazyAdmin"

    tar xvzC "$installdir" -f $installtarball "core"
    tar xvzC "$installdir" -f $installtarball "plugins"
    tar xvzC "$installdir" -f $installtarball "res"


# file_content=$(<"$filename")
# modified_content="${file_content//old/new}"
# echo "$modified_content" > "$filename"


    # sed -i "s|RESDIRPLACEHOLDER|RES_DIR=\"$installdir/res\"|" "$installdir/core/includes.la"
    # sed -i "s|PLUGINSDIRPLACEHOLDER|PLUGINS_DIR=\"$installdir/plugins\"|" "$installdir/core/includes.la"
    # sed -i "s|COREDIRPLACEHOLDER|CORE_DIR=\"$installdir/core\"|" "$installdir/core/includes.la"
else
    needroot=false

    if [[ "$(stat -c "%U" "/opt")" == "root" ]] || [[ "$(stat -c "%G" "/opt")" == "root" ]]; then
        needroot=true
    fi

    if $needroot; then
        echo
        echo "Attempting to access /opt. I will need root privileges."
    fi

    installdir="/opt/LazyAdmin"

    if [[ -d $installdir ]]; then
        echo
        echo "Replacing old installation"

        if $needroot; then
            run_as_root "rm -rf /opt/LazyAdmin"
        else
            rm -rf /opt/LazyAdmin
        fi
        sleep 1
    fi

    echo
    echo "Extracting stuff..."

    if $needroot; then
        run_as_root "mkdir -p /opt/LazyAdmin; tar xvzC $installdir -f $installtarball 'core'; tar xvzC "$installdir" -f $installtarball 'plugins'; tar xvzC "$installdir" -f $installtarball 'res'"
        #; sed -i \"s|RESDIRPLACEHOLDER|RES_DIR=$installdir/res|\" $installdir/core/includes.la; sed -i \"s|PLUGINSDIRPLACEHOLDER|PLUGINS_DIR=$installdir/plugins|\" $installdir/core/includes.la; sed -i \"s|COREDIRPLACEHOLDER|CORE_DIR=$installdir/core|\" $installdir/core/includes.la"
    else
        mkdir -p /opt/LazyAdmin && tar xvzC "$installdir" -f $installtarball 'core'; tar xvzC "$installdir" -f $installtarball 'plugins'; tar xvzC "$installdir" -f $installtarball 'res' 
        #; sed -i "s|RESDIRPLACEHOLDER|RES_DIR=$installdir/res|" $installdir/core/includes.la; sed -i "s|PLUGINSDIRPLACEHOLDER|PLUGINS_DIR=$installdir/plugins|" $installdir/core/includes.la; sed -i "s|COREDIRPLACEHOLDER|CORE_DIR=$installdir/core|" $installdir/core/includes.la
    fi

    sleep 1
fi

declare filename="$installdir/core/includes.la"
declare file_contents=$(<"$filename")
declare modified_content="${file_contents/"RESDIRPLACEHOLDER"/"RES_DIR=\"$installdir/res\""}"
modified_content="${modified_content/"PLUGINSDIRPLACEHOLDER"/"PLUGINS_DIR=\"$installdir/plugins\""}"
modified_content="${modified_content/"COREDIRPLACEHOLDER"/"CORE_DIR=\"$installdir/core\""}"
if $needroot; then
    run_as_root "echo '$modified_content' > \"$filename\""
else
    echo "$modified_content" > "$filename"
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

    if [[ $installtype == "global" ]] && $needroot; then
       run_as_root "rm $launcherdir/ladmin"
    else
        rm "$launcherdir/ladmin"
    fi

    sleep 1
fi

echo
echo "Creating new launcher file: $launcherdir/ladmin"
echo

if [[ $installtype == "global" ]]; then

    if $needroot; then
        run_as_root "tar xvzC $launcherdir -f $installtarball --strip=1 'launcher/ladmin'"
        # sed -i \"s|INSTALLDIRPLACEHOLDER|INSTALL_DIR=$installdir|\" \"$launcherdir/ladmin\""
    else
        tar xvzC "$launcherdir" -f $installtarball --strip=1 "launcher/ladmin"
        #sed -i "s|INSTALLDIRPLACEHOLDER|INSTALL_DIR=$installdir|" "$launcherdir/ladmin"
    fi

    filename="$launcherdir/ladmin"
    file_contents=$(<"$filename")
    modified_content="${file_contents/"INSTALLDIRPLACEHOLDER"/"INSTALL_DIR=\"$installdir\""}"

    if $needroot; then
        run_as_root "echo '$modified_content' > \"$filename\""
    else
        echo "$modified_content" > "$filename"
    fi



    
else
    tar xvzC "$launcherdir" -f $installtarball --strip=1 "launcher/ladmin"

    filename="$launcherdir/ladmin"
    file_contents=$(<"$filename")
    modified_content="${file_contents/"INSTALLDIRPLACEHOLDER"/"INSTALL_DIR=\"$installdir\""}"

    echo "$modified_content" > "$filename"
    #sed -i "s|INSTALLDIRPLACEHOLDER|INSTALL_DIR=\"$installdir\"|" "$launcherdir/ladmin"
fi

sleep 1
echo
echo "Done."
echo
echo "Attempting to make launcher executable."
echo "(If this step fails, you will need to do this manually)"

if [[ $installtype == "gobal" ]] && $needroot; then
    run_as_root "chmod 0755 $launcherdir/ladmin"
else
    chmod 0755 "$launcherdir/ladmin"
fi

sleep 1
echo
echo "Done (unless you got an error here)."
sleep 1

if $symlinking; then
    echo
    echo "Now creating symlink in  $symlinkdir."
    echo "It is likely a system directory, so root will be needed..."
    echo

    if [[ "$(stat -c "%U" "$symlinkdir")" == "root" ]] || [[ "$(stat -c "%G" "$symlinkdir")" == "root" ]]; then
        needroot=true
    else
        needroot=false
    fi

    if [[ -f "$symlinkdir/ladmin" ]]; then

        if $needroot; then
            run_as_root "rm $symlinkdir/ladmin"
        else
            rm "$symlinkdir/ladmin"
        fi

    fi

    if $needroot; then
        run_as_root "ln -s $launcherdir/ladmin $symlinkdir/ladmin"
    else
        ln -s "$launcherdir/ladmin" "$symlinkdir/ladmin"
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
echo "Post-install optional dependency check."
echo "(Because you thought it was over, didn't you?)"
echo
echo "Some plugins, such as \"Help\",or \"Extra functions\""
echo "require external stuffs to be installed. Wanna check for"
echo "any missing dependencies now?"
echo
read -p "(y/n) > " -n 1 isitok

if [[ $isitok == "y" || $isitok == "Y" ]]; then
    check_for_external_dependencies
else
   echo
   echo "In that case we are all done."
fi

echo
echo "Installation seems to have finished."
echo "You can start LazyAdmin by typing"
echo
echo "ladmin"
echo
echo "as a command."
echo
echo "Now press anything to go back to doing whatever it was you did before..."
read -n 1 -s key_press

exit 0
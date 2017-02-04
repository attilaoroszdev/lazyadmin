# Lazy Admin - a bash cli menu system.

Lazy Admin will draw a pseudo graphical menu on your terminal, or terminal emulator, using nothing but `bash`, and `sed`.

## Why Lazy Admin?

You can thin of Lazy Admin as aliases on steroids. People are inherently visual. Instead of remembering  and typing out long commands, funny script names, and all their parameters, or even funnier aliases, you can store the on a conveniently navigable tabbed menu-like interface.

## What does it do?

* **Arrow-key navigation** - No awkward keyboard bindings. Arrow keys do what you expect them to do
* **List-like menu items** - Each menu item is accessible through navigating a vertical list
* **One liner item descriptions** - When you navigate the menu, a description appears in the bottom row
* **Tabs for grouping similar items** - Left/Right arrows will switch tabs
* **Shortkeys** - Each item is accessible by pressing its corresponding number on the current tab. E.g. to launch the 3rd item, press 3.
* **Sub-menus** - Any menu-item can invoke a sub-menu, which can hold further items
* **Single command sub-menus with predefined parameters** - Visually build long commands (see image below)
* **Optional side panel** - with predefined items like *Help*, *Reflow menu*, and *Exit*, which can also hold user defined items. Ideal for holding menu items that might apply to all tabs.
* **No dependencies "pure" bash interface** - ideal for managing servers via SSH.
* **Easy set-up** - The "interactive" installer script is completely platform independent. Settings can be changed by editing simple text files. Script aliases bind scripts to menu items by position, and a user script "repository" file is also available.

## Screenshots

They say that a picture is worth a thousand words. So here's Lazy Admin in 4000 words:

![](/media/lazy-admin-1.png)

![](/media/lazy-admin-2.png)

![](/media/lazy-admin-3.png)

![](/media/lazy-admin-4.png)


## Yeak ok, but why *Lazy* Admin?

Because it's meant for sysadmins, who are lazy. Lazy to type, lazy to remember, etc.

## Does it make sense?

Probably not a lot, but it's fun. Although if you have mundane and/or repetative tasks to run on remote servers via SSH, it can be rather helpful.

## Installing Lazy Admin

Installation is pretty straightforward. Download the latest release, and unpack the tarball. it should contain an `install.sh` script, and another tarball, corresponding to the release's version number. Keep these in the same directory and run the script. There are a few options, to choose form, but these will be explained as you go along.

### Upgrading from a previous version

If you already have Lazy Admin installed, and want to upgrade, you can just ruin the installer as normal. It will ask you if you want to purge your previous user configurations. If you say no, you will keep them and the new version will automatically use your defined menus and functions.

## So how can I configure it?

You can access the configuration files from `$HOME/.config/lazy_admin/user/`

### Adding menu items

To **add menu items**, open the file named `la-menuentries`, and follow the instructions in the comments. It's quite well documented.

### Binding commands to menus

To **bind a script/command to a menu entry**, open the `la-function-aliases` files, and write your scrip command in a function named `funct<tab-number><menu-item-number>`.

Note that **numbering starts at 0**, so the **first tab is no. 0**, so is the first menu item. Thus a function bound to the **3rd menu item** on the **2nd tab** would look like this:

```
function funct12 {

    # Your favourite bash command here

}
```

For greater re-usability and cleaner function-menu binding (especially if you use longer scripts), you can actually write your scripts in the `la-user-functions` file, formatted as bash functions, and just call them from the appropriate alias in `la-function-aliases`. naturally, you can also call any other scrip form anywhere you like.

### Adding a menuitem with submenus

To add a menu item that will **open a submenu**, call the predefined function ` enter_submenu` with three parameters: `<tab-number> <menu-item-number> "<submenu-title>"`

So for example to open a submenu from the above function, with the title "My Submenu", you would do something like

```
function funct12 {

    enter_submenu 1 2 "My Submenu"

}
```

To add submenu items to the submenu, you would use the alias

`subfunct<tab-number><menu-item-number><submenu-item-number>`

The first two items for the above defined submenu would look like this (remember, numbering starts from 0):

```
function subfunct120 {

    # Command or script to run form first submenu item

}

function subfunct121 {

    # Command or script to run form second submenu item

}
```

### Changing defaults

To **change some default values**, like increase the menu capacity (current height is set to 8), you can find some editable entries in `$HOME/.config/lazy_admin/core/la-menu-defaults`

### Special functions

There are some **special functions** predefined in `$HOME/.config/lazy_admin/core/la-extra-functions`, through which you can run stuff in a new terminal tab or new terminal window (regardless of what terminal emulator you are using).

> **Hint** These will only work in you local emulator, so if you will need to establish a new remote connection from each new tab or window if you are working remotely, so this might not make so much sense anyway. Good for local use though.

Another special function is `run_function_in_tmp_directory` which will enter a given directory, run a function or command, then return to the original directory. It can save you some repetitive scripting.

### In more detail, please?

I will most likely include a more detailed guide here as well, but for now, please use the *Help* option from the side panel for more details. To access th side panel, you can just press `t` (although this will almost certainly change in a future, hopefully to something much more intuitive). An alternative way to launch *Help* is to press `h`.

## Future plans

There are a few improvements on the way, such as:

* [ ] A better install script
* [ ] Global install option (currently it's per user only)
* [ ] Proper man page, and Markdown based help files (displayed with `pandoc` and `lynx`)
* [ ] Interactively change menus bindings and defaults, from withing Lazy Admin

# **Lazy Admin User Guide**

**This document is deprecated as of Lazy Admin 3.0 Beta**


## **Overview**

The basic functionality of Lazy Admin is to provide a pseudo graphical UI, one that can be navigated by the arrow keys, or with keyboard shortcuts, to hold script or command aliases on an easily navigable, tabbed menu-like interface. All without the need of external libarires, or tools, not even using `ncurses`.  (Not that I have anything against `ncurses`.)

It started as a proof of concept, but eventually grew into a quite featureful, and useful little tool. If you are a lazy sysadmin, who is tired of typing long commands and cannot remember the aliases he set (it must come with age), you might even find it handy. Maybe you need to manage a headless server with extremely limited capacities, or something, dunno.

The biggest advantage of Lazy Admin over... well, probably over a graphical interface, is that it uses almost no external libraries. The whole thing runs as a `bash` script, making heavy use of `sed`. There are some functions that use other packages, but these are carefully separated as plugins, making the core (hopefully) compatible with almost anything.

Again, if you are a sysadmin, who does a lot of remote server maintenance, you will find that Lazy Admin runs super fast over SSH. Because there is noting fancy to run, really.

## **Capacity**

The downloaded version, of Lazy Admin is already set to have 6 tabs, 5 of which are free to use (6th is reserved, but it does not have to be), each holding up to 9 entries. That makes the maximum capacity of the main menu alone 45 commands or functions. (Or 51 if you override the setup tab).

You can also use sub-menus, if you like, each could hold up to nine entries with the default settings. This means, with 5 main menu tabs, each holding 9 sub-menus, which in turn hold 9 sub-menu entries each, theoretically your total number or entries would be 405 (or 459 without the setup)

If that is not enough, you can add up to 9 tabs, if you use short enough names. Unfortunately, you cannot add more than 9 entries per tab as of now. (This limitation is due to how Lazy Admin handles menu function aliases (single digits are only accepted at the moment).

Thus, the maximum capacity assuming 9 tabs, each with 9 menus that hold 9 sub-menus, is 9x9x9=729 entries. Now, if you have 729 commands or scripts and you are still short on space, you already are having serious issues...

## **Command line arguments**

Lazy Admin can be started by either typing `ladmin` as a command, or for the portable version by navigating to its folder and launching it with either `bash pladmin` or `./pladmin`.

Lazy Admin currently takes two command line arguments:

- `--join-lines` or `-j`
- `--load-profile` or `-p`

### `--join-lines`, or `-j`

`--join-lines` or `-j` for short, can override the default setting of the `$DISPLAY_LINE_CONNECTORS` variable. This is useful when accessing Lazy Admin via e.g. SSH, and the device used does not display Lazy Admin correctly. This can happen when using a terminal emulator on Android devices, which often do not use proper monospace font.

- `ladmin --join-lines off` or `ladmin -j off` will start Lazy Admin without drawing line-jonits, so that no misalignment occusr with non-monospace fonts
- `ladmin --join-lines on` or `ladmin -j on`will force drawing line-jonits, even when Lazy Admin is set not to draw them

### `--load-profile`, or `-p`

`--load profile` or `-p` for short, can be used to load a custom user profile. This profile must be a directory, named anything, but with contents identical to the `user` folder located either in `~/.config/LazyAdmin/`, or the portable version's root folder.  Since version 2.2, the profiles folder can be located anywhere, and you can specify absolute or relative paths to load it. If the profile folder is in the default location, it is enough to provide the folder name, no path is needed.

**Example 1**

Assuming you have a user profile called `myprofile`, located in `~/.config/LazyAdmin/myprofile`, just run 

``` bash

    ladmin --load-profile myprofile

```

to load different default (user) settings, different menus and user functions, etc.

**Example 2**  

Assuming you have a user profile called `myprofile`, located in `~/LAdminProfiles/myprofile`, run either

```bash

    ladmin --load-profile ~/LAdminProfiles/myprofile

```

or

```bash

    ladmin --load-profile ../../LAdminProfiles/myprofile

```

**Example 3**

Assuming Assuming you have a user profile called `myprofile`, located in the same directory the portable version of Lazy Admin lives (where the `pladmin` files is), just run

```bash

    ./pladmin --load-profile myprofile

```

**Example 4**

Assuming you have a user profile called `myprofile`, located in `~/LAdminProfiles/myprofile`, and you are using the portable version, just stat Lazy Admin with:

```bash

    ./pladmin --load-profile ~/LAdminProfiles/myprofile

```

## **Navigation**

Navigation is simple:

- Up: `↑` (up arrow) or `w`
- Down: - `↓`  (down arrow) or `s`
- Left (change tab): - `←` (left arrow) or `a`
- Right (change tab): - `→` (right arrow) or `d`
- Change to right panel: `Ctrl` + `→ or r`
- Change to left panel: `Ctrl` + `←` or `l`
- Back to previous level: `b`
- Select menu item - `1` to `9` or `<Enter>`

### **Skipped entries**

If a menu entry is skipped (this can be done by entering `skip` in its place in the menu file, which can be handy for visual grouping), its position still counts. E.g. if you have an arrangement of a menu like this (with a gap between the 2nd and 3rd):

```bash

    1 - First entry
    2 - Second entry
        
    4 - Third entry

```

You could select the "Second entry" by navigating there with the arrow keys, or by pressing number `2` on the keyboard. To select the "Third entry", you would have to press number `4`. That is because that entry has the position #4 the menu (position #3 is empty).

*Tip: To make navigation easier and more straightforward, it is probably a good idea to name your menu entries preceded with the shortcut key, as in the example above.*

There is a special option on the right panel, called *Reflow menu*. Selecting this option, or its hotkey `f` will redraw the menu, and all its items. Use this when you resize the terminal emulator's window, or if the menu gets distorted for any reason.

## **Hotkeys**

All of the above mentioned actions and all the right panel options also have hotkeys assigned. This is to allow for faster navigation, and to provide an alternative to some keys that might be missing on certain devices (e.g. on a mobile-phone's terminal emulator over ssh).

The preset hotkeys are as follows:

- Select menu item `1` - `9`
- Reflow menu: `f`
- Go to the help menu: `h`
- Display key bindings and hotkeys cheatsheet: `k`
- Quit Lazy Admin: `q`

There are some reserved keys for certain setup menu items, so that you can still access them, even if you prefer not to display a Setup tab:

- Edit menu entries: `e`
- Edit user functions: `u`
- Bind functions to menus: `m`
- Edit default values: `v`

In the command builder (see below), you have three additional reserved keys, which you can only use inside a command builder menu:

- Manually specify flags or arguments: `m`
- Clear all flags or arguments: `x`
- Run the command with the set flags or arguments: `c`

## **Command builder**

There is a special, visual command builder function built right into Lazy Admin, called the command builder. You can bind this interface to any menu or sub-menu item, and it will bring up a special type of sub-menu, allowing you to visually build long commands with preset flags, arguments, or sets of flags/arguments. To access this functionality, you need to bind `flags_sub_menu_funtion` with the right arguments to the menu or sub_menu item you wish to invoke the command builder with.

To learn how to use the command builder function, check out the `Command Builder Usage Guide` in the *Help* menu


## **Bottom row**

At the bottom of the UI, there is a special row, which displays a short one liner description of the currently highlighted menu item. These descriptions must be set at the same time menu items are set up, and are available for menu and sub-menu items, and right panel items, but *not* for the command builder.


## **The End**

That is all for now. I hope you find it useless, but fun to use.

I do.

If you want to know more about how to set up menus, and bind functions etc, head over to the next item in the help menu.

If you have any suggestions, or know something better, spotted an error, or just want to tell me that I'm an idiot for spending my time like this, just email me at:

[attila.orosz.dev@gmail.com](mailto:attila.orosz.dev@gmail.com)

Enjoy. :)
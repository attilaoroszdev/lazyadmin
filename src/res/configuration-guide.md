# ***Lazy Admin Customization and Scripting***

*This file had been formatted to be viewed with lynx/pandoc on a Linux CLI. Your mileage may vary with other software.*

**User beware, here there be dragons. You will have to know some basic bash before you can make modifications. It is also worth having a much better idea of bash script than I ever will, so you might as well add some useful modifications (let me know, if you have any). I have not yet implemented any user-friendly ways to change stuff. Proceed at your own risk, you may break something that was already of little use to start with...**


## **Changing menu entries**

*Note: Starting from v2.1, the menus can use a "simple" layout. This is now the default behaviour, making it easier to create menus. The old menu structure is still available as well, but it will be omitted from this document for brevity's sake.*

All the menu-entries will be stored in the file `$HOME/.config/LazyAdmin/user/menu-entries.la`. (As you might have noticed, global installation is also available, in which case each user should have their own set of config files). You find the above file and edit it in any way you like, but for convenience's sake you can also access it from within Lazy Admin. Just navigate to the *Setup* tab of the main menu, or press `e` from anywhere on the main menu level. The file itself should have some useful comments about how to proceed, it will hopefully be self-explanatory for the most.

To have it all in once place, the structure of the menu file will be explained here as well. The menu builder function parses the file looking for an underscore (`_`) symbol. This is the delimiter for the start and end of sections.

To build menus, the `menu-entries.la` file must contain the following lines:

First of all, the menu-type will be defined:

```bash

    _menutype
    simple
    _endmenutype

```

This is the default now, change it at your own risk.
  
For the menus themselves there Are three kinds of sections:

- `_menutab` ending with `_endmenutab` and hold the names of the top-row tabs, each on its own line
- `_menu` and `_endmenu` are for the main menu entries
- `_sub_menu` and `_endsub_menu` will hold the sub-menu entries

To know which menu is which, numbers will be used, starting with `1`

- For main menu entries the number will mark the tab position. This means that between `_menu1` and `_endmenu1` are all the menu entries of the first tab, `_menu2` and `_endmenu2` mark the second tab, etc. (Up to maximum 9, see below why)
- For sub-menu entries two numbers will mark the tab position and the menu position (these are **two single digits written together**, which is the reason the maximum number of menu entries is 9.) For example between `_sub_menu11` and `_endsub_menu11` you will find sub-menu entries for the `first tab`, `first menu item` (`tab 1`, `item 1`), while e.g. `_sub_menu32` and `_endsub_menu32` mark the boundaries for the sub-menu items of `third tab`, `second menu item` (`tab 3`, `item 3`), etc.

Each menu item can also have a **descriptor**, that displays on a designated row at the bottom of LazyAdmin, as you navigate. While descriptors are optional, they can enhance the experience, and give more information about what a menu item does or contain. To add a description, simply write it after the menu item, on the same line, separated by `::`, like so:

```bash

    menu item :: Description of menu item

```
  
As an example, the menu items for `Tab 3` would look like this:

```bash

    _menu3
    1st item on the 3rd tab :: Descriptor line for 1st item on the 3rd tab
    2nd item on the 3rd tab ::Descriptor line for 2ns item on the 3rd tab
    skip
    4th item on the 3rd tab :: Descriptor line for 4th item on the 3rd tab
    _endmenu3

```
  
There is one reserved word: `skip`. This will mark them menu line to be skipped. Nothing will be printed on that line, and the cursor navigation will also skip over it. This makes sense if you want to visually separate some items from others.
  
Similarly, to add a sub-menu, to the second item of the third tab, so that `Tab 3`, `Item 2` would lead to a sub-menu, you would put in the menu file:

```bash

    _sub_menu32
    First sub-menu item :: Descriptor line for first sub-menu item
    Second sub-menu item :: Descriptor line for second sub-menu item
    Third sub-menu item :: Descriptor line for third sub-menu item
    _endsub_menu32

```

Here the numbers show tab **and** main-menu item numbers.

Currently the right panel menu items do not implement this simplified menu system. To understand how these work, have a look at the code comments in the `menu-entries.la` file


## **Adding functionality to your menu items**

*Note: Starting with v2.1, a new, more human readable, and hopefully user-friendly alias system will be the default. the old notation will still be available for backward compatibility, but it will not be described here.*

To bind functions to menus, Lazy Admin uses numbered menu-bindings, where the numbers that are very similar to the numbers used with of the menu entries. The file `$HOME/.config/LazyAdmin/user/menu-bindings.la` will hold all the user's defined aliases.

The simple alias notation is set by default in your `menu-bindings.la` file with:

```bash

    functionstyle="simple"

```

DOo not change this, unless you absolutely need to and know what you are doing.

There are two types of function calls:

- `tab#item#`- for main menu entries
- `tab#item#sub#` - for sub menu entries

where `#` id the number of the tab, menu item, or sub_menu-item, respectively.

The `tab#item#` functions correspond to menu entries on the main menu level. These functions will need two numbers: tab-position and menu-entry-position. Again, the numbering starts with 1, so the first entry of the first tab will be `tab1item1`, while the `third entry` of the `second tab` will be `tab2item3`.

For sub-menus, there is an additional number for sub-menu entry, making the `tab#item#sub#` takes three numbers to be identifiable. The `first sub-menu entry` on the `first menu entry` of the `first tab` will be `tab1item1sub1` (`tab 1`, `menuitem 1`, `sub_menuitem 1`), while e.g. the `second sub-menu entry` on the `third menu` of the `second tab would` be `tab2item3sub2`.

To bind a command to a menu item, you must invoke it from a function corresponding the menu item's position. For example to put `ping localhost` to ping the hell out of your machine when you select the `second tab`'s `third item`, you'd do the following:

```bash
 
    function tab2item3 {         ping localhost
    }

```
  
To do the same from the `fourth sub-menu` of the` fifth menu` on the `third tab` (`Tab 3`, `Item 5`, `Sub-menu Item 4`), you'd go like:

```bash
 
    function tab3item5sub4 {         ping localhost
    }

```
  
It's as simple as that.


## **Invoking a sub-menu**

Binding commands to sub-menu items is all very well, but how will Lazy Admin know where to find sub-menus? Easily, you will mark its menu-binding. The built-in function to achieve this is called `enter_sub_menu`. This function will take **two arguments**. The first one must always be `$@` (basically passing on tab and menu position), and the second argument will be the **title of the sub-menu** to be displayed. because in Kazy Admin, you name your own sub-menus. Oh yeah...

**At the moment, sub-menus would only work, when invoked from the main menu...  Unfortunately, nested sub_menus are not yet implemented.**

In practice, invoking  sub_menu will look like this:

```bash

    enter_sub_menu $@ "Sub-menu Title"

```

You would place this line, to the main menu's function where you want to access it from. So for example if you wish to add a sub-menu to the `second tab`, `third menu-entry`, you would use this code in the `menu-bindings.la`:

```bash

    function tab2item3 {         enter_sub_menu $@ "My New Sub-menu"
    }

```

Then you would, of course, need to set up the menu entries for your new sub-menu, in the `menue-entries.la` file (see above), like this:

```bash

    _sub_menu32
    First sub-menu item :: Descriptor for first sub-menu item
    Second sub-menu item :: Descriptor for second sub-menu item
    Third sub-menu item :: Descriptor for third sub-menu item
    _endsub_menu32

```
  
This would make the sub-menu navigable with the proper names. To set up some simple commands for the sub-menu items, you would have to configure their aliases  like so:
  
``` bash

    function tab2item3sub1 {         ping -c 5 google.com
    }

    function tab2item3sub2 {         ping -c 15 google.com
    }

    function tab2item3sub3 {         ping -c 25 google.com
    }

```

Google would be very happy for your efforts... and now you'd also have a working sub-menu. Believe me, once you get the hang of it, it will be really easy. Still, it's probably easier to follow through in the config file, with the comments and examples preset there...


## **Using predefined scripts**

You will of course want to do more than just pinging google or localhost (although one can spend a considerable amount of time doing just that... or is that just me?) You will, most likely, have your scripts written and stored somewhere, and of course you can always just run them from wherever they are. If you do, however, feel compulsive about writing new ones just for scripting's sake, and prefer to keep them in **one place**, you can use the `$HOME/.config/LazyAdmin/user/user-functions.la` configuration file. Any bash function defined there can be referenced in the menu bindings just by invoking its name, which makes life just a little bit easier, doesn't it? (Yes, they are linked.)

In practice:

If put the following function into `user-functions.la`:

```bash

    function my_favurite_function{         clear
        echo
        echo "Hello world!"
        sleep 5
        clear
    }

```

you can bind it to any menu item in `menu-bindings.la`, liek so:

```bash

    # Bind my favourite function to Tab 3, Item 4
    function tab3item4 {     
        my_favourite_function
        
    }

```


## **Using the command builder**

Now that you've seen it all, comes the most difficult part: using the special sub-menu called command builder. The good news is, you will not need to define menu-entries for this one, it is all a one-liner command. The bad news is, it has its own syntax... To access this functionality, you will use the predefined function named `command_builder_function`. It will accept a number of arguments, each having their own specific functionality.

To learn how to use the command builder, check out the `Command builder usage guide` in the *Help* menu.


## **Defining defaults**


### *Changing user-defaults*

Another file you might want to know more about is`$HOME/.config/LazyAdmin/user/user-defaults.la`. here you can change some default values used throughout Lazy Admin. Most of the defaults are just fine use as they are. menu height is set to the maximum 11, this will comfortably hold 9 entries (with top and bottom padding). Sub-menu height is set to the maximum (11), line connectors are "on", etc.

In this file you can change the following variables:

- `MAIN_TITLE` - This is what it looks like. Please use double quotes when setting up your own title/
- `RIGHT_PANEL` - Defaults to `true`. If you change this value to `false`, the right panel will no longer be displayed (requires restart)
- `MAX_MENU_ITEMS` - Is the height of the main menu (how many items can be displaye on each tab). Minimum is 5, maximum is 9 fr now. Any number beyond these bounds will be ignored
- `MAX_SUBMENU_ITEMS` - is the height of the sub-menus, it similar to that of the main menu, but allows for soem flexibility by setting a separate value here
- `RIGHT_PANEL_WIDTH` - is the width of the right panel in characters. (No! Really?!). You only need change this if you decide to change those items
- `DISPLAY_LINE_CONNECTORS` - Defaults to `true`. The other possible value is  (you guessed it right): `false`. Line connectors are the little characters that make the 90° connections between lines. Turn it off if you experience drawing issues (like on mobile terminal emulators, or if your emulator does not use fixed width characters for some reason, etc.)
- `DEFAULT_EDITOR` - This will be automatically set, when you first attempt to edit config files from within Lazy Admin, but you can also change it manually any time.


### *Changing startup values*

You can change some startup defaults, by editing the `$HOME/.LazyAdmin/code/core-defaults.la` file (for single-ser installations), or `/opt/LayAdmin/code/core-defaults.la` for (system-wide installations).

**Editing this file is *NOT RECOMMENDED*! If you change anything other than the suggested values, things might break. Or worse. You have been warned.**

Currently, the following changes are safe to make:

- **Changing the startup tab** - Set the `tab_pos` valiable to the desired number. This value is zero-based, so the first tab will be `0`, second tab is `1`, etc. default is `0`.
- **Changing the startup item** - Set the `menu_pos` valiable to the desired number. This value is zero-based, so the first item will be `0`, second item is `1`, etc. Default is `0`.
- **Changing the active panel at startup** - If you set the `active_panel` variable to `"right"`, Lazy Admin will start with the right panel being active. Default is `"left"`.
  
  **Note: If you set any other value, yu will not be able to use either panel. This can be intentional, if you nwant to disable arrow key navigation *within* the tab, and only use number keys to select items, but you will still need to navigate th tabs with the arrow keys, at least for now.**
 
So that's about it. You can expect more rants to accompany later versions. 

You can find my email in the other file, if you have any questions...
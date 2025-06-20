# ***Lazy Admin Basic Menu Setup Guide v3.0***


*This file has been formatted to be viewed with lynx/pandoc on a Linux CLI. Your mileage may vary with other software.*

Lazy Admin offers a simple and straightforward way to configure your menus.

*Note: Starting from v3.0, the menu files uses a completely new, simplified format. None of the previous menu syntaxes are compatible, and the old methods have been discontinued.*


## **Changing menu entries**

All the menu-entries will be stored in the file `$HOME/.config/LazyAdmin/user/menu-entries.la`, (as you might have noticed, global installation is also available, in which case each user should have their own set of config files), or in case of the portable edition, in `<wherever you keep it>/LazyAdmin_3.0_portable/user/menu-entries.la` 

You can find the above file and edit it in any way you like, but for convenience's sake you can also access it from within Lazy Admin. Just navigate to the *Setup options* item of the right menu, or press `o` from anywhere on the main menu level, then select the first item. The file itself should have some useful comments about how to proceed, it will hopefully be self-explanatory for the most.

To have it all in once place, the structure of the menu file will be explained here as well.

The menu builder function parses the file looking for double colon (`::`) symbols on each line, this is the delimiter symbol for different part of each tab or menu item.

The menu file has two sections. One for tabs one for menu items


### Setting up tabs

`[:tab_order:]` and `[:end_tab_order:]` delimit the section for tabs.

Tab items need an ID and a displayed name, separated by the delimiter symbol, like so:

`Tab ID :: Tab name`

You can set both IDs and display names to whatever you like.

To set up five tabs, you would do something like

<br />

```bash
    [:tab_order:]

    Tab 1 :: First tab
    Tab 2 :: Second tab
    Tab 3 :: Third tab
    Tab 4 :: Fourth tab
    Tab 5 :: Fifth tab

    [:end_tab_order:]
```

<br />

This would result in the following tab layout:

<br />

```bash
    
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                          Lazy Admin - v3.0
    ━━━━━━━━━━━━┯━━━━━━━━━━━━┯━━━━━━━━━━━┯━━━━━━━━━━━━┯━━━━━━━━━━━━━
      First tab │ Second tab │ Third tab │ Fourth tab │  Fifth tab
    ━━━━━━━━━━━━┷━━━━━━━━━━━━┷━━━━━━━━━━━┷━━━━━━━━━━━━┷━━━━━━━━━━━━━
              
```

<br />


### Setting up menus

To define menu items, you must follow the pattern:

`Tab ID :: Menu item name :: Menu item description (footer) :: command_to_execute`

The menu item will be displayed on the *first* tab with a matching ID (so if you have more than one tab with the same ID, the rest will be always empty).

`Menu item name` will appear in the menus, and `Menu item description` will be displayed in the footer, if it's enabled.

Finally, the `command_to_execute` is the function name, alias or command to call when the item is selected.

Each menu item will be automatically numbered. Pressing he assigned number will select the menu item.

To expand on the above example:

<br />

```bash

    [:menu_items:]
    
    # ID  :: Displayed item name :: Description             :: Command or function
    Tab 1 :: First menu item     :: Description of 1st item :: dummy_function
    Tab 1 :: Second menu item    :: Description of 2nd item :: other_dummy_function
    Tab 1 :: Third menu item     :: Description of 3rd item :: /c /d /v top
    
    [:end_menu_items:]

```

<br />


will result in something like this:

<br />

```bash
    
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                          Lazy Admin - v3.0
    ━━━━━━━━━━━━┯━━━━━━━━━━━━┯━━━━━━━━━━━┯━━━━━━━━━━━━┯━━━━━━━━━━━━━
     *First tab*│ Second tab │ Third tab │ Fourth tab │  Fifth tab
    ━━━━━━━━━━━━┷━━━━━━━━━━━━┷━━━━━━━━━━━┷━━━━━━━━━━━━┷━━━━━━━━━━━━━
     
     *1 - First menu item*
      2 - Second menu item
      3 - Third menu item

    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 
      Description of 1st item
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

```

<br />


#### *Switches*

You might have noticed the three switches in front of the last item's command: `/c /d /v top`

This will, of course just run `top`, but the switches tell lazy Admin to do certain things:

- `/c` (clear) will clear the screen before running (not really necessary for `top`, but great for text based stuff)
- `/d` (delay) will prompt the user to press a key before returning o the menu, so that you can preserve the last output of the command
- `/v` (verify) will test if the command is a valid function name first, and try to find if the command represents an installed package, if no function name is found. If neither case is true, it will print an error message. This is useful when you are not sure if the specified item is available on the target system (e.g. when running Lazy Admin Portable from a USB drive)


And that is all you need to set up simple menus. For more available options, like sub-menus, and visual grouping, check out the `Advanced menu setup guide`
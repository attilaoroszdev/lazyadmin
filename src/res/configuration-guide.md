# ***Lazy Admin Details Configuration and Scripting Guide v3.0***


*This file has been formatted to be viewed with lynx/pandoc on a Linux CLI. Your mileage may vary with other software.*

**User beware, here there be dragons. You will have to know some basic bash before you can make modifications. It is also worth having a much better idea of bash script than I ever will, so you might as well add some useful modifications (let me know, if you have any). I have not yet implemented any user-friendly ways to change stuff. Proceed at your own risk, you may break something that was already of little use to start with...**


## **Changing menu entries**

*Note: Starting from v3.0, the menu files uses a completely new, simplified format. None of the previous menu syntaxes are compatible, and the old methods have been discontinued.*

All the menu-entries will be stored in the file `$HOME/.config/LazyAdmin/user/menu-entries.la`, (as you might have noticed, global installation is also available, in which case each user should have their own set of config files), or in case of the portable edition, in `<wherever you keep it>/LazyAdmin_3.0_portable/user/menu-entries.la` 

You can find the above file and edit it in any way you like, but for convenience's sake you can also access it from within Lazy Admin. Just navigate to the *Setup options* item of the right menu, or press `o` from anywhere on the main menu level, then select the first item. The file itself should have some useful comments about how to proceed, it will hopefully be self-explanatory for the most.

To have it all in once place, the structure of the menu file will be explained here as well.

The menu builder function parses the file looking for double colon (`::`) symbols on each line, this is the delimiter symbol for different part of each tab or menu item.

The menu file has two sections. ONe for tabs one for menu items

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

The menu item will be dispayed on the *first* tab with a matching ID (so if you have more than one tab with the same ID, the rest will be always empty).

`Menu item name` will appear in the menus, and `Menu item description` willbe dispayed in the footer, if it's enabled.

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

This will, of cours just run `top`, but the switches tell lazy Admin to do certain things:

- `/c` (clear) will clear the screen before running (not really necessary for `top`, but great for text based stuff)
- `/d` (delay) will prompt the user to press a key before returning o the menu, so that you cn preserve the last output of the command
- `/v` (verify) will test if the command is a valid function name first, and try to find if the command represents an installed package, if no function name is found. If neither case is true, it will prnt an error message. This is useful when you are not sure if the specified item is available on the target system (e.g. when running Lazy Admin Protable from a USB drive)

### Submenus

Each menu item can hold a submenu, which increases the menus' capacity almost exponentially

Unlike in previous versions, submenus will be defined in place. If you want a menu item to lead to a submenu, you should change its assigned command to the `enter_submenu` function. After the menu item that shouldh old a submenu, instead of the Tab ID, you shoudl open each line with `--`. These rows will become the submenu items. To expand on the previous example, the second item will now hold a submenu:


<br />

```bash

    [:menu_items:]
    
    # ID  :: Displayed item name :: Description             :: Command or function
    Tab 1 :: First menu item     :: Description of 1st item :: dummy_function
    Tab 1 :: Item with submenu   :: This leads to a submenu :: enter_submenu
       -- :: Submenu item 1      :: First submenu item      :: submenu_function_1
       -- :: Submenu item 2      :: Second submenu item     :: submenu_function_1
       -- :: Submenu item 3      :: Third submenu item      :: submenu_function_1
       -- :: Submenu item 4      :: Fourth submenu item     :: submenu_function_1
    Tab 1 :: Third menu item     :: Description of 3rd item :: /c /d /v top
    
    [:end_menu_items:]

```

<br />

When selecting the 2nd menu item, it will display its submenu:

<br />

```bash
    
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                   Lazy Admin - v3.0
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
              Submenu: Item with submenu
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
     
     *1 - Submenu item 1*
      2 - Submenu item 2
      3 - Submenu item 3
      4 - Submenu item 4

    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 
      First submenu item
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

```

<br />

### Special menu items (skip, delimiter and inline-label)

Special menu items tinclued empty lines, visual dividers and labels. These wil be skipped at navigation time and are mostly useful as visual aids to bbetter categorise or group menu items.

- To **skip one row**, put the Tab ID followed by the delimiter and nothing else:
  E.g. `Tab 1 ::` will add an empty row to the firs tab.
- To **draw a divider line**, add `---` as a menuj item to the specific tab, e.g.
  E.g. `Tab 1 :: ---` will draw a divider line in that position on tab 1.
- To **add a label**, just write an item name with ni description or command after the tab id,
  E.g. `Tab 1 :: Group label` will add the label "Group label" in the desired position

To expand the previous menu example;

<br />

```bash

    [:menu_items:]
    
    # ID  :: Displayed item name :: Description              :: Command or function
    Tab 1 :: Top group label
    Tab 1 ::
    Tab 1 :: First menu item     :: Description of 1st item  :: dummy_function
    Tab 1 :: Item with submenu   :: This leads to a submenu  :: enter_submenu
       -- :: Submenu item 1      :: First submenu item       :: submenu_function_1
       -- :: Submenu item 2      :: Second submenu item      :: submenu_function_1
       -- :: Submenu item 3      :: Third submenu item       :: submenu_function_1
       -- :: Submenu item 4      :: Fourth submenu item      :: submenu_function_1
    Tab 1 :: Third menu item     :: Description of 3rd item  :: /c /d /v top
    Tab 1 ::
    Tab 1 :: ---
    Tab 1 :: 
    Tab 1 :: Bottom group label
    Tab 1 ::
    Tab 1 :: Fourth menu item    :: This is just the 4th item :: dummy_funtion_number_4
    Tab 1 :: Fifth menu item     :: This is the 5th item      :: dummy_funtion_number_4

    [:end_menu_items:]

```

<br />

will be displayed like:

<br>

```bash
    
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                            Lazy Admin - v3.0
    ━━━━━━━━━━━━┯━━━━━━━━━━━━┯━━━━━━━━━━━┯━━━━━━━━━━━━┯━━━━━━━━━━━━━
     *First tab*│ Second tab │ Third tab │ Fourth tab │  Fifth tab
    ━━━━━━━━━━━━┷━━━━━━━━━━━━┷━━━━━━━━━━━┷━━━━━━━━━━━━┷━━━━━━━━━━━━━
      
      Top group label

      1 - First menu item 
      2 - Item with submenu
      3 - Third menu item

    -----------------------------------------------------------------

      Bottom group label

     *4 - Fourth item*
      5 - Fifth item

    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 
      This is just the 4th item
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


```

<br />

As you can see, the numnbering continues from the last regular menu item. There s no limit as to how many labels, skipped items or dividers you can put on the same tab. It might a good idea however to leave an empty row above and below divider lines and labels, for clarity's sake, unless you are very pressred for space (in wich case the grouping might be a watste of space anyway)

And that's all there is to menus, really...


## **Using predefined scripts**

You will of course want your menus ot do more than what fits on the inline definition in the menu file. You will, most likely, have your scripts written and stored somewhere, and of course you can always just run them from wherever they are, if you have hem on your path, or defined aliases, or provide full paths, etc. 

If you do, however, feel compulsive about writing new ones just for scripting's sake, and prefer to keep them in **one place**, you can use the `$HOME/.config/LazyAdmin/user/user-functions.la` configuration file (or in case of the portabl;e edition, the `<wherever you keep it>/LazyAdmin_3.0_portable/user/user-functions.la`). Any bash function defined there can be referenced in the menu bindings just by invoking its name, which makes life just a little bit easier, doesn't it? (Yes, they are alreeady linked.)

In practice:

If put the following function into `user-functions.la`:

<br />

```bash

    my_favurite_function(){         
        echo
        echo "Hello world!"
        echo
    }

```
<br />

you can bind it to any menu item like so

<br />

```bash

   Tab 2 :: Greet the universe! :: The world famous Hello World! :: /c /d my_favurite_function

```
<br />

Then the corresponding menu item will call you predefined function. he `/c` and `/d` swiches are optional, but can be useful. `/c` will clear the screen, and `/d` will prompt the user for keypress before returing to the menu, so that you can actually ee the output. (The third available option, `/v` would be not that useful here, since we are pretty sure we have just defined this functon.)

Your predefined functions can also take parameters just liek they normaly would, so, e.g.

<br />

```bash

    greet_anyone(){         
        echo
        echo "Hello $1!"
        echo
    }

```

<br />

could be called like:

<br />

```bash

   Tab 2 :: Greet Tom! :: The world famous Hello Tom! :: /c /d greet_anyone "Tom"

```

<br />

This would print: `Hello Tom!`

Quotes worlk as they normally would, so anything within quotes is considered as a single argument:

<br />

```bash

   Tab 2 :: Greet all the others! :: Sorry Tom, not you this time :: /c /d greet_anyone "everyone but Tom"

```

<br />

making this print: `Hello everyone but Tom!`, however hurtful this might bt to poor Tom.


## **Using the command builder**

Now that you've seen it all, comes the most special part: Using the special sub-menu called command builder. The good news is, you will not need to define menu-entries for this one, it is all a one-liner command. The bad news is, it has its own syntax... To access this functionality, you will use the predefined function named `command_builder_function`. It will accept a number of arguments, each having their own specific functionality.

To learn how to use the command builder, check out the `Command builder usage guide` in the *Help* menu.


## **Defining defaults**


### *Changing user-defaults*

Another file you might want to know more about is`$HOME/.config/LazyAdmin/user/user-defaults.la`. here you can change some default values used throughout Lazy Admin. Most of the defaults are just fine use as they are. menu height is set to the maximum 11, this will comfortably hold 9 entries (with top and bottom padding). Sub-menu height is set to the maximum (11), line connectors are "on", etc.

In this file you can change the following variables:

- `MAIN_TITLE` - This is what it looks like. Please use double quotes when setting up your own title/
- `MAX_MENU_ITEMS` - Is the height of the main menu (how many items can be displaye on each tab). Minimum is 5, maximum is 9 fr now. Any number beyond these bounds will be ignored
- `USE_STTY` - `stty` is porety standard across mst systms, and is used by LazyAdmin mainly to prevent printing artifacts, but it will alter your tty settings. While your original settings should be restored in case LazyAdmin quits or gets killed, you can turn this option off if you experience issues 
- `RIGHT_PANEL_WIDTH` - is the width of the right panel in characters. (No! Really?!). You only need change this if you decide to change those items
- `AUTO_REFLOW` - Defaults to `true`. It mnean that Lazy Admin will regularly ceck for window size changes and will redraw itself if it detects any
- `AUTO_REFLOW_TICK` - Defaults to `0.5` seconds. How often the size change checks should happen. Setting it any lower than the default might cause increased resource usage.
- `SHOW_HEADER` - Defaults to `true`. If you set it to `false`, the main title above the Tabs will not be drawn. Useful if you're pressed for space. Can be temporarily toggled on the fly be pressing `H` (`<Shift>` + `h`)
- `SHOW_FOOTER` - Defaults to `true`. If you set it to `false`, the footer bar with the descriptions below the menus will not be displayed (unless you are in the comman builder, which always has a footer.) Useful if you're pressed for space. Can be temporarily toggled on the fly be pressing `F` (`<Shift>` + `f`)
- `FOOTER_CONTENTS` - Defaults to `"description"`, which mean the footer (if enabled) will display the descriptions you set in the menus. Changing this to `"command"` will cause the footer to display the commands the menu item onvokes, instead. an be temporarily changed on the fly be pressing `I` (`<Shift>` + `I`)
- `RIGHT_PANEL` - Defaults to `true`. If you change this value to `false`, the right panel will no longer be displayed (requires restart)
- `DISPLAY_LINE_CONNECTORS` - Defaults to `true`. The other possible value is  (you guessed it right): `false`. Line connectors are the little characters that make the 90° connections between lines. Turn it off if you experience drawing issues (like on mobile terminal emulators, or if your emulator does not use fixed width characters for some reason, etc.)
- `DEFAULT_EDITOR` - This will be automatically set, when you first attempt to edit config files from within Lazy Admin, but you can also change it manually any time.


### *Changing startup values*

You can change some startup defaults, by editing the `$HOME/.LazyAdmin/code/core-defaults.la` file (for single-ser installations), or `/opt/LayAdmin/code/core-defaults.la` for (system-wide installations).

**Editing this file is *NOT RECOMMENDED*! If you change anything other than the suggested values, things might break. Or worse. You have been warned.**

Currently, the following changes are safe to make:

- **Changing the startup tab** - Set the `TAB_POS` valiable to the desired number. This value is zero-based, so the first tab will be `0`, second tab is `1`, etc. default is `0`.
- **Changing the startup item** - Set the `MENU_POS` valiable to the desired number. This value is zero-based, so the first item will be `0`, second item is `1`, etc. Default is `0`.
- **Changing the active panel at startup** - If you set the `active_panel` variable to `"right"`, Lazy Admin will start with the right panel being active. Default is `"left"`.
  
  **Note: If you set it to any other value, you will not be able to use either panel. This can be intentional, if you want to disable arrow key navigation and only use number keys to select items.**
 
So that's about it. You can expect more rants to accompany later versions.

You can find my email in the other file, if you have any questions...
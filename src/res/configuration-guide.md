# ***Lazy Admin Configuration and Scripting Guide v3.0***


*This file has been formatted to be viewed with lynx/pandoc on a Linux CLI. Your mileage may vary with other software.*

**User beware, here there be dragons. You will have to know some basic bash before you can make modifications. It is also worth having a much better idea of bash script than I ever will, so you might as well add some useful modifications (let me know, if you have any). I have not yet implemented any user-friendly ways to change stuff. Proceed at your own risk, you may break something that was already of little use to start with...**


## **Using predefined scripts**

You will of course want your menus ot do more than what fits on the inline definition in the menu file. You will, most likely, have your scripts written and stored somewhere, and of course you can always just run them from wherever they are, if you have hem on your path, or defined aliases, or provide full paths, etc. 

If you do, however, feel compulsive about writing new ones just for scripting's sake, and prefer to keep them in **one place**, you can use the `$HOME/.config/LazyAdmin/user/user-functions.la` configuration file (or in case of the portable edition, the `<wherever you keep it>/LazyAdmin_3.0_portable/user/user-functions.la`). Any bash function defined there can be referenced in the menu bindings just by invoking its name, which makes life just a little bit easier, doesn't it? (Yes, they are already linked.)

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

Then the corresponding menu item will call you predefined function. he `/c` and `/d` switches are optional, but can be useful. `/c` will clear the screen, and `/d` will prompt the user for keypress before returning to the menu, so that you can actually see the output. (The third available option, `/v` would be not that useful here, since we are pretty sure we have just defined this function.)

Your predefined functions can also take parameters just like they normally would, so, e.g.

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

Quotes work as they normally would, so anything within quotes is considered as a single argument:

<br />

```bash

   Tab 2 :: Greet all the others! :: Sorry Tom, not you this time :: /c /d greet_anyone "everyone but Tom"

```

<br />

making this print: `Hello everyone but Tom!`, however hurtful this might be to poor Tom.


## **Using the command builder**

Now that you've seen it all, comes the most special part: Using the special sub-menu called command builder. The good news is, you will not need to define menu-entries for this one, it is all a one-liner command. The bad news is, it has its own syntax... To access this functionality, you will use the predefined function named `cmb`. It will accept a number of arguments, each having their own specific functionality.

To learn how to use the command builder, check out the `Command builder usage guide` in the *Help* menu.


## **Defining defaults**


### *Changing user-defaults*

Another file you might want to know more about is`$HOME/.config/LazyAdmin/user/user-defaults.la`. here you can change some default values used throughout Lazy Admin. Most of the defaults are just fine use as they are. menu height is set to the maximum 11, this will comfortably hold 9 entries (with top and bottom padding). Sub-menu height is set to the maximum (11), line connectors are "on", etc.

In this file you can change the following variables:

- `MAIN_TITLE` - This is what it looks like. Please use double quotes when setting up your own title/
- `MAX_MENU_ITEMS` - Is the height of the main menu (how many items can be displayed on each tab). Minimum is 5, maximum is 9 fr now. Any number beyond these bounds will be ignored
- `USE_STTY` - `stty` is pretty standard across most systems, and is used by LazyAdmin mainly to prevent printing artifacts, but it will alter your `tty` settings. While your original settings should be restored in case LazyAdmin quits or gets killed, you can turn this option off if you experience issues 
- `RIGHT_PANEL_WIDTH` - is the width of the right panel in characters. (No! Really?!). You only need change this if you decide to change those items
- `AUTO_REFLOW` - Defaults to `true`. It means that Lazy Admin will regularly ceck for window size changes and will redraw itself if it detects any
- `AUTO_REFLOW_TICK` - Defaults to `0.5` seconds. How often the size change checks should happen. Setting it any lower than the default might cause increased resource usage.
- `SHOW_HEADER` - Defaults to `true`. If you set it to `false`, the main title above the Tabs will not be drawn. Useful if you're pressed for space. Can be temporarily toggled on the fly be pressing `H` (`<Shift>` + `h`)
- `SHOW_FOOTER` - Defaults to `true`. If you set it to `false`, the footer bar with the descriptions below the menus will not be displayed (unless you are in the command builder, which always has a footer.) Useful if you're pressed for space. Can be temporarily toggled on the fly be pressing `F` (`<Shift>` + `f`)
- `FOOTER_CONTENTS` - Defaults to `"description"`, which mean the footer (if enabled) will display the descriptions you set in the menus. Changing this to `"command"` will cause the footer to display the commands the menu item invokes, instead. Can be temporarily changed on the fly be pressing `I` (`<Shift>` + `i`)
- `RIGHT_PANEL` - Defaults to `true`. If you change this value to `false`, the right panel will no longer be displayed (requires restart)
- `DISPLAY_LINE_CONNECTORS` - Defaults to `true`. The other possible value is  (you guessed it right): `false`. Line connectors are the little characters that make the 90° connections between lines. Turn it off if you experience drawing issues (like on mobile terminal emulators, or if your emulator does not use fixed width characters for some reason, etc.)
- `USE_PANDOC` - Defaults to `true`. If both `pandoc` and `lynx` are installed on the system,the Markdown formatted Help articles will be displayed when selected. If either of these dependencies are missing, or `USE_PANDOC` is set to `false`, a plain text version will be shown. Toggle this temporarily by pressing `P` (`<Shift>)` + `p`)
- `DEFAULT_EDITOR` - This will be automatically set, when you first attempt to edit config files from within Lazy Admin, but you can also change it manually any time.


### *Changing startup values*

You can change some startup defaults, by editing the `$HOME/.LazyAdmin/code/core-defaults.la` file (for single-user installations), or `/opt/LayAdmin/code/core-defaults.la` for (system-wide installations).

**Editing this file is *NOT RECOMMENDED*! If you change anything other than the suggested values, things might break. Or worse. You have been warned.**

Currently, the following changes are safe to make:

- **Changing the startup tab** - Set the `TAB_POS` variable to the desired number. This value is zero-based, so the first tab will be `0`, second tab is `1`, etc. default is `0`.
- **Changing the startup item** - Set the `MENU_POS` variable to the desired number. This value is zero-based, so the first item will be `0`, second item is `1`, etc. Default is `0`.
- **Changing the active panel at startup** - If you set the `active_panel` variable to `"right"`, Lazy Admin will start with the right panel being active. Default is `"left"`.
  
  **Note: If you set it to any other value, you will not be able to use either panel. This can be intentional, if you want to disable arrow key navigation and only use number keys to select items.**
 
 
So that's about it. You can expect more rants to accompany later versions.

You can find my email in the other file, if you have any questions...
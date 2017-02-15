<!-- Copyright (c)  2017 Attila Orosz-->
<!-- Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License, Version 1.3
or any later version published by the Free Software Foundation;
with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
A copy of the license is included in the section entitled "GNU
Free Documentation License". -->


# Lazy Admin Customization and Scripting

User beware, here there be dragons. You'll have to know some basic bash before you can make modifications. It is also worth having a much better idea of bash script than I ever will, so you might as well add some useful modifications (let me know, if you have any). I have not yet implemented any user-friendly way to change stuff. Proceed at your own risk, you may brake something that was already of little use to start with...


## **Changing menu entries**

All the menu-entries will be stored in the file `$HOME/.configLazyAdmin/user/menu-entries.la`. (As you might have noticed, global installation is also available, in which case each use should have their own set of config files). You find the above file and edit it in any way you like, but for convenience's sake you can also access it from within Lazy Admin. Just navigate to the *Setup* tab of the main menu, or press `e` from anywhere on the main menu level. The file itself should have some useful comments abut how to proceed, it will hopefully be self-explanatory for the most.

To have it all in once place, the structure of the menu file will be explained here as well. The menu builder function parses the file looking for an underscore (`_`) symbol. This is the delimiter for the start and end of sections.

There will be five kinds of sections:

| <br />

* `_menutab` ending with `_endmenutab` and hold the names of the top-row tabs, each on its own line

| <br />

* `_menu` and `_endmenu` are be for the main menu entries

| <br />

* `_submenu` and `_endsubmenu` will hold the submenu entries

| <br />

* `_descmenu` and `_enddescmenu` mean the beginning and end of the one liner descriptor of main menu entries

| <br />

* `_descsubmenu` and `_enddescsubmenu` mark the descriptor lines of sub-menus


To know, which menu is which, numbers will be used, starting with zero

| <br />

* For menu-entries the number will mark the tab position. This means that between `_menu0` and _`endmenu0` are all the menu entries of the first tab, `_menu1` and `_endmenu1` mark the second tab, etc. (This is the reason the maximum number of tabs is 10)

| <br />

* For sub-menu entries two numbers will mark the tab position and the menu position (these are two single digits written together. This is the reason the maximum number of menu entries is 9.) For example between `_submenu00` and `_endsubmenu00` you will find submenu entries for the first tab, first menuitem (`tab 0`, `item 0`), while e.g. `_submenu21` and `_endsubmenu21` mark the boundaries for the sub-menu items of third tab, second menuitem (`tab 2`, `item 1`), etc.

| <br />

* Descriptors follow a similar pattern: `_descmenu0` will correspond with `_menu0`, holding their descriptors, while `_descsubmenu21` will hold descriptors of `_submenu21`


The menu entries should be on their own line. Each new line means a new menu entry. To have a descriptor line correspond with a menu entry, place it on the same position. Consider the following example:

| `menu3`
| `First menuitem on the fourth tab`
| `Second menuitem on the fourth tab`
| `skip`
| `Fourth menuitem on the fourth tab`
| `_endmenu3`
|
| `descmenu3`
| `Descriptor line for first menuitem on the fourth tab`
| `Descriptor line for second menuitem on the fourth tab`
| `skip`
| `Descriptor line for fourth menuitem on the fourth tab`
| `_enddescmenu3`

There is one reserved word: `skip`. This will mark  them menu line to be skipped. Nothing will be printed on that line. This makes sense if you want to visually separate some items from others. Note that `skip` is not necessary in the descriptors, but it is better to keep it there, just to avoid confusion.

Similarly, to add a sub-menu, to the second item of the above menu, you would put in the menu file:

| `_submenu31`
| `First sub-menu item`
| `Second sub-menu item`
| `Third sub-menu item`
| `_endsubmenu31`

Here the numbers show tab **and** main-menu item numbers.
Sub-menu descriptors corresponding, will look like:

| `_descsubmenu31`
| `First sub-menu item description`
| `Second sub-menu item description`
| `Third sub-menu item description`
| `_enddescsubmenu31`


And that's it. All of it. Of course the right panel menu-items are described there too, but you would not be changing this, unless you change right panel functionality. If you can do that, I am sure you can decipher those menus too, and find your way through the comments. (It is the same self evident.)


## **Adding functionality to your menu items**

To bind functions to menus, Lazy Admin uses numbered function aliases, where the numbers that are very similar to to the numbers used with of the menu entries. The file `$HOME/.config/LazyAdmin/user/function-aliases.la` will hold all the user's defined aliases. There are two types of function calls (There are more, but for basics, two is enough): `functXX` and `subfunctXXX`.

The `functXX` functions correspond to menu entries on the main menu level. These functions will need two numbers: tab-position and menu-entry-position. Again, the numbering starts with zero, so the first entry of the first tab will be `00`, while the third entry of the second tab will be `12` (as in `tab 1`, `item 2`).

Some further examples:

| <br />

* `funct00` means the first (main) menu-entry on the first tab (`tab 0`, `item 0`)

| <br />

* `funct01` menas the second menu-entry on the first tab (`tab 0`, `item 1`)

| <br />

* `funct10` means the first menu-entry on he second tab (`tab 1`, `item 0`)

| <br />

* `funct11` means the second menu-entry on the second tab (`tab 1`, `item 1`)

...and so on.

For sub-menus, there is an additional number for sub-menu entry, making the `subfunctXXX` takes three numbers to be identifiable. The first sub-menu entry on the first menu entry of the first tab will be `subfuncts000` (`tab 0`, `menu 0`, `submenu 0`), while the second submenu entry on the third menu of the second tab would be `subfuncts121` (tab1, meny2, submenu1).

Some examples:

| <br />


* `subfunct000` means first tab, first menu entry, first sub-menu entry (`tab 0`, `menu 0`, `submenu 0`)

| <br />

* `subfunct001` means first tab, first menu entry, second sub-menu entry (`tab 0`, `menu 0`, `submenu 0`)

| <br />

* `subfunct010` means first tab, second menu entry, first sub-menu entry (`tab 0`, `menu 1`, `submenu 0`)

| <br />

* `subfunct011` means first tab, second menu entry, second sub-menu entry (`tab 0`, `menu 1`, `submenu 0`)

| <br />

* `subfunct100` means second tab, second menu entry, first sub-menu entry (`tab 1`, `menu 0`, `submenu 0`)

| <br />

* `subfunct101` means second tab, second menu entry, second sub-menu entry (`tab 1`, `menu 0`, `submenu 1`)

| <br />

* `subfunct111` means second tab, second menu entry, second sub-menu entry (`tab 1`, `menu 1`, `submenu 1`)

| <br />

* `subfunct231` means third tab, fourth menu entry, second sub-menu entry (`tab 2`, `menu 3`, `submenu 1`)


...and so on

So to bind a command to a menu item, you must invoke it from the function corresponding the menu item1s position. For example to put `ping localhost` to ping the hell out of your machine when you select the second tab's third function, you'd do the following

| `function funct12 {`
|
|     `ping localhost`
|
| `}`

To do the same from the fourth submenu of the fifth menu on the third tab, you'd go like

| `function subfunct243 {`
|
|     `ping localhost`
|
| `}`

Simple as that.

### *Invoking a sub-menu*

Binding commands to submenu items is all very well, but how will Lazy Admin know where to find submenus? It's nice to have function aliases for them, but what if you want to use them later? Or just "park them"? After all, having a function defined does not mean the function will be used.

For this (and some more practical) reason(s), you will need to specifically mark a menu item that you want to hold a submenu, in its function alias. The built-in function to achieve this is called `enter_submenu`. This function will take two arguments. The first one must always be `$@` (basically passing on tab and menu position)`, and the second argument will be the title of the submenu to be displayed. because in lazy Admin, you name your own submenus. Oh yeah...

There is one catch. At the moment, submenus would only (correctly) work, when invoked form the main menu... To do that, you would call:

`enter_submenu $@ "Sub-menu Title"`

from the function alias corresponding to the main menu item, you want the submenu to be associated with. So for example if you wish to add a sub-menu to the second tab third menu-entry, you would put this code to the function alias:

| `function funct12 {`
|
|    `enter_submenu $@ "My New Sub-menu"`
|
| `}`

Then you would also need to set up the menu entries for your new sub-menu, in the menu names file (see above), like this:

| `_submenu12`
| `First sub-menu item`
| `Second sub-menu item`
| `Third sub-menu item`
| `_endsubmenu21`
|
| `_descsubmenu12`
| `Descriptor for first sub-menu item`
| `Descriptor for second sub-menu item`
| `Descriptor for third sub-menu item`
| `_enddescsubmenu12`


This would make the sub-menu navigable with the proper names. To set up some simple commands for the submenu items, you would have to configure their aliases

| `subfunct120 {`
|
|     `ping -c 5 google.com`
|
| `}`
|
| `subfunct121 {`
|
|     `ping -c 15 google.com`
|
| `}`
|
| `subfunct122 {`
|
|     `ping -c 25 google.com`
|
| `}`

Google would be happy about your efforts... and now you'd also have a working sub-menu. Although I'm not sure it was worth the effort... but believe me, once you get the hang of it, it will be really easy. Still, it1s probably easier to follow through in the config file, with the comments and examples preset there

## **Using predefined scripts**

You will of course want to do more than just pinging google or localhost (although one can spend a considerable amount of time doing just that... or is that juts me?) You will, most likely have your scripts written and stored somewhere, and of course you can always just run them form wherever they are. if you do, however feel compulsive about writing new ones just for scripting's sake, and prefer to keep them in one place, you can use the `$HOME/.config/LazyAdmin/user/user-functions.la` configuration file. Any bash function defined there can be referenced in the function aliases. makes life just a little bit easier, dosn't it?

## **Using the command builder**

Now that you've seen it all, comes the difficult part: using the special sub-menu called command builder. The good news is, you will not need to define menu-entries for this one, it is all in the line of invoking function. The bad news is, it has its own syntax... To access this functionality, you will use the predefined function named `command_builder_function`. It will accept a number of arguments, each having their own specific functionality:

| <br />

* **The first argument**, placed inside double quotes, will mark the name of the sub-menu. (It is worth putting the name of the command there, for clarity's sake.)

| <br />

* **The second argument** will be the command itself. It can be a bash command, or your own function, that you have defined in n-user-functions, it can also include some preset flags or arguments. If it is more than one word, you'll need to put it in double quotes, again.

| <br />

* **From the third to the eleventh arguments** you will basically set the flags for your command, which you want to use as submenu items, to be used with the builder. You can use compound arguments, or multiple flags, anything in double quotes goes on one line. The maximum number of "settable" lines is 9.

For example, to invoke a ping command, with the optional flags `-v -c` and `-n`, you would do:

`command_builder_function "Ping with flags" ping -v -c -n`

which would result in a flags submenu offering the options:

| `1 - Set arg. -v`
| `2 - Set arg. -c`
| `3 - Set arg. -n`

If you were to use some other function that you've written yourself, you would use

`command_builder_function "Your function name" my_user_function -f -c --any_other_arg --yet_another_arg "--compound_arg X Y Z" --last_arg`

in the exact same way, you'd declared in the function itself. This would result in sub-menu options:

| `1 - Set arg. -f`
| `2 - Set arg. -c`
| `3 - Set arg. --any_other_arg`
| `4 - Set arg. --yet_another_arg`
| `5 - Set arg. --compound_arg X Y Z`
| `6 - Set arg. --last_arg`

Life-like(?) Example: You want to place a ping command, with the flags `-v -c -f, -n` and `--help` to the second menu-item on the fourth tab. You would use the `funct31` function alias, like this:

| `function funct31 {`
|
|    `command_builder_function "Ping with flags" ping -v -c -f -n --help`
|
| `}`

which would result in a submenu offering to execute `ping` with the below options:

| `1 - Set arg. -v`
| `2 - Set arg. -c`
| `3 - Set arg. -f`
| `4 - Set arg. -n`
| `5 - Set arg. --help`

..and that's it. You will also have other functionality, like manually adding flags, automatically added. Numbers for short-keys are also automatically added. Please be aware, that short-keys only work from 1 to 9, so any more than 9 flag entries will simply be ignored.

I hope this makes sense...

## **Defining defaults**

The last file you need to concern yourself about is `$HOME/.config/LazyAdmin/user/user-functions.la`. here you can change some default values used throughout Lazy Admin. Most of the defaults are sort of "OK" to use as they are. menu height is set to 7, this will comfortably hold 5 entries (with top and bottom paddings). Submenu height is set to the maximum (11), line connectors are "on", etc.

In this file you can change the following variables:

| <br />

* `maintitle` - is what it looks like. please use double quotes

| <br />

* `normalmenuheight` - is the height of the main menu

| <br />

* `submenuheight` - is the height of the sub-menus

| <br />

* `rightpanelwidth` - is the width of the right panel (really!). Change this if you change those items

| <br />

* `defaulteditor` - this will be automatically set, when you first attempt to edit config files from within Lazy Admin. You can change it manually any time.

| <br />

* `displaylineconnectors` - Defaults to true. Other possible value is, you guessed it.... "false". Line connectors are the little characters that make the 90° connections between lines. Turn it off if you experience drawing issues (like on mobile terminal emuélators, or if your emulator does not use fixed width characters, etc.)

That's about it. You can expect more rants to accompany later versions. You can find my email in th3e other file, if you have any questions...

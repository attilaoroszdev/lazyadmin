# ***Lazy Admin User Guide v3.0***

*This file has been formatted to be viewed with lynx/pandoc on a Linux CLI. Your mileage may vary with other software.*


## **Overview**

The basic functionality of Lazy Admin is to provide a pseudo graphical UI, one that can be navigated by the arrow keys, or with keyboard shortcuts, to hold script or command aliases on an easily navigable, tabbed menu-like interface. All without the need of external libraries, or tools, not even using `ncurses`.  (Not that I have anything against `ncurses`.)

Lazy Admin started as a proof of concept, but eventually grew into a quite featureful, and useful little tool. If you are a lazy sysadmin, who is tired of typing long commands and cannot remember the aliases he set (it must come with age), you might even find it handy. Maybe you need to manage a headless server with extremely limited capacities. Or something.

The biggest advantage of Lazy Admin over... well, probably over a graphical interface, is that it uses almost no external libraries at all. The whole thing runs as a `bash` script, occasionally trying to use `stty` or `tput`, but only if available. Any functions that might use other packages are carefully separated as plugins, making the core (hopefully) compatible with almost anything dating back the last 15 or so years.

The "Bourne Again SHell" or bash for short, has been around since 1989, and version 4, which is the version Lazy Admin needs to run dates back to 2009. This provides a rare continuity in today's throwaway-library focused environment. LazyAdmin 1.0 came out 7 years before this document was written, and it still working flawlessly. The only reason for the new version was wanting to clean up the code and getting carried away while implementing new features. By using bash and nothing but bash, Lazy Admin aim to remain compatible and long-lasting, without needing much (or any) maintenance, in a true configure once, and forget fashion.

Again, if you are a sysadmin, who does a lot of remote server maintenance, you will find that Lazy Admin runs super fast over SSH. Because there is noting fancy to run, really.


## **Capacity**

Since version 3,.0 the menu capacities of Lazy Admin have been extended drastically. When the maximum capacity is not specified, each tab can hold up to 99 items. IF you use sub-menus, these can also have 99 items each, making it `99x99=9801` items per tab. Currently, LazyAdmin supports up to 9 tabs, so the total capacity is `99x99x9=88209`. In theory, of course. You would need a rather large terminal window to display all those items.

In practice, the capacity limit is 9  tabs and between maybe 40-70 items in your usual terminal emulator. Currently, in KDE, Konsole, I get 44 items, and xterm gives me 68. When I log in without a desktop on tty, I get maximum 59 entries in a standard 1920x1080 laptop on Debian stable. So the approximate practical limit is currently between `44x44x9=17424` and `68x68x9=41616`, both of which are quite **a lot**.

Obviously, you will never need that many menu items, so Lazy Admin will, in practice, be of unlimited capacity.

In **more practical terms**, on a standard sizes 24x80 terminal, you can comfortably fit 6 or 7 tabs, with 12 items each with both header and footer enabled, or 16 with both disabled, with 12 (or 16) submenu items in each.

So, calculating with 6 tabs, you can have `6x12x16=846` items if you want to keep the header and the footer, or `6x16x16=1536` possible items when you disable them, which is still quite a lot of options.


## **Command line arguments**

Lazy Admin can be started by either typing `ladmin` as a command, or for the portable version by navigating to its folder and launching it with either `bash pladmin` or `./pladmin`.

Lazy Admin currently takes two command line arguments:

- `--join-lines` or `-j`
- `--load-profile` or `-p`


### `--join-lines`, or `-j`

`--join-lines` or `-j` for short, can override the default setting of the `$DISPLAY_LINE_CONNECTORS` variable. This is useful when accessing Lazy Admin via e.g. SSH, and the device used does not display Lazy Admin correctly. This can happen when using a terminal emulator on Android devices, which often do not use proper monospace font.

- `ladmin --join-lines off` or `ladmin -j off` will start Lazy Admin without drawing line-joints, so that no misalignment occurs with non-monospace fonts
- `ladmin --join-lines on` or `ladmin -j on`will force drawing line-joints, even when Lazy Admin is set not to draw them


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

- Up:                        `↑` (up arrow) or `w`
- Down:                      `↓`  (down arrow) or `s`
- Left (change tab):         `←` (left arrow) or `a`
- Right (change tab):        `→` (right arrow) or `d`
- Select tab:                `F1` – `F9` ot `t 1` – `t 9`
- Change to right panel:     `Ctrl` + `→ or r`
- Change to left panel:      `Ctrl` + `←` or `l`
- Change to the other panel: `Tab`
- Back to previous level:    `b`
- Select menu item:          `1` to `9` or `<Enter>`

**Note: You can directly select tabs, by pressing the `F` key correponding to the tab number, so e.g. you to select the second tab, press `F2`. Alternatively, press t, followed by the number of the tab, so to select the second tab, you would press `t`, immediately followed by `2`.**


## **Menu structure and item numbering**

Menus are stored in the `menu-entries.la` file. The easiest way to edit this is from withing Lazy Admin. Just press `o` in any top-level tab, or select `Setup options` form the right panel, then choose `Edit menu entries` or press `1`. If this is the first time you've done that, you will be prompted to pick your preferred editor (Your choice will be saved and automatically used later.)

Once there, you can specify the tabs and menu items. To learn more about how the menu file is structured, refer to the `Basic menu setup guide` and optionally the `Advanced menu setup guide`


## **Resizing the window**

Since version 3.0, Lazy Admin will automatically resize to follow the window size, and the menu height will always expand to the maximum available capacity (unless you explicitly limit it).

This auto-reflow functionality can be turned off for systems with extremely low resources. If auto-reflow is turned off, Lazy Admin will sit idle, consuming virtually no resources (no more than a bash read statement), unless you are actively navigating. With auto-reflow on, Lazy Admin will check for size changes at a 0.5 second interval, while results in small CPU time consumption even at idle. (This can be set higher for more latency, but lower CPU usage.)

When either specified menus or tabs don't fit the current window size, visual warnings will be displayed.


## **The Right Panel**

Lazy Admin comes with an optional right panel (turned on by default, that offers various system-wide options.

- **Reflow menu:**  When automatic resizing is turned off, or something just does not look right for any reason, reflowing the menu will redraw the while interface
- **Get help:** Selecting this will bring you to the help menu, as it probably already has, since you are reading this, or display the command builder specific help file, when you are in a command builder menu (more on that later)
- **Show key bindings:** A quick cheat sheet to show the shortkeys and what they do
- **Setup options:** Only displayed in the top level menus, this will open the Setup menu, where you can edit various settings files
- **Back to Main menu:** Only displayed in submenus, and Help and Options menus, this will bring you back to the top level
- **Quit:** Gracefully quit lazy Admin and restore the terminal to to its original state


## **Hotkeys**

All right panel items also have hotkeys assigned, so you don't have to navigate to them to access them. These are:

- Reflow menu:           `f`
- Get help:              `h`
- Display shortkeys:     `k`
- Got to setup options: `o`
- Back to Main Menu:     `b`
- Quit Lazy Admin:       `q`

Other shortkeys can be used to temporarily override settings. The following options can be toggled on or off with CAPITAL keys (`<Shift>` + key):

- Turn right panel on / off:                `R`
- Turn header (title) on /off:              `H`
- Turn footer (descriptions) on / off:      `F`
- Toggle footer contents (desc. / command): `I`
- Turn line connectors on / off:            `L`
- Turn use `pandoc` for help on / off:      `P`


## **Command builder**

There is a special, visual command builder function built right into Lazy Admin, called the command builder. You can bind this interface to any menu or sub-menu item, and it will bring up a special type of sub-menu, allowing you to visually build long commands with preset flags, arguments, or sets of flags/arguments. To access this functionality, you need to bind `cmb` with the right arguments to the menu or sub-menu item you wish to invoke the command builder with.

The `Command builder guide` has detailed instructions for how to use the command builder in your menus.


## **Bottom row**

At the bottom of the UI, there is a special row, which displays either a short one liner description of the currently highlighted menu item, or the command assigned to this item. The descriptions must be set at the same time menu items are set up, and are available for menu and sub-menu items, and right panel items, but *not* for the command builder.

You can change what gets displayed in the `user-defaults.la` file, or temporarily toggle between the two modes by pressing `I` (`<Shift`> + `i`)


## **The End**

That is all for now. I hope you find it useless, but fun to use.

I do.

If you want to know more about how to set up menus, and bind functions etc, head over to the next item in the help menu.

If you have any suggestions, or know something better, spotted an error, or just want to tell me that I'm an idiot for spending my time like this, just email me at:

[attila.orosz.dev@gmail.com](mailto:attila.orosz.dev@gmail.com)

Enjoy. :)

[![GitHub top language](https://img.shields.io/github/languages/top/attilaoroszdev/lazyadmin)](https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html)
[![GitHub contributors](https://img.shields.io/github/contributors/attilaoroszdev/lazyadmin)](https://github.com/attilaoroszdev/lazyadmin/graphs/contributors)
[![GitHub issues](https://img.shields.io/github/issues/attilaoroszdev/lazyadmin)](https://github.com/attilaoroszdev/lazyadmin/issues)
[![GitHub License](https://img.shields.io/github/license/attilaoroszdev/lazyadmin)](https://github.com/attilaoroszdev/lazyadmin/blob/main/LICENSE)
[![GitHub release (with filter)](https://img.shields.io/github/v/release/attilaoroszdev/lazyadmin)](https://github.com/attilaoroszdev/lazyadmin/releases)

# Lazy Admin - A pure bash cli menu system

Lazy Admin will draw a pseudo graphical menu on your terminal, or terminal emulator, using nothing but `bash`. It is extremely lightweight, portable and future-proof. The only dependency is `bash` 4 (and `tar` to access the files for the first time.) NO fancy libraries, no missing dependencies. The original 8 year old code base runs today as well as it did on day 1.


## Why Lazy Admin?

You can think of Lazy Admin as **aliases on steroids**. Instead of remembering and typing out long commands, weird script names, and all their parameters, you can store the on a conveniently navigable tabbed menu-like interface with lots of little bells and whistles, but without any strain on you environment. You can run this on a toaster. An *analogue* toaster.


## What does it do?

- **Arrow-key navigation** - Arrow keys do what you expect them to do.
- **List-like menu items** - Each menu item is accessible through navigating a vertical list of items, organized neatly on tabs.
- **Tabs for grouping similar items** - Left/Right arrows will switch tabs.
- **One liner item descriptions** - When you navigate the menu, a description appears in the bottom row.
- **Shortkeys** - Each item is accessible by pressing its corresponding number on the current tab. E.g. to launch the 13th item, press <kbd>1</kbd> <kbd>3</kbd>, to change to the third tab, press <kbd>F3</kbd>, or <kbd>t</kbd> <kbd>3</kbd>
- **Sub-menus** - Any menu-item can invoke a sub-menu, which can hold further items.
- **Visual command builder with predefined parameters** - Build long commands in an interactive way.
- **Optional side panel** - With predefined items like *Reflow menu*, *Help*, *Key Bindings*, *Back to main* and *Exit*, which can also hold user defined items. Ideal for holding menu items that might apply to all tabs.
- **No dependencies "pure" bash interface** - Ideal for managing servers via `ssh`. The only dependency is `bash` 4.
- **Easy set-up** - The installer script is completely platform independent. Settings can be changed by editing simple text files, from within the UI. Script aliases bind scripts to menu items by position, and a user script "repository" file is also available. 
- **No-intstallation, portable version also abvailable** - Run it any time, anywhere, on any systrem that has `bash` 4 installed
- **Multiple profiles** - Store different sets of menu items to use in different situations, and load them easily.


## Screenshots

They say that a picture is worth a thousand words. So here's Lazy Admin in 8000 words:

<br />

![Lazy Admin](/media/lazy-admin-3-1.png "Lazy Admin in a standard 24x80 terminal window")

*Lazy Admin in a standard 24x80 terminal window*

<br />

![Section labels and dividers](/media/lazy-admin-3-2.png "Section labels and dividers help with visual grouping")

*Section labels and dividers help with visual grouping*

<br />

![Submenus](/media/lazy-admin-3-3.png "Submenus can extend the total capacity imensely")

*Submenus can extend the total capacity imensely*

<br />

![The command builder](/media/lazy-admin-3-4.png "The interactive command builder gives you more flexibility")

*The interactive command builder gives you more flexibility*

<br />

![Righ panel navigation](/media/lazy-admin-3-5.png "You can navigate the right panel just like the menus")

*You can navigate the right panel just like the menus*

<br />

![Help menu](/media/lazy-admin-3-6.png "Detailed documentation is included in the help menu")

*Detailed documentation is included in the help menu*

<br />

![Minimal interface](/media/lazy-admin-3-7.png "Interface elements can be turned off on-demand")

*Interface elements can be turned off on-demand*

<br />

![Small window](/media/lazy-admin-3-8.png "If the terminal (window) is too small, you get visual warnings")

*If the terminal (window) is too small, you get visual warnings*

<br />

### Yeak ok, but why *Lazy* Admin?

Because it's meant for sysadmins, who are lazy. Lazy to type, lazy to remember, etc.


### Does it make sense?

Probably not a lot, but it's fun. Although if you have mundane and/or repetative tasks to run on remote servers via `ssh`, it can be rather helpful.


## What are the different "editions"?

Lazy admins comes in four flavours:

- **Full** - The whole package, complete with sample data and an installer script
- **Portable** - Same as the full version, only without an installer (or the need to install).

(*Note: The minimal edition has been discontinued in v2.2, but it might just reappear in a later release*)


### Why portable?

The portable edition has all the advantages of not needing installation. You can stick it on a pendrive and it will work on any computer that has a working `bash` shell. The disadvantage is, your user preferences and preset values will not be transferred to any new version, whereas the full edition has the option to preserve user data while upgrading. (It's easy enough to copy them, though.)

### What's with those profiles, then?

The default user data (your menu items, and predefined functions) will be stored in the `/user` directory (located in `~/.config/LazyAdmin` for permanent installations). You can duplicte the contents of that folder into a different one, and then load it with either 

```bash
ladmin -p <profile_name>
```

or 

```bash
ladmin --load-profile <profile_name>
```

where `<profile_name>` is the name of the folder your other profiles is saved.

***Note:** Both relative and paths are supported for non-standard profile locations. If the profile is located next to the "default" one, it is quite enough to specify the folder name*

For example:

```bash
ladmin --load-profile seconduser
```

or

```bash
ladmin -p seconduser
```

will attempt to load the contents of `~/.config/LazyAdmin/seconduser`. To load the user's profile from e.g. the non-standard location: `~/LAProfiles/seconduser`, you can either specify the absolute path:

```bash
ladmin --load-profile ~/LaProfiles/seconduser
``` 

or

```bash
ladmin -p ~/LaProfiles/seconduser
```

or use a relative path, such as:

```bash
ladmin --load-profile ../../LaProfiles/seconduser
```

or

```bash
ladmin -p ../../LaProfiles/seconduser
```


## Installing Lazy Admin

Installation is pretty straightforward. Download the latest release, and unpack the tarball. It should either contain an `install.bash` script, or a ready to go launcher (`pladmin.bash` in the portable variety). If you go the installer way, there should also be another another tarball, corresponding to the release's version number. Keep these in the same directory and run the script. There are a few options to choose form, but these will be explained as you go along.


### Upgrading from a previous version

If you already have Lazy Admin installed, and want to upgrade, you can just run the installer as you normally would. It will ask you if you want to purge your previous user configurations. If you say no, you will keep them and the new version will automatically use your defined menus and functions. If you say yes, it will still keep the old configs, in case you'd change your mind later on.


## So how can I configure it?

For a detailed guide of configuration and usage, you can refer to the help files within the package, accessible directly via the help menu in either MarkDown or plain text format, or you can read them with any text/markdown editor straight from the `res` folder, on the install path.

To access the help menu, either navigate to the right panel by pressing the <kbd>TAB</kbd> key, <kbd>r</kbd> or <kbd>Ctrl</kbd> + <kbd>➜</kbd>, and select *Get Help*, or just press <kbd>h</kbd> from anywhere inside Lazy Admin.


And that is all for now. I hope you'll enjoy this little project. Any feedback, bug reports, pull requests are most welcome. :)

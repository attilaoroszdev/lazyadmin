# Lazy Admin - a bash cli menu system.

**Note: The last releases (1.0 and 2.0) are currently incompatible with bash 4.4. the dev branch already has he fixes, but until the next release, you can just update the flies `menu-function.la.` or `menu-functions-min.la` from the dev branch to "unbreak" things quickly**


Lazy Admin will draw a pseudo graphical menu on your terminal, or terminal emulator, using nothing but `bash`, and `sed`.

## Why Lazy Admin?

You can think of Lazy Admin as aliases on steroids. Instead of remembering  and typing out long commands, weird script names, and all their parameters, you can store the on a conveniently navigable tabbed menu-like interface.

## What does it do?

* **Arrow-key navigation** - Arrow keys do what you expect them to do
* **List-like menu items** - Each menu item is accessible through navigating a vertical list of items, organized neatly on tabs
* **Tabs for grouping similar items** - Left/Right arrows will switch tabs
* **One liner item descriptions** - When you navigate the menu, a description appears in the bottom row
* **Shortkeys** - Each item is accessible by pressing its corresponding number on the current tab. E.g. to launch the 3rd item, press 3.
* **Sub-menus** - Any menu-item can invoke a sub-menu, which can hold further items
* **Visual command builder with predefined parameters** - Build long commands in an interactive way.
* **Optional side panel** - with predefined items like *Reflow menu*, *Help*, *Key Bindings*, *Back to main* and *Exit*, which can also hold user defined items. Ideal for holding menu items that might apply to all tabs.
* **No dependencies "pure" bash interface** - ideal for managing servers via SSH.
* **Easy set-up** - The installer script is completely platform independent. Settings can be changed by editing simple text files, from within the UI. Script aliases bind scripts to menu items by position, and a user script "repository" file is also available.

## Screenshots

They say that a picture is worth a thousand words. So here's Lazy Admin in 6000 words:

![](/media/lazy-admin-1.png)

![](/media/lazy-admin-2.png)

![](/media/lazy-admin-3.png)

![](/media/lazy-admin-4.png)

![](/media/lazy-admin-5.png)

![](/media/lazy-admin-6.png)


### Yeak ok, but why *Lazy* Admin?

Because it's meant for sysadmins, who are lazy. Lazy to type, lazy to remember, etc.

### Does it make sense?

Probably not a lot, but it's fun. Although if you have mundane and/or repetative tasks to run on remote servers via SSH, it can be rather helpful.

## What are the different "editions"?

Lazy admins comes in four flavours:

* Full - The whole package, complete with sample data and an installer script
* Minimal - A leaned down version: No bulky help files, no plugins with external dependencies, no sample data
* Portable - Same as the full version, only without an installer... or the need to install.
* Portable Minimal - You can probably guess from the above...

### Why portable?

The portable editions have the advantages of not needing installation. You can stick it on a pendrive and it will work on any computer that has a working bash shell and `sed`. The disadvantage is, your user preferences and preset values will not be transferred to any new version, whereas the full edition has the option to preserve user data while upgrading.

### Why minimal?

Minimal edition is free of all the fluff. If you are already familiar with how it all works, and don't need extra help and functionality, or are just very-very restricted for space (I mean it's like 200kb, but still, who knows what you are planning to run this on), the minimal edition offers a leaner, more manageable experience.

### Why portable minimal?

Combine the above two, and you'll know.



## Installing Lazy Admin

Installation is pretty straightforward. Download the latest release, and unpack the tarball. It should either contain an `install.sh` script, or a launcher, ready to go (in the portable variety). If you go the installer way, there should also be another tarball, corresponding to the release's version number. Keep these in the same directory and run the script. There are a few options to choose form, but these will be explained as you go along.

### Upgrading from a previous version

If you already have Lazy Admin installed, and want to upgrade, you can just run the installer as you normally would. It will ask you if you want to purge your previous user configurations. If you say no, you will keep them and the new version will automatically use your defined menus and functions. If you say yes, it will still keep the old configs, in case you'd change your mind.

## So how can I configure it?

For a detailed guide of configuration and usage, you can refer to the help files within the package, accessible directly via the help menu in either MarkDown or plain text format. (Unless you choose the minimal install. In that case, you are on your own, only having the code comments for company... )

To access the help menu, either  navigate to the right panel by pressing 'r' or Ctrl + ➜, and select *Get Help*, or just press 'h' from anywhere inside Lazy Admin.

And that is all for now. I hope you'll enjoy this little project. Any feedback, bug reports, pull requests are most welcome. :)

Copyright (c)  2017 Attila Orosz
Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License, Version 1.3
or any later version published by the Free Software Foundation;
with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
A copy of the license is included in the section entitled "GNU
Free Documentation License".

Help file for Lazy Admin

This will basically display the help page(s)
Write whatever you want here

By default it will have a detailed description of how to use Lazy Admin and how to customize them

So here we go:

The basic functionality of Lazy Admin is to provide a pseudo graphical UI, one tht can be navigated by the arrow keys, or with keyboard shortcuts.

The usability might be questionable. If you are a lazy sys admin, who is tired of typing long commands and cannot remember the aliases he set (it must come with age), you might find it handy.

------------------------|
************************||
------------------------|||
                        ||||
Introduction and Basics |||||
                        ||||
------------------------|||
************************||
------------------------|

----------
Capacity |
----------

By default it is set to have six tabs, five of which are free to use (or even all six, if you remove the demo tab of Setup, as that functionality is not yet implemented), each with five sub-menu entries. That makes the default capacity of the main menu alone 25 commands or functions.
(Or 30 if you remove the setup).

You can also use sub-menus, if you like, each could hold up to eight entries. This means, with 5 times 5 main menus, each holding 8 sub-menus, theoretically your total number or entries would be 200... if that is not enough, you could even increase like main menu height by one or two (adding one row of main menus opens op the possibility of adding 40 more entries in sub-menus)

The maximum number of entries the main menu could could hold is 6, and the sub-menus could fit 9, but that would be a squeeze. Also, if you add more than that, the layout will break. You should adjust the defaults "normalmenuheight" and "submenuheight" in the la-menu-defaults file ($HOME/.config/lazy_admin/la-menu-defaults) to change this.

Using only sub-menus will have the solo disadvantage of not being able to handle flag-setting sub-menus (or not just yet). more on that later.

------------
Navigation |
------------

Navigation is simple.

Change tabs by the left or right arrows.
Navigate the menus by the up and down arrows
Enter a sub-menu, or execute a command by pressing enter or the numeric key, corresponding to the menu-item's position.

If an entry is skipped, its position still counts. E.g. if you have an arrangement of a menu like this (with a gap between the 2nd and 3rd):

	First entry
	Second entry 

	Third entry

You could select the "Second entry" by navigating there with the arrow keys, or by pressing number 2 on the keyboard.
To select the "Third entry", you would have to press number 4. That is because that entry has the no. 4 position in the menu (position #3 is empty).

To make navigation easier and more straightforward, it is recommended, that you name oyur menu entries preceded with the shortcut key, like this:

	1 - First entry
	2 - Second entry 

	4 - Third entry

You can change to the right panel, by pressing 't' or 'T'.

Some special keys are reserved, which can access the right panel functionality without having to navigate there:

- To re-flow the menu, press 'r' or 'R'. This is useful when you resize the window or the terminal changes size, the menu will be resized to fit.
- To display this message, press 'h' or 'H', that is, if you have not already done so...
- To return to the main menu (when you are in a sub-menu), press 'b' or 'B'
- To exit the menus completely, press 'x' or 'X'

In the set flags sub-menu, there are other short-keys you can use:

- To manually specify flags, you can press 'm' or 'M', enter your flags, as you would on command line, then press enter.
- To delete all the flags you've just set and start over, press 'd' or 'D'
- To commit the command with the flags you've set, press 'x' or 'X'

In later versions, I am planning to implement basic Setup functionality (see last tab).
These  have the following keys already reserved:

- To edit the menu entries interactively (how cool will that be), press 'e' or 'E'
- To edit the defaults for menu height, tabs number etc., press 'd' or 'D'
- To change, add, remove, or edit profiles (for the same user), press 'p' or 'P'

To recap:

Working:

	[1-9] - Access sub-menus, or execute command
	r - Re-flow menus
	h - Display help
	b - Back to main menu 
	x - Exit la-menus

Flags:

	m - Manually enter flags
	d - Delete all flags and start over
	c - Commit command with the flags you've set

Reserved:

	e - Edit menus
	d - Edit defaults
	p - Access profiles sub-menu

------- 
Flags |
-------

You can choose the interactively set flags or arguments to any command or function you like, using the flags_submenu_funtion (more on setup later).

This could come handy, when you often use a command, with certain arguments, or fixed combinations.

For example if you often use the ping command with -v (verbose) option, you could just put a -v flag as an easily accessible switch.

The option to manually enter flags could make the command usable (anything that is not preset could be entered here.

If e.g. you want to ping google.com with five patckets and get a verbose output, and you wish to do this 23 times a day, you could set up the -v and -c flags, and manually enter the number of packets like this:

Your flags options would be eg:

	-v
	-c
	-n
	--help

You would choose first -v, then -c

Now press 'm' (or navigate there with the arrows) to manually enter the number of packets (5) and the host (google.com). So after pressing m, you would type:

	5 google.com

This would result in the output:

	ping -v -c 5 google.com

I am sure, you will find it very useful to pinging google.com all day...


The manual option is not reserver to the end of the sequence, you can set manual flags any time and continue adding predefined ones. E.g. the previous command could be done this way:

	1. select -c

	2. press 'm' and enter '5' <press enter>

	3. select -v

	4. press 'm" and enter 'google.com'

	5. press 'c' to commit.
	
Of course, this may look as if it does not make any sense, and in this case you would be right. on the other hand, there are scenarios, when this could come in handy. only I cannot think of any, not when pinging google anyway.

-------------------
Bottom indicators |
-------------------

There are two sets of indicators at the bottom of the screen. the first one is tied to the menu items and the second one is tied to the tab position.
In the menu file, the setup of which you will see later), you can specify a one liner description instructions or fortune-cookie quote for each menu and sub-menu item you enter.
(Flags sub-menus have their descriptors predefined, which is kind of sad)

The tab-bound second descriptor is optional and totally script-able. 
You can put there a static line, like on the "Demo tab"
If you put nothing there it will be skipped and not displayed, see "Second tab". 
If you'd like to put some dynamic value there, you can make up whatever you fancy, see "Third tab".

<!--End basic stuff-->



-----------------------------|
*****************************||
----------------------------*|||
                            *||||	
Customization and scripting *|||||
                            *||||
----------------------------*|||
*****************************||
-----------------------------|

User beware, here there be dragons. You'll have to know some basic bash before you can make modifications. It is worth having a much better idea of bash script than I ever will, so you might as well add some useful modifications (let me know, if you have any).

I have not yet implemented any user-friendly way to change stuff around... Proceed at your own risk, you may brake something that was already of little use to start with...

-----------------------
Changing menu entries |
-----------------------

All the menu-entries will be stored in a file in $HOME/.config/lazy_admin/la-menuentries. While the installer only offers a local instll ATM, this might at a later stage change to /usr/local/share/lazy_admin/la-menuentries whenever a system-wide install will be available.

For now, just find the above file. I have tried to comment the file extensively, bt this only seems to make it more cluttered. anyway, it will hopefully be self-explanatory for the most.

The menu builder function parses the file looking for an underscore or '_' symbol. This is the delimiter for the start and end of sections.

There will be five kinds of sections:


_menutab, which will end with _endmenutab and hold the names of the top-bar tabs, each on its own line

_menu and _endmenu will be for the main menu entries

_submenu and _endsubmenu will hold the submenu entriees

for descriptors_

_dsescmenu and _enddescmenu mean the beginning and end of th descripor lines of main menu entries

_descsubmenu and _enddescsubmenu mark the descriptor lines of sub-menus


To know, which menu is which, numbers will be used, starting with zero

- For menu-entries the number will mark the tab position.

- For sub-menu entries two numbers will mark the tab position and the menu position (these ar two single digits written together).

This means _menu0 will hold all the menu entries of the first tab, _menu1 means the second tab, etc.

For submenues, you'll find _submenu00 to be the sub-menu of the first menuitem on the first tab, while e.g. _submenu21 means the sub-menu items of the second menuentry on the third tab, etc.

(_endmenu and _endsubmenu will also be numbered, although I question my sound judgment on this already...)

_descmenu0 will correspond with _menu0, holding their descriptors, while
_descsubmenu21 will hold descriptors of _submenu21


The menu entries should be on their own line. the descriptors in the same position. 

There is one reserved word: 'skip'. This will mark  them menu line to b skipped. Nothing will be printed on that line.

The below example might make it clearer. Consider the four menu entries of the third tab, with the second entry skipped. It would look like this:

	_menu1
	1 - First menu item on the second tab
	skip
	3 - Third Menu item on the second tab
	4 - Fourth Menu item on the second tab
	5 - Fifth Menu item on the second tab
	_endmenu1

The short-key clues are added for clarity's sake.
the descriptor menus (just underneath) look like this:

	_descmenu1
	This is the descriptor of first menu item on the second tab
	skip
	This is the descriptor of third menu item on the second tab
	This is the descriptor of fourth menu item on the second tab
	This is the descriptor of fifth menu item on the second tab
	_enddescmenu1

Note that 'skip' is not necessary in the descriptors, but it is better to keep it there

Similarly, to add a sub-menu, to the second item of the menu, you would put in the menu file:

	_submenu11
	First sub-menu item
	Second sub-menu item
	Third sub-menu item
	_endsubmenu11

Mark, the numbers show tab AND maim-menu item numbers.
Sub-menu descriptors corresponding:

	_descsubmenu11
	First sub-menu item description
	Second sub-menu item description
	Third sub-menu item description
	_enddescsubmenu11


And that's it. All of it. of course the right panel menu-items are described there too, but you would not be changing this, unless you change right panel functionality. if you can do that, i am sure you can decipher those menus too (It is the same self evident.)

----------------
Menu functions |
----------------

You will find two files:

	$HOME/.config/lazy_admin/n-user-functions

and

	$HOME/.config/lazy_admin/n-user-function-aliases


In the first file, you want to define any bash scripts in the form of a 'function', (or in whatever format you fancy, as long as it works), to use with the menus.

Give them any name, there are very few restrictions (i.e., do not use the same name twice... besides following the usual naming conventions)

To to tie them to your menus, you should use the 'la-menu-aliases' file

Here you will find functions and “sub-functions,” (by name, that is) these will represent menu and sub-menu entries. Naming these will be similar to the naming of menus.

- funct00 means the first (main) menu-entry on the first tab

- funct01 menas the second menu-entry on the first tab

- funct10 means the first menu-entry on he second tab

- funct11 means the second menu-entry on the second tab.

It is like this funct#tab#menu-entry

For sub-menus, there is an additional number for sub-menu entry:

- subfunct000 means first tab, first menu entry, first sub-menu entry

- subfunct001 means first tab first menu entry, second sub-menu entry

- subfunct213 means third tab, second menu entry, fourth sub-menu entry,

...and so on

Eexecute your functions within these tabs, or you can place single line commands there.


---------------------
Invoking a sub-menu |
---------------------

Any main menu entry can lead to a sub-menu, but sub-menu entries cannot yet handle nested sub-menus. (Theoretically yes, but tracking depth is missing still. the back button would lead to the main menu straight, besides, it is not tested)

From your main menu entry function alias, you should call a function called 'enter_submenu',  pass $@ as the first argument (this is important fo it to know where it is), and the title of the sub-menu window as the second argument, like this:

	enter_submenu $@ "Sub-menu Title"
	

Example:

If you wish to add a sub-menu to the second tab third menu-entry, you would put this code to the alias function:

	function funct12 {

		enter_submenu $@ "My New Sub-menu"

	}

Then you would also need to set up the menu entries for your new sub-menu, in the menu names file (see above), like this:

	_submenu12
	First sub-menu item
	Second sub-menu item
	Third sub-menu item
	_endsubmenu21

	_descsubmenu12
	Descriptor for first sub-menu item
	Descriptor for second sub-menu item
	Descriptor for third sub-menu item
	_enddescsubmenu12


This would make the sub-menu navigable with the proper names.

To add a simple command to the Second sub-menu item in your new sub-menu, you would use the 'subfunct121' alias function ('121' being second tab, third menu item, second sub-menu item).

subfunct121 {

ping -c 5 google.com
 
}

Google will be happy, once again for your efforts... and now you have a working sub-menu. I'm not sure it was worth the effort... but believe me, once you get the hang of it, it will be really easy.


----------------------------------------
Setting flags and predefined arguments |
----------------------------------------

Now that you've seen it all, comes the difficult part: using he flag setting sub-menu. The good news is, you will not need to define menu-entries for this ne, it is al in the line of invoking function

Flag setting sub-menus can only be called from the, main menu. To access this functionality, you will use the menu-function named 'flags_submenu_function'. It accept a number of arguments, each having their own specific functionality.

- The first argument, placed inside double quote will mark the name of the sub-menu. It is worth putting the name of the command there, for clarity's sake.
- The second argument will be the command itself. it can be a bash command, or your own function, that you have defined in n-user-functions.
- After the third argument you will basically set the flags for our commands as you would on the command line.

For example, to invoke a ping command, with the optional flags of -v -c and -n, you would use:

	flags_submenu_function "Ping with flags" ping -v -c -n
	
If you were to use some other function that you've written yourself, you would use
	
	flags_submenu_function "Your function name" my_user_function -f -c- --any_other_arg --yet_another_arg
	
in the exact same way, you'd declared in the function itself.

Example:

You want to place a ping command, with the flags -v -c -f, -n and --help to the second menu-item on the fourth tab. You would use the 'funct31' alias function, like this:

function funct31 {

	flags_submenu_function "Ping with flags" ping -v -c -f -n --help

}

..and that's it. It will invoke the set sub-menus interface, with the flags set in the exact order you've just specified. You will have all other functionality, like manually adding flags, automatically added. Numbers for short-keys will also be added.
Please be aware, that shor-keys only work from 1 to 9, so although more than 9 flag entries are possible, the short-keys will not work form 10 and onwards.

It is also possible to place more than one flag on a single line, if they are often used together.

the above example would give you a menu like:

	1 - Set flag -v
	2 - Set flag -c
	3 - Set flag -f
	4 - Set flag -n
	5 - Set flag --help
	
If you ant to group e.g. -v, -c and -f always to be used together, you could put them in single qutes, when calling the function, like this:

	flags_submenu_function "Ping with flags" ping '-v -c -f' -n --help
	
This would result in a menu like this:

	1 - Set flag -v -c -f
	2 - Set flag -n
	3 - Set flag --help
	
I hope this makes sense.


<!-- End scary scripty stuff -->


That is all for now. I the future i plan to implement some interactive setup, so that the TRULY lazy user can also benefit. I hope you find it useless, but fun to use. 

I do. 

If you have any suggestions, or know something better, spotted an error, or just want to tell me that I'm an idiot for spending my time like this, just email me at:

attila.orosz@mail.com

Enjoy. :)	

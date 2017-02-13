

# Lazy Admin Customization and Scripting

User beware, here there be dragons. You'll have to know some basic bash before you can make modifications. It is worth having a much better idea of bash script than I ever will, so you might as well add some useful modifications (let me know, if you have any).

I have not yet implemented any user-friendly way to change stuff around... Proceed at your own risk, you may brake something that was already of little use to start with...


# **Changing menu entries**


All the menu-entries will be stored in a file in `$HOME/.config/lazy_admin/la-menuentries`. While the installer only offers a local instll ATM, this might at a later stage change to `/usr/local/share/lazy_admin/la-menuentries` whenever a system-wide install will be available.

For now, just find the above file. I have tried to comment the file extensively, bt this only seems to make it more cluttered. anyway, it will hopefully be self-explanatory for the most.

The menu builder function parses the file looking for an underscore or '_' symbol. This is the delimiter for the start and end of sections.

There will be five kinds of sections:


* _menutab, which will end with _endmenutab and hold the names of the top-bar tabs, each on its own line

* _menu and _endmenu will be for the main menu entries

* _submenu and _endsubmenu will hold the submenu entriees

* _dsescmenu and _enddescmenu mean the beginning and end of th descripor lines of main menu entries

* _descsubmenu and _enddescsubmenu mark the descriptor lines of sub-menus


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


## **Menu functions**


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



## **Invoking a sub-menu**


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



## **Setting flags and predefined arguments**


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
	
I hope this makes sense...


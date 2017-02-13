> Copyright (c)  2017 Attila Orosz
> Permission is granted to copy, distribute and/or modify this document
> under the terms of the GNU Free Documentation License, Version 1.3
> or any later version published by the Free Software Foundation;
> with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
> A copy of the license is included in the section entitled "GNU
> Free Documentation License".


# Lazy Admnin Usage Guide

## **Oveview**

The basic functionality of Lazy Admin is to provide a pseudo graphical UI, one that can be navigated by the arrow keys, or with keyboard shortcuts.

The usability might be questionable. If you are a lazy sys admin, who is tired of typing long commands and cannot remember the aliases he set (it must come with age), you might find it handy.



## **Capacity**


By default it is set to have six tabs, five of which are free to use (or even all six, if you remove the demo tab of Setup, as that functionality is not yet implemented), each with five sub-menu entries. That makes the default capacity of the main menu alone 25 commands or functions.
(Or 30 if you remove the setup).

You can also use sub-menus, if you like, each could hold up to eight entries. This means, with 5 times 5 main menus, each holding 8 sub-menus, theoretically your total number or entries would be 200... if that is not enough, you could even increase like main menu height by one or two (adding one row of main menus opens op the possibility of adding 40 more entries in sub-menus)

The maximum number of entries the main menu could could hold is 6, and the sub-menus could fit 9, but that would be a squeeze. Also, if you add more than that, the layout will break. You should adjust the defaults "normalmenuheight" and "submenuheight" in the la-menu-defaults file ($HOME/.config/lazy_admin/la-menu-defaults) to change this.

Using only sub-menus will have the solo disadvantage of not being able to handle flag-setting sub-menus (or not just yet). more on that later.


## **Navigation**


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


## **Flags**


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


## **Bottom indicators**


There are two sets of indicators at the bottom of the screen. the first one is tied to the menu items and the second one is tied to the tab position.
In the menu file, the setup of which you will see later), you can specify a one liner description instructions or fortune-cookie quote for each menu and sub-menu item you enter.
(Flags sub-menus have their descriptors predefined, which is kind of sad)

The tab-bound second descriptor is optional and totally script-able. 
You can put there a static line, like on the "Demo tab"
If you put nothing there it will be skipped and not displayed, see "Second tab". 
If you'd like to put some dynamic value there, you can make up whatever you fancy, see "Third tab".



That is all for now. I the future i plan to implement some interactive setup, so that the TRULY lazy user can also benefit. I hope you find it useless, but fun to use. 

I do. 

If you have any suggestions, or know something better, spotted an error, or just want to tell me that I'm an idiot for spending my time like this, just email me at:

attila.orosz@mail.com

Enjoy. :)	

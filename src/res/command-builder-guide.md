# Using the command builder

**This document is deprecated as of Lazy Admin 3.0 Beta**

## **Basic Usage**

The command builder let you visually build a command, and then execute it. In the command builder menu, you can select an item by navigating to it and pressing enter (or just press its corresponding number) and then the flag or argument bound to that item will be added to the build command. You can keep track of how your command looks below the menu. There is an option to manually enter any unspecified flags or arguments, to delete all set flags, and to run the built command. Currently the number of preset arguments or argument sets is limited to 9, so as to keep the number-shortkey functionality intact. The height of the command builder menu will dynamically change according to the number of preset arguments passed to it.

- When you select a predefined flag or argument (or set of flags/arguments) or press its corresponding number, it will be appended to your active command. You can see the complete command below the menu.
- When you select "manually enter flags", or press `m`, you will be prompted to enter as many optional arguments as you want. Pressing `<Enter>` will append them to the end of the command
- When you select "Commit with flags", or press `c`, the whole command, as displayed at the bottom, will be executed.
- When you select "Delete Set args", or press `x`, the command builder will be reset, and all flags will be removed, so you can start over again


## **How to set up a command builder sub_menu**

To access this functionality, you will use the predefined function named `command_builder_function`. It will accept a number of arguments, each having their own specific functionality:

- **The first argument**, placed inside double quotes, will mark the name of the sub-menu. (It is worth putting the name of the command there, for clarity's sake.)
- **The second argument** will be the command itself. It can be a `bash` command, or your own function, that you have defined in `user-functions.la`. It can also include some preset flags, or arguments. If it is more than one word, you'll need to put it in double quotes, again.
- **From the third to the eleventh arguments** you will basically set the flags for your command, which you want to use as selecteable options, to be used with the builder. You can use compound arguments, or multiple flags, anything in double quotes goes on one line. The maximum number of "settable" lines is 9.

So, for example, if you want to ping *google.com* with five packets and get a verbose output, and you wish to do this 23 times a day, you could set up the `-v` and `-c 5` flags, and manually enter the domain to ping. To do this, you would have to bind the command builder to a menu item, like so:

```bash

    command_builder_function "Ping any host with flags" "ping" -v -n '-c 5' --help

```

Your command builder sub_menu should look something like this:

```bash

     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
     Ping any host
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
     1 - Set arg. -v
     2 - Set arg. -n
     3 - Set arg. -c 5
     4 - Set arg. --help
     m - Manually enter flags
     c - Commit with flags
     x - Delete set flags
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
     Set the specified flag
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
     Active command: ping

```

You would choose first `-v` (or press `1`), then `-c 5` (or press `3`)

Now press `m` (or navigate there with the arrows) to manually enter the domain (google.com). So after pressing m, you would type: `google.com`

This would result in the output: `ping -v -c 5 google.com`. Your command builder should display it below the menu:

```bash

     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
     Ping any host
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
     1 - Set arg. -v
     2 - Set arg. -n
     3 - Set arg. -c 5
     4 - Set arg. --help
     m - Manually enter flags
     c - Commit with flags
     x - Delete set flags
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
     Set the specified flag
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
     Active command: ping -v -c 5 google.com

```

Then you would just need to press `c` (or navigate down and press `<Enter>`) to actually do the deed. I am sure you will find it very useful, if you love pinging google.com all day, every day...

The manual option is not reserved to the end of the sequence, you can set manual flags any time and continue adding predefined ones. E.g. the previous command could be done this way:

1. select `c`
2. press `m` and enter `5`, then `<Enter>`
3. select `-v`
4. press `m` and enter "google.com"
5. press `c` to commit.

Of course, you are not confined to bash commands, you can use any predefined function that you have in `user-functions.la` If you were to use some other function that you've written yourself, you would use

```bash

    command_builder_function "My function name" my_user_function -f -c --any_other_arg --yet_another_arg "--compound_arg X Y Z" --last_arg`
  

```

in the exact same way, you'd declared in the function itself. This would result in the following command builder sub-menu layout:
  
```bash

     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
     My function name
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
     1 - Set arg. -f
     2 - Set arg. -c
     3 - Set arg. --any_other_arg
     4 - Set arg. --yet_another_arg
     5 - Set arg. --compound_arg X Y Z
     6 - Set arg. --last_arg`
     m - Manually enter flags
     c - Commit with flags
     x - Delete set flags
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
     Set the specified flag
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
     Active command: my_user_function

  
```

...and that's it. You will also have other functionality, like manually adding flags, automatically added. Numbers for short-keys are also automatically added. Please be aware, that short-keys only work from `1` to `9`, so any more than `9` flag entries will simply be ignored.

To exit the command builder and return to the calling menu or sub_menu, just press `b` (or navigate to the right panel and choose the option)

Of course, this may look as if it does not make any sense, and in this case you would be right. On the other hand, there are scenarios, when this could come in handy. Only I cannot think of any, not when I'm busy pinging Google anyway...

I still hope this makes sense... If not, maybe just try it and you'll see.

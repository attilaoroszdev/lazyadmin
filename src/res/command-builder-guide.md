# Using the command builder


## **Basic Usage**

The command builder let you visually build a command, and then execute it. When you invoke the function, your preset arguments will be automatically added to the menu as menu items (see below), and three extra options will be appended to it, to manually enter arguments, execute the command, or delete the arguments and start again.

 * When you select a predefined flag or argument (or set of flags/arguments), or press it's corresponding number, it will be appended to your command. You can see the complete command below the menu.

| <br />

* When you select "manually enter flags", or press `m`, you will be prompted to enter as many optional arguments as you can. pressing enter will append them to the end of the command

| <br />

* When you select "Commit with flags", or press `c`, the whole command, as displayed at th bottom, will be executed.

| <br />

* When you select "Delete Set arg.s", or press `x`, the command builder will be reset, and all flags will be removed.


## **How to set up a command builder submenu**

To access this functionality, you will use the predefined function named `command_builder_function`. It will accept a number of arguments, each having their own specific functionality:

| <br />

* **The first argument**, placed inside double quotes, will mark the name of the sub-menu. (It is worth putting the name of the command there, for clarity's sake.)

| <br />

* **The second argument** will be the command itself. It can be a bash command, or your own function, that you have defined in n-user-functions, it can also include some preSet arg.s or arguments. If it is more than one word, you'll need to put it in double quotes, again.

| <br />

* **From the third to the eleventh arguments** you will basically set the flags for your command, which you want to use as sub-menu items, to be used with the builder. You can use compound arguments, or multiple flags, anything in double quotes goes on one line. The maximum number of "settable" lines is 9.

For example, to invoke a ping command, with the optional flags `-v -c` and `-n`, you would do:

`command_builder_function "Ping with flags" ping -v -c -n`

which would result in a flags sub-menu offering the options:

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

which would result in a sub-menu offering to execute `ping` with the below options:

| `1 - Set arg. -v`
| `2 - Set arg. -c`
| `3 - Set arg. -f`
| `4 - Set arg. -n`
| `5 - Set arg. --help`

..and that's it. You will also have other functionality, like manually adding flags, automatically added. Numbers for short-keys are also automatically added. Please be aware, that short-keys only work from 1 to 9, so any more than 9 flag entries will simply be ignored.

I hope this makes sense...

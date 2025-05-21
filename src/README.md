# Lazy Admin v2.2 README

## To install


Run `./install.sh`. In case you have the portable edition, there is no installer, (or the need for one), just run `./pladmin`, from Lazy Admin's root folder.


## To run
    
Run one of the following launchers:

- `ladmin` - for full edition   
  It will be placed in either `$HOME` or `/opt/Lazy_Admin/`, depending on the type of your install. If you agreed to symlink to `/usr/local/bin`, you can also run it as a command

- `pladmin` - for portable edition
  It will be in the Lazy Admin directory, which you have extracted from the release tarball. You could also symlink it, but then it would lose its "portable-ness" wouldn't it?


### Launcher flags

To load a different user profile (located next to the "user" directory, and with similar contents"), run

`ladmin --load-profile <profile_name>` or `ladmin -p <profile_name>`

or 

`pladmin --load-profile <profile_name>` or `pladmin -p <profile_name>`

if you have the portable edition.

`<profile_name>` must be the name of the folder your alternative profile lives in the default location, or a path to the non-standard location (both relastive or absolute path will work).


To temporarily disable line connectors on the fly, run

`ladmin --join-lines off` (or `pladmin --join-lines off`)

If line connectors are disbled in your setup, and you want to temporarily enable them, try

`ladmin --join-lines on` (or `pladmin --join-lines on`)

These switches can be included in any order.


## How to configure

Lazy Admin comes with detailed documentation included. Access the Help menu for details

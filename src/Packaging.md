# Packaging Instructions

There are currently four (4) "officially" packaged versions, all using different portions of this source code. While you are free to mix and match any files, in any way your project needs, this document is meant to help you identify the different parts and how they are all connected, to better understand the logic behind all this mess. Or the mess behind all this logic. It's up to you which one you see first.


## "Full" edition - install tarball structure

This is the version that has it **all**


/Lazy_Admin_vX.Y/── install.sh
                │
                ├── LICENSE
                │
                ├── README
                │
                ├── Packaging.md
                │
                └── files-vX.Y.tar.gz/──/core/─── core-defaults.la
                                     |       |
                                     |       ├─── includes.la
                                     |       |
                                     |       └─── menu-functions.la
                                     |
                                     |
                                     ├──/launcher/─── ladmin
                                     |
                                     │
                                     ├──/plugins/─── display-help.la
                                     |          |
                                     |          ├─── extra-functions.la
                                     |          |
                                     |          └─── setup-functions.la
                                     │
                                     │
                                     ├──/res/─── command-builder-guide.md
                                     |      |
                                     |      ├─── command-builder-guide.txt
                                     |      |
                                     |      ├─── configuration-guide.md
                                     |      |
                                     |      ├─── configuration-guide.txt
                                     |      |
                                     |      ├─── shortkeys.md
                                     |      |
                                     |      ├─── shortkeys.txt
                                     |      |
                                     |      ├─── usage-guide.md
                                     |      |
                                     |      ├─── usage-guide.txt
                                     |      |
                                     |      └─── user_files.tar.gz
                                     |
                                     |
                                     └──/user/─── function-aliases.la
                                             |
                                             ├─── menu-entries.la
                                             |
                                             ├─── user-defaults.la
                                             |
                                             └─── user-functions.la



## Minimal edition - install tarball structure

A reduced version, with no full. This is the absolute minimum Lazy Admin runs on

Include the -min.la files wherever ,marked, but rename them so that they no longer have "-min" in the filename, such as 
'includes-min.la' becomes 'includes.la'
'menu-functions-min.la' becomes 'menu-functions.la'
etc.

/Lazy_Admin_vX.Y_Minimal/── install-minimal.sh
                        │
                        ├── LICENSE
                        │
                        ├── README
                        │
                        ├── Packaging.md
                        │
                        └── files-vX.Y-min.tar.gz/──/core/─── core-defaults(-min).la
                                                 |       |
                                                 |       ├─── includes(-min).la
                                                 |       |
                                                 |       └─── menu-functions(-min).la
                                                 |
                                                 |
                                                 ├──/launcher/─── ladmin (rename from mladmin)
                                                 |
                                                 |
                                                 └──/user/─── function-aliases(-min).la
                                                         |
                                                         ├─── menu-entries(-min).la
                                                         |
                                                         ├─── user-defaults(-min).la
                                                         |
                                                         └─── user-functions(-min).la


## Portable edition - folder and file structure

Ready to go, no installation needed. Everything is dynamically linked, so it's useable from anywhere, any time

/Lazy_Admin_vX.Y_Portable/── pladmin
                         │
                         ├── LICENSE
                         │
                         ├── README
                         │
                         ├── Packaging.md
                         │
                         ├──/core/─── core-defaults.la
                         |       |
                         |       ├─── includes-port.la
                         |       |
                         |       └─── menu-functions.la
                         |
                         │
                         ├──/plugins/─── display-help.la
                         |          |
                         |          ├─── extra-functions.la
                         |          |
                         |          └─── setup-functions.la
                         │
                         │
                         ├──/res/─── command-builder-guide.md
                         |      |
                         |      ├─── command-builder-guide.txt
                         |      |
                         |      ├─── configuration-guide.md
                         |      |
                         |      ├─── configuration-guide.txt
                         |      |
                         |      ├─── shortkeys.md
                         |      |
                         |      ├─── shortkeys.txt
                         |      |
                         |      ├─── usage-guide.md
                         |      |
                         |      ├─── usage-guide.txt
                         |      |
                         |      └─── user_files.tar.gz
                         |
                         |
                         └──/user/─── function-aliases.la
                                 |
                                 ├─── menu-entries.la
                                 |
                                 ├─── user-defaults.la
                                 |
                                 └─── user-functions.la


## Portable edition - folder and file structure

Same as portable, but reduced, without fluff

Include the -min.la files wherever ,marked, but rename them so that they no longer have "-min" in the filename, such as 
'includes-min.la' becomes 'includes.la'
'menu-functions-min.la' becomes 'menu-functions.la'
etc.

/Lazy_Admin_vX.Y_Port_Min/── pladmin (rename from pmladmin)
                         │
                         ├── LICENSE
                         │
                         ├── README
                         │
                         ├── Packaging.md
                         │
                         ├──/core/─── core-defaults(-min).la
                         |       |
                         |       ├─── includes-port(-min).la
                         |       |
                         |       └─── menu-functions(-min).la
                         |
                         └──/user/─── function-aliases(-min).la
                                 |
                                 ├─── menu-entries(-min).la
                                 |
                                 ├─── user-defaults(-min).la
                                 |
                                 └─── user-functions(-min).la

A later version of this document will give detailed explanations of installation structure, and the actual relations between included files, besides instructions and best practices about how to integrate Lazy Admin in your existing infrastructure, or how to build it into your own projects. until such time, you might as well figure it out for yourself-. :)
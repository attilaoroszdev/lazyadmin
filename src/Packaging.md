# Packaging Instructions v2.2

There are currently two (2) "officially" packaged versions, both using slightly different portions of this source code. While you are free to mix and match any files, in any way your project needs, this document is meant to help you identify the different parts and how they are all connected, to better understand the logic behind all this mess. Or the mess behind all this logic. It's up to you which one you see first.


## "Full" edition - install tarball structure

This is the version that has it **all**

```
/Lazy_Admin_v2.2/─ install.sh
                │
                ├─ LICENSE
                │
                ├─ README
                │
                └─ files-v2.2.tar.gz/core/core-defaults.la
                                    |    |
                                    |    ├includes.la
                                    |    |
                                    |    └main-functions.la
                                    |
                                    |
                                    ├/launcher/ladmin
                                    |
                                    │
                                    ├/plugins/help-functions.la
                                    |        |
                                    |        ├extra-functions.la
                                    |        |
                                    |        └setup-functions.la
                                    │
                                    │
                                    ├/res/command-builder-guide.md
                                    |    |
                                    |    ├command-builder-guide.txt
                                    |    |
                                    |    ├configuration-guide.md
                                    |    |
                                    |    ├configuration-guide.txt
                                    |    |
                                    |    ├shortkeys.md
                                    |    |
                                    |    ├shortkeys.txt
                                    |    |
                                    |    ├usage-guide.md
                                    |    |
                                    |    ├usage-guide.txt
                                    |    |
                                    |    └user_files.tar.gz/user/menu-bindings.la
                                    |                           |
                                    |                           ├menu-entries.la
                                    |                           |
                                    |                           ├user-defaults.la
                                    |                           |
                                    |                           └user-functions.la
                                    |
                                    |
                                    └/user/menu-bindings.la
                                          |
                                          ├menu-entries.la
                                          |
                                          ├user-defaults.la
                                          |
                                          └user-functions.la
```



## Portable edition - folder and file structure

Ready to go, no installation needed. Everything is dynamically linked, so it's useable from anywhere, any time

```
/Lazy_Admin_v2.2_Portable/pladmin
                         │
                         ├LICENSE
                         │
                         ├README
                         │
                         ├/core/core-defaults.la
                         |     |
                         |     ├includes-port.la
                         |     |
                         |     └main-functions.la
                         |
                         │
                         ├/plugins/help-functions.la
                         |        |
                         |        ├extra-functions.la
                         |        |
                         |        └setup-functions.la
                         │
                         │
                         ├/res/command-builder-guide.md
                         |    |
                         |    ├command-builder-guide.txt
                         |    |
                         |    ├configuration-guide.md
                         |    |
                         |    ├configuration-guide.txt
                         |    |
                         |    ├shortkeys.md
                         |    |
                         |    ├shortkeys.txt
                         |    |
                         |    ├usage-guide.md
                         |    |
                         |    ├usage-guide.txt
                         |
                         |
                         └/user/menu-bindings.la
                               |
                               ├menu-entries.la
                               |
                               ├user-defaults.la
                               |
                               └user-functions.la
```


A later version of this document will give detailed explanations of installation structure, and the actual relations between included files, besides instructions and best practices about how to integrate Lazy Admin in your existing infrastructure, or how to build it into your own projects. until such time, you might as well figure it out for yourself-. :) (I realise I said that like 8 years ago, but it is coming soon, I promise.)

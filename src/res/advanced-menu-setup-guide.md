# ***Lazy Admin Advanced Menu Setup Guide v3.0***


*This file has been formatted to be viewed with lynx/pandoc on a Linux CLI. Your mileage may vary with other software.*

You have some more options, when it comes to menus, namely: submenus, skipped items, visual dividers and in-line labels...


## **Submenus**

Each menu item can hold a submenu, which increases the menus' capacity almost exponentially

Unlike in previous versions, submenus will be defined in place. If you want a menu item to lead to a submenu, you should change its assigned command to the `enter_submenu` function. After the menu item that should hold a submenu, instead of the Tab ID, you should open each line with `--`. These rows will become the submenu items. To expand on the previous example, the second item will now hold a submenu:


<br />


```bash

    [:menu_items:]
    
    # ID  :: Displayed item name :: Description             :: Command or function
    Tab 1 :: First menu item     :: Description of 1st item :: dummy_function
    Tab 1 :: Item with submenu   :: This leads to a submenu :: enter_submenu
       -- :: Submenu item 1      :: First submenu item      :: submenu_function_1
       -- :: Submenu item 2      :: Second submenu item     :: submenu_function_1
       -- :: Submenu item 3      :: Third submenu item      :: submenu_function_1
       -- :: Submenu item 4      :: Fourth submenu item     :: submenu_function_1
    Tab 1 :: Third menu item     :: Description of 3rd item :: /c /d /v top
    
    [:end_menu_items:]

```

<br />

When selecting the 2nd menu item, it will display its submenu:

<br />

```bash
    
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                   Lazy Admin - v3.0
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
              Submenu: Item with submenu
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
     
     *1 - Submenu item 1*
      2 - Submenu item 2
      3 - Submenu item 3
      4 - Submenu item 4

    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 
      First submenu item
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

```

<br />


## **Special menu items (skip, delimiter and inline-label)**

Special menu items include empty lines, visual dividers and labels. These will be skipped at navigation time and are mostly useful as visual aids to better categorise or group menu items.

- To **skip one row**, put the Tab ID followed by the delimiter and nothing else:
  E.g. `Tab 1 ::` will add an empty row to the firs tab.
- To **draw a divider line**, add `---` as a menu item to the specific tab, e.g.
  E.g. `Tab 1 :: ---` will draw a divider line in that position on Tab 1.
- To **add a label**, just write an item name with no description or command after the tab id,
  E.g. `Tab 1 :: Group label` will add the label "Group label" in the desired position

To expand the previous menu example;

<br />

```bash

    [:menu_items:]
    
    # ID  :: Displayed item name :: Description              :: Command or function
    Tab 1 :: Top group label
    Tab 1 ::
    Tab 1 :: First menu item     :: Description of 1st item  :: dummy_function
    Tab 1 :: Item with submenu   :: This leads to a submenu  :: enter_submenu
       -- :: Submenu item 1      :: First submenu item       :: submenu_function_1
       -- :: Submenu item 2      :: Second submenu item      :: submenu_function_1
       -- :: Submenu item 3      :: Third submenu item       :: submenu_function_1
       -- :: Submenu item 4      :: Fourth submenu item      :: submenu_function_1
    Tab 1 :: Third menu item     :: Description of 3rd item  :: /c /d /v top
    Tab 1 ::
    Tab 1 :: ---
    Tab 1 :: 
    Tab 1 :: Bottom group label
    Tab 1 ::
    Tab 1 :: Fourth menu item    :: This is just the 4th item :: dummy_funtion_number_4
    Tab 1 :: Fifth menu item     :: This is the 5th item      :: dummy_funtion_number_4

    [:end_menu_items:]

```

<br />

will be displayed like:

<br>

```bash
    
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                            Lazy Admin - v3.0
    ━━━━━━━━━━━━┯━━━━━━━━━━━━┯━━━━━━━━━━━┯━━━━━━━━━━━━┯━━━━━━━━━━━━━
     *First tab*│ Second tab │ Third tab │ Fourth tab │  Fifth tab
    ━━━━━━━━━━━━┷━━━━━━━━━━━━┷━━━━━━━━━━━┷━━━━━━━━━━━━┷━━━━━━━━━━━━━
      
      Top group label

      1 - First menu item 
      2 - Item with submenu
      3 - Third menu item

    -----------------------------------------------------------------

      Bottom group label

     *4 - Fourth item*
      5 - Fifth item

    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 
      This is just the 4th item
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


```

<br />

As you can see, the numbering continues from the last regular menu item. There s no limit as to how many labels, skipped items or dividers you can put on the same tab. It might a good idea however to leave an empty row above and below divider lines and labels, for clarity's sake, unless you are very pressed for space (in which case the grouping might be a waste of space anyway)

And that's all there is to menus, really...

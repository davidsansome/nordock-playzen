/****************************************************
  Version History
  ats_about_change

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System v0.57 Public Beta Version***
    Created by Mojo(Allen Sun)


  Version 0.57 - August 25, 2002
  ------------------------------

  ADDITIONS
  ---------

  -Added logging ability for skill gains.  This is on by default and whenever a
   player gains a skill point, a time stamped entry will be added to the log
   with the player's current skill value.

  -You can now change the level of information that is displayed in the skill
   gain message.  Please refer to ats_config for the options.

  -Skill ranks are now in.  You can change these in the ats_const_skill script.

  -You can now suppress all numeric skill information in the journal.
   If you do, only skill ranks are shown.

  -Added a DM Skill Wand that lets you view and edit a player's trade skill
   values.

  -Added a new module event script.  You will need to edit your OnClientLeave
   event script or add "ats_client_leave" if you don't have a script for it
   already. Please refer to steps 21-23 of the install notes in the readme file
   for instructions.


  CHANGED
  -------

  -New and improved Trade Skill Progress Journals!! These journals are now
   loaded with information about skills and stats with more info to come.

  -Useable items no longer get refreshed on client enter.  They should only get
   refreshed when a player buys them now or when the character logs into a new
   module.

  -Changed how stores get initialized. They are now created when someone first
   talks to the NPC and opens the store instead of onModuleLoad.

  -Tweaked with the delays when creating new skill tokens.  This may stop some
   people from losing skills.  There still is a chance that if the server
   crashes and the player is in the middle of gaining a skill point, the skill
   will be lost if only using skill bullets as persistent data.

  -Made the success bonus attribute for Jewelcrafting charisma.

  -Broke up the ats_inc_constant file into smaller include files named
   ats_const_skill, ats_const_common, ats_const_recipe, and ats_const_mat.
   Made ats_inc_constant a stub containing all these constant script includes.

  -Changed the install notes in the readme file.  Steps 21-23 now explain the
   new event handler script OnClientLeave that needs to be changed.

  FIXES
  -----

  -Offloaded the onModuleLoad init functions with DelayCommands as well as
   staggered the rock spawning with DelayCommands. This should fix all problems
   with rocks not spawning I hope.  There will be a delay between the time the
   module loads and the time all the rocks spawn.  This delay depends on how
   many spawn points you have in your module.

  -Fixed a bug that was causing the inventory on merchants that came from
   players to eventually disappear.

  -Fixed the bug where talking to the merchant didn't always open the store the
   first time.

  -Fixed a problem when initializing NPC crafting merchants when a player places
   down a merchant object with the NPC.  This caused a problem with mineable
   rocks not spawning.

  -Item names now appear in the crafting menus in the color of the most
   difficult material to make(not the easiest anymore).

  -Changed the graphics of some of the gems.

  -Made some optimizations to the crafting menus to speed up the display.
   This should fix the too many instructions error when using the jeweler's desk
   if you don't install the default craftable items.

  -Fixed the recipe with malachite again.  Other gems should now work when
   cutting.

  -Fixed the tags of rough black sapphire, rough sapphire and rough amethyst.
   You should now be able to mine these and not get the small unidentified misc
   item.

  -Fixed a few names of amulets.

  -Fixed a typo in the readme about the Onyx Switch.  It should be OYX not OXY.
   Please change this in any spawn points you have.

  -Fixed a typo in the readme with the mineable rock spawn example.


  Version 0.56 - August 20, 2002
  ------------------------------

  FIXES
  -----

  -Possibly fixed the problem with forges becoming inactive occasionally.
   Please let me know if this still happens meaning you get no menu to pop
   up sometimes.

  -Non-functional trade skill journals have been fixed.  This was due to a
   missing conversation file in the v0.55 .ERF file.

  -Multiple Tradeskill Journals on client enter has been fixed. This creeped
   in when I made journals get deleted and recreated whenever a trade skill
   gets sets so that there is room for tokens to be created. It didn't appear
   when I was using the DM client or when I used a new character so I didn't
   catch it. It is now fixed I hope.

  -Fixed a problem with mineable rocks not spawning in areas with no placeable
   objects. Thanks to Rocc for isolating this bug!

  -Fixed an issue with Gemcutting and Jewelcrafting skills not saving properly
   with tokens.

  -Fixed the Gemcutting recipe with malachite so that it now works with the NPC
   bought one.

  -Fixed a bug where smelting shadow ore into ingots wasn't working.

  Version 0.55 - August 19, 2002
  ------------------------------

  ADDITIONS
  ---------

  -There is now a new way to put ore and gems into your module.  A mining spawn
   system was created to facilitate a more controlled method to create ore veins
   and gem stones. There is a new waypoint with the tag ATS_MSP_WP.  You can
   place these down in your module and edit its name field with option switches.
   Please refer to the readme.txt or the comments field of the waypoint for more
   information on how to set these up.

  -NPC Crafting Stores now automatically clean themselves up when a player opens
   the store.  You can set the default max per item and total max items for the
   store in the ats_config script.  None of the original items on the store
   count towards the totals.

  -Gemcutting and Jewelcrafting are now in!! There are about 400+ pieces of
   jewelry added to the default craftables.  There are 14 gem types.  There is
   also a new Master Jeweler NPC and a Jeweler Desk placeable that needs to be
   added to your module.

  -ATS now includes Tigsen's Pack Oxen code!  Just import in the
   ats_tigsen_poxen.ERF file and read the ats_about_poxen script for set up
   instructions.

  -An armor table spreadsheet is included that shows the skill needed to craft
   the armors.

  -There is now a recipe tutorial written by Pelemele included in this .zip
   file.

  CHANGES
  -------

  -Bundles are now automatically recognized when crafting.  They will
   automatically unbundle when crafting.

  -Skinnable animals now wander around.  Herbivores will flee from all player
   except rangers and druids.  All animals are in the hostile faction.

  -Placeables now can only be used by one person at a time to avoid conflicts.
   It will display a message that it is already in use if a person tries to use
   it while someone else is using it.

  -There is now a script in the forges' heartbeat event so that it automatically
   unlocks if it is locked and not in a conversation or opened.  Hopefully this
   fixes the forges staying locked problem.  If not, then it is a Bioware bug.
   Please send me any feedback on this change.

  -When mining, strength now increases your chance to find an additional ore per
   swing. This is to offset people with high strength doing more damage to ore
   veins and wearing them out quicker.

  FIXES
  -----

  -Fixed the delay when crafting using the tanner's sewing kit.

  -Added a new recipe book to the Blacksmith merchant and fixed quantities in
   the old recipe books.

  -Fixed a compatibility issue with HCR and PWDB.  Functions in the
   ats_inc_persist now have different names.

  -When a player gains a skill, the skill journal is deleted and remade so that
   there is room in the player's inventory for the skill token to be created.
   This will cause some text spam when a player gains skill.

  -Made ore drop on the ground when mining and made the player automatically
   pick it up.  This is a workaround to where if the player's inventory was full
   and he mined something it would cause a crash because of the engine
   automatically dropping a "no-drop" item when calling CreateItemOnObject with
   a full inventory.

  -Fixed a bug where shadow ore wasn't being created properly.

  -Fixed a problem where when creating studs, duplicates would be created on the
   ground.

  -Fixed a problem with the success/failure display name when creating tools.


  Version 0.54 - August 15, 2002 - FIRST PUBLIC BETA RELEASE!
  ------------------------------

  -Fixed a problem with people getting duplicate trade skill journals.

  -Fixed some links in the crafting menus that were incorrect.

  -Renamed Black Iron Ore to Shadow Ore.  All items with Black were renamed with
   Shadow.

  -Durability of tools is now stored in the tag of the tool instead of in the
   configuration file.
   To set the durability of a tool append "_DUR#" to the tag where # is the
   durability amount such as "_DUR100" means durability of 100.  If you don't
   set a durability, then the default material durability is used.  All default
   tools already have their durabilities set.

  -Changed how materials get displayed in the crafting menus.  It now supports
   more than 9 material types.

  -Items can now be made no drop by just putting "NODROP" anywhere in it's tag.
   You can also use the old method and append "_NOD" to the item's tag as well.
   As always, the first 16 characters of the tag must be the same as the resref.

  -Fixed a bug where when buying useable stacked items, they get dropped to the
   ground initially.

  -Fixed a bug with stacked items that are useable not being recreated with the
   stacked amount when recreated to get around the "NPC selling items without
   charges" bug.


  Version 0.51 - August 14, 2002
  ------------------------------
   -Script name change: ats_inc_mod_unac has been changed to ats_inc_unacq.
   Please update your module onUnAcquire event scripts if needed.

  -In addition to NPC Crafter stores being created on start up near the NPC,
   now they are also created if there isn't one and the player talks to the NPC.

  -Made pickaxes deal no damage.  Now when a player strikes an ore vein, a
   damage effect is applied instead so higher level players will not destroy ore
   veins faster.

  -Fixed the problem with the blacksmithing crafting menu not showing anything
   any options if the player has skill below iron.

  -Made it so all duplicate instances of tradeskill journals and toolboxes on a
   player are stripped when the player joins.

  -The NPC merchants now sell the basic tools that were missing in v0.50.

  Version 0.50 - August 7, 2002
  -----------------------------

  -Increased the price of cloth padding by 4x and reduced the amount needed
   in recipes by 4 as well.

  -Fixed an incorrect entry in the crafting menus that was causing
   invalid token to be displayed occasionally.

  -Added Polar Bear, Black Bear, Grizzly Bear, Panther, White Stag, Crag
   Cat, Black Bat and Winter Wolf as skinnable animals as well as 7 new pelts
   and 6 new hide types.

  -Added a tanner's sewing kit that allows them to make special bags.

  -Tanners can now make special miner's bags(3 varieties right now).  When a
   miner has this in his inventory and he finds ore, the ore will automatically
   get moved into this special bag. Then the entire bag can be placed on the
   forge to be smelted. Currently, the bag is not consumed but may be in the
   future.  This all depends on how successful tanners get at making these and
   what they can charge for them.

  -Ore veins placeables now only produce one type of ore. Also added ore veins
   for the three new metal types.

  -You can now set multiple racial restrictions in a recipe. Just call the
   ATS_Recipe_SetRacialRestriction multiple times.

  -You can now set class and alignment restrictions as well in recipes.

  -Changed the blueprint tags and resref of the NPC merchants and stores.
   Please delete the old ones when installing this version.

  -You no longer have to place the stores with the NPC merchants.  The
   appropriate one will automatically get generated when the module loads.

  -Added the ability to create "bundles" of resources.  This allows players to
   buy resources in bulk from NPCs.  (A big thanks to Marc from Richterm's
   Retreat for this idea and his original implentation!)  When creating new
   resources that you want as bulk, in the quality field put the character "B"
   and append to the end of the tag the amount of the original resource you
   want this to represent.

   For example, the tag for the bulk version of oak logs is ATS_R_WOOD_B_OAK_5
   The 5 is the number of logs that the player will get if he or she uses the
   bundle. You will also have to add the property cast spell: unique power self
   only and make the item have 1 charge.

   Now players just have to use the bundled item and they get the approriate
   number of resources.

  -Created a workaround for the bug where NPCs selling unlimited items with
   things that cast spells not having any charges when bought.

  -Separated the player vendor into its own .ERF file.  If you choose to install
   the player vendor, just import it in but do not overwrite any files when
   importing.

  -Introduced three new metal types - Mithral, Adamantine, and Myrkandite.
   Place these in your world sparingly since they are supposed to be extremely
   rare metals.  Adamantine is actually only found in meteorites according to
   D&D lore.  And Myrkandite is even stronger than Adamantine. You can read
   about it at: http://www.darkwood.org/sj/unofficial/equip/myrkandite.html

  -Adjusted the min/max bonus scale for material types

  -Adjusted the min/max skill levels for armor. I basically shifted the scale
   so that I could fit the new metal types in better.

  -Made copper the base material type.  Iron is now after bronze in difficulty.
   Please make note of this and change any custom item properties accordingly.

  -Custom Recipes now correctly overwrite default recipes if you use the same ID
   numbers.

  -Added the skinning knife recipe which I overlooked in the previous update.

  -Made it so adding new recipes to the custom recipe file NO LONGER requires a
   rebuild of the module.  When changing stuff in the ats_config you will still need
   to rebuild for now.  I will be changing this in the next version.

  -Reorganized and cleaned up scripts.  This has resulted in a drastic improvement
   on build times as well as a big reduction in the .ERF file size.

  *IMPORTANT* - You must remove all old scripts and follow the
   new Readme install instructions. The onActivatedItem function has changed.

  -Fixed a bug when salvaging more than 10 ingots that made it only produce 10.

  -Made skill tokens unidentified with a lore of 60 needed and only useable
   by vermin so that people don't automatically use them as bullets when
   they run out of ammo.

  -Fixed a bug where skinning caused items in hand to sometimes get destroyed.

  -Fixed the weight on the Ruined Medium Leather Hide and Ruined Small Leather Hide.

  Version 0.49 - July 31, 2002
  ----------------------------

  -Made the custom token offsets sequential instead of random. This should
   help reduce the name collision when displaying the crafted item's success
   or failure.(I hope)

  -Made the categories that get displayed in the crafting menus configurable
   in the ats_config script.  These categories are what are shown like
   "Body Armor" or "Blades".  When creating new recipes and items, remember
   the category number.  This is the first number of the base tag that goes
   on an item's tag.  Example: ATS_C_A180_N_IRO.  The "1" is the category
   number. The "80" is the ID.

  -Changed some recipes.  Please look at the recipe files if you want to
   familiarize with the changed components for the default items. These will
   mostly likely keep changing as we near the public release.
   You can also send me submissions of your own custom recipes and item
   blueprints so that I can include them into the system as default recipes.
   Thanks!

  -Added two new recipe functions:
  // This function creates another recipe for the same item base tag(meaning
  // same category and ID). You can use this to create alternate components
  // needed to make the same item OR to make items of the same type but
  // different material and require different components. You must call this
  // function after a new recipe has been created or after another alternate
  // recipe has been added.
  //
  // Parameters: sRecipeName - Name to display in menu
  //             bDisplay - TRUE if you want to Display this recipe separate
  //                        in the menu
  //                        FALSE if you just want to use the display of the
  //                        original recipe
  void ATS_Recipe_AddAlternateRecipe(string sRecipeName, int bDisplay);


  // This function creates an item when someone fails at a recipe
  // This can be called more than once to create multiple failure products
  //
  // Parameters: sProductTag - the tag of the item you wish to be created on
  //                           failure (The RESREF *must* be the same as the
  //                           first 16 letters of this tag)
  //       iChangePercent - The percent that this product will be created on a
  //       failure
  void ATS_Recipe_AddFailureProduct(string sProductTag, int iChancePercent);

  -Tanning is now in!! (Formally called leathercrafting) There are currently
   three types of leather, each with 3 different sizes.  (Cured, Tanned, and
   Hardened)  In order to make cured, you must place wood(oak) and salts along
   with a pelt into an oven(this drys out the pelt into a cured leather hide).
   Next you can place the cured leather hide into a water basin with tannic acid
   and salts to make tanned leather.  Finally, you can take that tanned leather,
   put it in the water basin with some tanning oil and beeswax to make hardened
   leather.  All the supplies can be bought off the new Tanner NPC. Eventually,
   the wood will have to be obtained from lumberjacking and the tannic acid and
   tanning oil will be obtained from alchemy. Salts and Beeswax will still need
   to be bought or found.  (this helps create money sinks)

  -Added Smoker Oven placeable for use with tanning.

  -ATS Water Basin has been updated and now is used with tanning.

  -Added Tanning NPC with default tanning items.

  -Added a trash receptable placeable object that allows people to destroy all
   items even those marked as plot

  -Added tanning materials: tanning oil, tanning salts, pelts, and an additional
   leather hide type(tanned).

  -Added skinning knives of different material types.

  -Skinnable deer, badgers, bears, and cougars are in.  You must use the custom
   blueprints of these animals and you must have a skinning knife equipped.

  -Added a sanity check for skill values when loading in skill tokens to make
   sure it isn't above max skill level and readjusts them.

  -Changed the vendor's conversation to private

  -Fixed an incorrect entry in the anvil conversation file that was causing
   incorrect items to be made.

  -Fixed a bug with the vendors sometimes not properly adjusting upkeep based on
   number of items

  -Weapons in the ats_item_pdriven.ERF were still marked as plot. I changed them
   to stolen.  (Thanks to Arameus for the heads up on this one.  I somehow
   overlooked this.)

  -For the next few updates, only ats_item_pdriven.ERF will be included.  All
   crafted items will be marked as stolen if you didn't already know.  I will be
   including the ats_item_default again once items don't change as much.

  -Fixed the chainshirt and scalemail recipes so they make the correct things
   now.


  Version 0.48 - July 28, 2002
  ----------------------------

  -Possibly fixed the forge staying locked when a player goes Link Dead. Let me
   know if your forges still stay locked.

  -Adjusted some of the default smithing tool durabilities.

  -Fixed a pricing error for player vendors causing the incorrect amount being
   given to players.

  -Redid a lot of the anvil conversation menu so that collisions happen less
   often between custom tokens. Please report if names of items still get messed
   up when crafting.

  -Added a confirmation branch in the crafting menu that asks if you want to
   make the item.

  -Fixed the bug with always succeeding on difficult items when blacksmithing
   higher than iron ingots.  Skill gain should work correctly as well.

  -Fixed a nasty exploit that allowed getting infinite money if you owned a
   vendor.

  -Corrected the vendor conversation when displaying the word "days" for single
   case.

  -Added a branch to the vendor conversation so that when you hire him he will
   tell you his price and confirm that you wish to hire him.

  -Fixed a corruption in the forge conversation file that was messing up certain
   nmenu options and preventing people from making certain items.


  Version 0.47 - July 27, 2002
  ----------------------------

  -The Open Helm was incorrectly named Chainmail Coif in the recipe file.
   This has been fixed.

  -Fixed scale mail recipe so that it now correctly accepts Cured Medium Leather.

  -Fixed the previous button in the crafting menu so it displays approriately.
   Crafting menus should be displayed properly now.  If you notice any anamolies
   please let me know.

  -Changed all items in the ats_item_pdriven.ERF to "stolen" instead of plot.
   This allow them to be sold only to merchants you choose to or not at all.
   Also allows them to be set up on player vendors...

   Here's your surpise:

  -Player vendors are in. =)  (Thanks to Razor's Pack Oxen for the inspiration.)
   You can place down one vendor and more will spawn as others hire them.
   There is still more work to be done with them but most of the functionality
   should be in.  Enjoy!  Please note that they will not be saved on server
   resets or crashes so warn your players unless you load from saves.
   There are a few options in the ats_config file to adjust the vendor fees,
   spawn time, etc.

  -There is also a function called ATS_DestroyAllVendors() which you can call
   before a server shut down which will give back all items(as long as the tag
   is the same as the resref) and gold on the vendor to the player, altough
   offline players will be SOL.  You can attach this function to a lever or
   item or just attach it to any scripts you have that shut down the server.
   After calling this, just do an ExportAllCharacters() to save the character
   files.


  Version 0.46 - July 25, 2002
  ----------------------------

  -Added an exit path in the NPC Blacksmith conversation menu.

  -Fixed the Too Many Instructions error from crafting failure consumptions.

  -Temporarily changed the Studded Leather Armor back to non-plot so that it can
   be sold on the vendor until I get leathercrafting in.

  -Added back some items to the NPC blacksmith store.  Please update your
   instance of the merchant.

  -Reduced the cost of cloth padding to 20gp.

  Version 0.45 - July 23, 2002
  ----------------------------

  -Split craftable items into its own .ERF file with 2 versions.  You will now
   find an ats_item_default.ERF which contains all default craftable items.
   You will also find ats_item_pdriven.ERF which contains the same as
   the default EXCEPT all items are marked as plot so they cannot be sold back
   to vendors.  Choose this one if you want a totally player-driven economy.
   Do not import both in.

  -Added adjustable flat failure rates.  You can change the amount in the
   ats_config file. (Thanks to Arameus for suggesting this.)

  -Added adjustable skill gain rates.  You can change the amount in the
   ats_config file. (Thanks to Arameus for suggesting this.)

  -You can now salvage armor and weapons at the forge!  This is based on your
   blacksmithing skill but does not increase the skill.

  -Added salvageable rate to the recipe function ATS_Recipe_Ingots().
   The default is 80%.

  -Added more high end armor(Splint, Banded, Half Plate, and Full Plate) and a
   new helmet.  New recipe books are coming in the next patch.

  -Bronze Ore is now called Tinstone Ore and is still smelted into Broze Ingots.

  -Fixed a bug that caused split skill tokens not being destroyed on a skill
   gain.

  -Fixed bug that crashed the server when a player attempted to trade a skill
   token.  It should now successfully destroy the token and give it back to the
   original player.  This also works for NO-DROP items as well.  Please verify
   this is working properly! (Thanks to Razor for reporting this one!)

  -Fixed bug that involved players splitting skill tokens and then being able to
   drop them.  It now destroys them when dropped and gives them back to the
   player.
  (Thanks to Razor for reporting this one!)

  -Skill tokens get automatically placed into the tradeskill toolbox now when
   onItemAcquired instead of after the token is created.

  -Changed all tags of default crafted items. Now all default items' ID values
   from the tag are in the range from 00-20. You may use 21-99 for all custom
   crafted items and recipes.  You must delete all old item blueprints from
   previous versions.

  -Changed all ingots to be worth 0 gp.  This way they cannot be sold to
   shopkeepers for cash and helps to increase player-to-player trading.

  -Started breaking up the ats_common script to make it more modular and clean
  (You must remove all old ats_ scripts before installing this new version)

  -Fixed a problem with failure consumption of components not always taking the
   right amount.

  -Changed the crafting menu system back-end. Added next and previous buttons
   for menu displays.

  -Synched the crafting success messages with the animation and menu.

  -Fixed a bug with forges remaining locked to other players if someone gets
   disconnected while using one.

  -Fixed a potential problem that would cause another person's skill values to
   appear in the anvil menu on rare occasions because of custom conversation
   token collision.  It may still happen but even more rarely now.

  SPECIAL THANKS to Arameus for testing and reporting the following bugs which
  have been fixed:

  -Fixed a problem with people simultaneously using two different anvils that
   made it display the other person's succussful item's name when a success is
   made.

  -Made it so that if your tool breaks when crafting and when it asks you if you
   want to make another and you say yes, it will tell you that you don't have
   the proper tool equipped anymore.

  -Fixed a display bug in the crafting menu that showed items more than once as
   you got more proficient in the different material types.  It will now
   correctly only display one item in the color that is linked to the easiest
   material type for that item.



  Version 0.42 - July 20, 2002
  -----------------------------
  -Persistent skill tokens now work correctly with mining.

  -Fixed persistent token bug with smelting lots of ores at once

  -Synched mining failure text better

  -Removed durability display for mining tool that slipped in version 0.41
   on accident

  -Fixed a bug that happens very rarely that caused the message about
   not having the proper components when you do to appear if you keep
   retrying quickly.


  Version 0.41 - July 19, 2002
  ----------------------------
  -Fixed the location of the flame animation in the forges.

  -Corrected a mistake in the install notes.

  -Added racial restrictions to recipes. The new command for this
   recipe option is ATS_Recipe_SetRacialRestriction(int RacialType).
   RacialType is a constant RACIAL_TYPE_* which is built into NWN.

  -Added Optional persistent tokens for skill values.  This is a backup
   normal storage of skill values on local variables.  To activate this
   change the CBOOL_PERSISTENT_SKILLS_ACTIVE constant in the ats_config
   to TRUE.  There are still issues with using tokens that I am still
   working out but for now, it offers a good compromise for people
   who do not reload from save games.

  -Fixed orevein auto-respawn.

  -Made it so others cannot use the forge if someone else is already using it.
   Test to make sure this works.

  -Added support for no-drop items. Tradeskill journal is now no-drop as
   well as the container for the persistent tokens.

  -Removed some lingering debug Print statements that were supposed to
   have been taken out.

   Thanks to everyone from Richterm's Retreat, Urath Online, and
   Age of Darkness for helping test these early versions out!  Your
   feedback has been invaluable.



  July 15, 2002
  Version 0.40 - First release of private test build

****************************************************/

void main(){}

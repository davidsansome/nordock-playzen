 /****************************************************
  Readme file
  ats_about_readme

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System v0.57 Public Beta Version***
    You may distribute this build freely as long as it remains unmodified.
    Scripts Created and System Designed
    by Mojo(Allen Sun)
    Copyright © 2002 Allen Sun

  This is a public beta version of the Ambrosia Tradeskill System.
  You may distribute this build freely as long as it remains unmodified.
  The following is some rough documentation on how to install the system and an
  outline of some important features and how they work.  This documentation will
  definitely change in future releases so keep checking this file.  Thanks
  again to all who are participating in helping me test this system!

  PLEASE READ THE ats_about_change script or VERHIST.TXT file for important
  changes. It is extremely important that you do the Build Module command
  after installing this or any update.

  Install Notes
  -------------

  The Ambrosia Trade Skill system can easily be integrated into any
  existing module.  Accompanied with this readme should be a few .ERF
  files. Follow the steps below carefully and your installation will
  be hopefully be painless.

  1)  Open up your module in the toolset.
  2)  Under the File menu, select Import.  Then find the .ERF that begins
      with the name ats_main_v### where ### is the current version number.
      Select this file to be imported.
  3)  Now save your module and reload it. All relevent files should
      now be installed in your module for use.
  4)  Under the Edit menu, select Module Properties to bring up the
      properties window.
  5)  Click on the Events tab along the top of the dialog window.
      You should now see all the module triggers.
  6)  If have a script in the OnActivateItem box, then open it up to
      edit it. If not, skip to step 8. You must add the following line
      to the very top of your script:
        #include "ats_inc_activate"

      Now include the following line at the very top of your main()
      function:

        ATS_CheckActivatedItem(GetItemActivator(), GetItemActivated(),
                    GetItemActivatedTarget(), GetItemActivatedTargetLocation());

  7)  Now save and close the script.  Skip the next step and continue
      on with step 9.
  8)  If you did not have a script in the OnActivateItem trigger, then
      select the script "ats_activateitem" for that trigger.
  9)  Next, look at the OnClientEnter trigger. If have a script in the
      OnClientEnter box, then open it up to edit it. If not, skip to
      step 11. You must add the following line to the very top of your
      script:
        #include "ats_inc_init"
      Now include the following line at the very top of your main()
      function:

        ATS_InitializePlayer(GetEnteringObject());

 10)  Save and close the script.  Skip the next step and continue
      on with step 12.
 11)  If you did not have a script in the OnClientEnter trigger, then
      select the script "ats_client_enter" for that trigger.
 12)  Look at the OnModuleLoad trigger. If have a script in the
      OnModuleLoad box, then open it up to edit it. If not, skip to
      step 14. You must add the following line to the very top of your
      script:
        #include "ats_inc_init"
      Now include the following line at the very top of your main()
      function:

        ATS_Initialize();

 13)  Save and close the script.  Skip the next step and continue
      on with step 15.
 14)  If you did not have a script in the OnModuleLoad trigger, then
      select the script "ats_module_load" for that trigger.
 15)  Next, look at OnAcquireItem trigger. If have a script in the
      OnAcquireItem box, then open it up to edit it. If not, skip to
      step 17. You must add the following line to the very top of your
      script:
        #include "ats_inc_acquire"

      Now include the following line at the very top of your main()
      function:

        ATS_OnAcquireItem(GetItemPossessor(GetModuleItemAcquired()),
                          GetModuleItemAcquired(), GetModuleItemAcquiredFrom());

 16)  Save and close the script.  Skip the next step and continue
      on with step 18.
 17)  If you did not have a script in the OnAcquireItem trigger, then
      select the script "ats_m_item_gain" for that trigger.
 18)  The next thing to do one the module properties event tab is to
      look at OnUnAcquireItem trigger. If have a script in the
      OnUnAcquireItem box, then open it up to edit it. If not, skip to
      step 20. You must add the following line to the very top of your
      script:
        #include "ats_inc_unacq"

      Now include the following line at the very top of your main()
      function:

        ATS_OnUnAcquireItem(GetModuleItemLost(), GetModuleItemLostBy(),
                            GetModuleItemAcquiredFrom());

 19)  Save and close the script.  Skip the next step and continue
      on with step 21.
 20)  If you did not have a script in the OnUnAcquireItem event, then
      select the script "ats_m_item_lost" for that event.
 21)  The last thing to do one the module properties event tab is to
      look at OnClientLeave trigger. If have a script in the
      OnClientLeave box, then open it up to edit it. If not, skip to
      step 23. You must add the following line to the very top of your
      script:
        #include "ats_inc_leave"

      Now include the following line at the very top of your main()
      function:

        ATS_ClientClose(GetExitingObject());

 22)  Save and close the script.  Skip the next step and continue
      on with step 24.
 23)  If you did not have a script in the OnClientLeave event, then
      select the script "ats_client_leave" for that event.
 24)  You may now close the module properties dialog box by clicking OK.
 25)  *OPTIONAL* - If you choose to install the default craftable items, import
      either the ats_item_default.ERF or the ats_item_pdriven.ERF now.
      The playerdriven one is the same as the default except all items are
      marked as stolen so they cannot be sold to most vendors.  This is good for
      totally player-driven economies.  Save and reload the module.
      *UPDATE* - For right now, you will only
      find ats_item_pdriven.ERF until things settle down with changes.
 26)  *OPTIONAL* - You will find another .ERF called ats_pvendor_### that
      contains the latest Player Vendor code.  If you wish to have player
      vendors in your module where players can sell their crafted items while
      they are offline, then simply import this .ERF into your module.
      Save and reload the module.
 27)  Now select the Build Module command. Ignore any compile errors related to
      ats_ scripts and then save the module.
 28)  Open up the nwnplayer.ini file with notepad.  This file can be found
      in your NWN main directory.  Add the following line to it if it's
      not already there:
        SaveCharsInSaveGame=1
      This makes sure characters and local variables on them are saved
      in the save game file.
 29)  Congratulations!  The system is now installed and ready to be set up
      for use.

  SETUP
  -----

  Under the scripts listing, you should see the following scripts:
        ats_config
        ats_recipes_cust
  You may freely edit these scripts in order to customize the system
  without too much fear of breaking anything.
  The script ats_config contains various customization options for the
  system.  Please refer to the script itself to see what you can modify.

  The script ats_recipes_cust is where you will be putting any custom
  recipes you want to create.  There is detailed explanation on how to
  do this within that file.

  Once you have customized the system to your liking, you can begin
  placing the relevent objects needed for people to interact with the
  tradeskill system.  The first thing you should do is familarize yourself
  with the new custom placeables, items, merchant, and sounds.

  Placeables:
  ----------
  There are a variety of placeable object blueprints that are
  extremely integral to the system.  If you wish to install
  mining, you will find nine Ore Veins listed under the Custom: Special:
  Custom 1 listing of placeables.  These nine represent the 12 different
  ore types.  In order to see which is which, you have to open up the
  properties of each.  The nine ore types are as follows:
    COPPER, BRONZE, IRON, SILVER, GOLD, SHADOW IRON, RUBICITE, SYENITE,
     VERDICITE, MITHRAL, ADAMANTINE, and MYRKANDITE
  Each has an increasing difficulty both to mine and smelt into ingots.

  Place these ore veins in your world as you see fit.  Some advice would be
  to place the most difficult ones like rubicite, syenite, and verdicite in
  extremely hard to get to places that are also dangerous.  Mithral, Adamantine,
  and Myrkandite are even more rare.

  The next important placeable is the ATS Forge.  It can be found under the
  custom listing of Trades & Academic & Farms.  The forge is responsible for
  turning ore into useable ingots.  You can also salvage crafted items back into
  ingots with the forge.  Place the forge anywhere you want preferably in
  blacksmith shops.

  After placing the forge down, you must add the following as well:
  In the sounds listing, under custom sounds, find the Special: Listing 1
  sounds. You should see the sounds for Large Flame, Medium Flame, Small
  Flame, and Smithy Bellows.  Place each of the flame sounds on the center
  of the forge that you just placed down.  The sounds should all be close
  to the same location and should be where the opening of the forge is.
  Next, place the smithing bellows on top of the bellows of the forge which
  is a little off of the center of the forge.
  The forge is now ready to be used by players!

  Another important placeable is the ATS Anvil.  This is responsible for
  allowing Armorcrafting and Weaponcrafting to work.  You should place this near
  where you placed the forge to make it easier for players.

  You will also find an ATS Water Basin and ATS Smoker Oven. The water basin
  is used for tanning but will also be used for blacksmithing in the future.
  The smoker oven is also used for tanning.  Place both of these near the Tanner
  NPC for easy access.


  ITEMS:
  ------
  In order for players to begin mining or blacksmithing, they must have the
  proper tools equipped.  The tools such as a pickaxe and smithing hammer can be
  found in the custom items listing under Special: Custom 2.  They are also
  available for purchase through the NPC blacksmith that is accompanied with
  this system.  Players can also make better quality versions of these tools
  themselves.

  Under custom items, Special: Custom 1, you will also find all raw and produced
  materials needed for tradeskills.

  Under custom items, Misc: Books, you will find a Tradeskill Progress Journal.
  This journal is automatically given to all players who log in.  They will be
  able to track the progress of their trade skills with this journal by just
  using it.  You will also see a few other books.  The Apprentice's Guide to
  Blacksmithing is given to players who train with the NPC blacksmith.  This
  book contains detailed instructions on how blacksmithing works and how to use
  the equipment.  You can refer to it yourself to read more about blacksmithing.
  The other books are recipe books which you can place around the world or on
  NPCs for sale.  The default NPC blacksmith included should have a few of these
  books for sale already.

  You should see a whole bunch of new armors and weapons with the prefix Crafted
  or Exceptionally Crafted.  These are all player-made items.  Exceptionally
  crafted items usually have an extra trait(usually they just weigh less) and
  sell for a little bit more as a result.  You can freely modify or delete these
  items without any other modifications to the system.

  MERCHANT:
  ---------
  Included in this system, is an Master Blacksmith Merchant blueprint.  It only
  contains items needed for blacksmithing and mining.  You should modify this
  blueprint to add other items you wish to sell.  Also, you will find the NPC
  Blacksmith blueprint as well that should be used along with this store.  The
  NPC Master Blacksmith has an attached conversation file that lets the player
  train in the basics of blacksmithing for gold.  Place these both anywhere you
  see fit.  It's best to place these near the forge and anvil so players can
  easily sell and buy items needed to craft.

  You will also find a Master Tanner NPC and shop. You need to place both of
  these if you want Tanning in your game.

  You do not need to place the store objects with the NPCs.  They will
  automatically be created on module load up.

  PLAYER VENDORS:
  ---------------

  You will find a Player Vendor NPC under Creatures->Custom->Special->Custom 1.
  You can place this player vendor anywhere and when a player hires him, another
  will spawn in that spot after a set time that is configurable in the
  ats_config_pv script.  Player vendors are used to sell items to other players
  while the player is offline.

  WAYPOINTS:
  ----------

  You will find a special waypoint with the name of "MSP_".  This is a mining
  spawn point which you can place down anywhere you want to create mineable
  rocks that produce ore or gems.  When you place these down, you must edit
  the name field to create the options for that spawn point.

  Switches must be prepended with an underscore(_)

  Switches:


  MSP_
  Tells the mining spawn control object that this waypoint is a spawn point.

  MST# - Miniumum Spawn Time in # seconds
         MST10 makes min spawn 10 seconds
  XST# - Maximum Spawn Time in # seconds

  Spawn times are between the min and max.  If they are the same then it always
  spawns in that time.  Set both to 0 for instant respawn and set MST higher
  than XST if you never want it to respawn.

  FRS# - Force a refresh spawn every # seconds
         The # must be greater than 0.

  CLU# - Creates a cluster of rocks around the waypoint
         where # is the number of rocks

  CRS  - Only respawn when the entire cluster is destroyed

  DST# - When creating a cluster, this determines the
         max distance away in meters to create the rocks

  DUR# - Durability of the rock
         DUR100 gives the rock 100 points of durability
         Set this to 0 to make it unbreakable.
         Place this immediately following an ore/gem switch
         to have different durabilities for the veins or place before
         all ore/vein switches to affect them all.

  Ore & Gem Switches
  ------------------
  You may place any many of these as you want.  If the # percentages do not
  add up to 100, then the remaining chance is for an unmineable rock.  If
  the total exceeds 100, then only the ones that come first that total 100
  will have a chance to be created.

  Ore Switches
  COP# - Produces a copper vein some # % of the time
         COP20 produces a copper vein 20% of the time
  BRO# - Produces a bronze vein
  IRO# - Produces an iron vein
  SIL# - Produces a silver vein
  GOL# - Produces a gold vein
  BLA# - Produces a shadow vein
  SYE# - Produces a syenite vein
  RUB# - Produces a rubicite vein
  VER# - Produces a verdicite vein
  MIT# - Produces a mithral vein
  ADA# - Produces an adamantine vein
  MYR# - Produces a myrkandite vein

  Gem Switches
  MAL# - Produces a malachite vein some # % of the time
         MAL20 produces a malachite vein 20% of the time
  AMY# - Produces an amethyst vein
  JDE# - Produces a jade vein
  LAZ# - Produces a lapis lazuli vein
  TRQ# - Produces a turquoise vein
  OPL# - Produces an opal vein
  OYX# - Produces an onyx vein
  PRL# - Produces a pearl vein
  SAP# - Produces a sapphire vein
  BSP# - Produces a black sapphire vein
  FOP# - Produces a fire opal vein
  RBY# - Produces a ruby vein
  EME# - Produces an emerald vein
  DIA# - Produces a myrkandite vein

  If you do not put in certain switches, then default values will be used.
  These can be found in the ats_config file.

  Now for an example: The name field
  MSP_MST300_XST600_DUR50_CLU5_DST2_OPL20_COP60_IRO20_DUR25
  would create a spawn point with a cluster of size 5 that had a 20% chance
  to spawn a opal vein with durability 50, a 60% chance to spawn a copper vein
  with durability 50, and a 25% chance to spawn an iron vein with durability 25.
  All these veins would be within 2 meters of the spawn point and would respawn
  anywhere between 300 and 600 seconds.

  SOUNDS:
  -------
  The custom sounds are the ones that you should have placed with the forge.
  Read the Placeables section above if you missed it to find out about the
  custom sounds.

  Congratulations again!  The tradeskill should now be ready to be used your by
  your hopefully eagar players.

  The following is an excerpt from the Apprentice's Guide to Blacksmithing book
  that will explain more in detail how to mine and blacksmith:

********************************************************************************
Basics of Blacksmithing

     So you want to be a blacksmith?  You must first start by being an
     apprentice.  After reading these pages, you will be on your way to be
     making a variety of different armors and weapons.  This book is divided in
     four sections.  The first will teach you about smelting ore into ingots.
     Then next section deals with how to use the anvil and crafting.  The third
     section deals with  skills and skill gain.  And finally, the last section
     will introduce more advanced topics such as salvaging crafted items.

    SECTION 1
    ----------

    Smelting Ore
         The main component of all blacksmithing recipes is the ingot, and the
         first duty of any blacksmith is to be able to make ingots.  There are
         12 different types of ingots which can be smelted from 12 different types
         of ore.  These include: copper, tinstone, iron, silver, gold, shadow
         iron, verdicite, rubicite, syenite, mithral, adamantine, and myrkandite.
         With each material type, there is an increasing difficulty both to smelt
         and to use for crafts.  Smelting will directly use your blacksmithing skill
         in determining both success and the amount of useable ingots you produce
         from an ore.

         To smelt ore, first click on the forge located in most blacksmithing
         shops. This will bring up the forge's inventory display.  Place any
         amount of ore into the forge's inventory and click "close".
         A dialogue menu will then display showing your available options.
         You can choose to immediately smelt the ore or influence your chances
         of producing ore by fanning the flames.

         There are three different levels of flame intensity.  The biggest flame
         will make the ore easier to smelt but will produce less ingots, while
         the smallest flame makes it more difficult to smelt ore, it produces
         the most ingots.  The medium flame is somewhere in the middle.  It's
         usually advisable to start with the biggest flame first when working
         with a new material type.  As your skills improve, you can lower the
         intensity of the flame.  When you are satisfied with your choice,
         select the smelt ore option and if you are skilled enough and lucky,
         you will have produced some useable ingots!

    Section 2
    ----------

    The Anvil
         The most important tool of any blacksmith is the anvil.  Now that you
         have some useable ingots, it is time to begin making some basic items.
         In order to use the anvil, you must have a smithing hammer equipped.
         Smithing hammers come in a variety of different material types and can
         be purchased from merchants or can be made through weaponcrafting.
         You will need to have the appropriate weapon proficiency in martial
         weapons, however, to equip the smithing hammer. Like all trade tools,
         smithing hammers degrade over time with use. Each material type offers
         different levels of durability.

         With your smithing hammer equipped, click on the anvil to begin
         crafting. You will see a dialogue menu come up with options to either
         craft armors or craft weapons.  Crafting armors and crafting weapons
         each use different skills.  If you want to focus on armors, select
         armor and you will see a list of different armor pieces such as body,
         head, shields, or misc. You can also experiment with  weapons.   If you
         have very little or no skill, you will have to start small.  Select the
         Misc category under armor and you should see an option in red for
         Iron Studs.  This is one of your most basic armor craftable items.
         Iron studs are used mainly in leathercrafting so although you may not
         have use for them, they can offer some easy training and can earn you
         money by selling them to other players who do need them.

         Now select the iron studs option.  You should begin to craft.  It takes
         time to craft an item.  Crafting iron studs take one iron ingot.  Make
         sure you have an iron ingot in your inventory.  If you succeed, the
         components will automatically be used up and you will get the newly
         crafted item in your inventory.  If you fail, there is a chance you
         will lose some of your components.

         If you noticed, the text for Iron Studs was in Red.  Depending on your
         skill level and the difficulty to make a certain item, the text for
         item names will appear in different colors.  Red means that the item is
         very difficult to make for your skill level. Dark blue means you still
         need some practice.  Light blue means the item is  reasonably easy to
         make.  Green means the item is trivial to make and you will usually
         succeed but not learn from the success.  Any items that you do not have
         enough skill to make, will not display until you reach a minimum level
         and then it will display as red to begin with.  Practice, practice,
         practice and some day you will see most items are green and trivial to
         you.

    Section 3
    ----------

    The Skills
         Blacksmithing mainly encompasses three skills.  The first is just
         Blacksmithing.  Blacksmithing is a secondary skill.  Secondary skills
         are skills which other skills rely on and are not as difficult to
         master. Blacksmithing is used to directly determine your success in
         smelting ore and the amount of ingots you produce.  It is also used to
         directly determine how successful you are in salvaging crafted items.
         And finally it determines how likely you to make an exceptional piece
         of armor or weapon. Exceptionally crafted items usually have better
         traits and sell for slightly more.  The next two skills are
         Armorcrafting and Weaponcrafting.

         These are primary skills and are usually more difficult to master.
         Armorcrafting directly influences what types of armor you can make,
         what materials you can work with when making them, and your success
         rates.

         Weaponcrafting does the same but for weapons and tools.

    Skill Gain
         Your skills will go up over time and with continued use.  It takes a
         lot of practice and patience to become a master blacksmith.  When you
         succeed in making an item, there is a chance your skill will increase.
         The harder the item was to make, the more likely you will see skill
         gain. There is a point, however, when an items becomes trivial to make.
         You will then no longer gain any skill from making this item and should
         move on to harder items or more difficult materials.  Even if you fail
         making a difficult item, there is a small chance you will gain skill.
         If you make an exceptional item, there is also a chance for your
         Blacksmithing skill to increase as well.

    Section 4
    ---------

    Advanced Topics
          Now that you have mastered the basics of blacksmithing, there are a
          few extra things you should now about. Blacksmithing is not all about
          just crafting basic items from different material types.  There are
          also several important things a blacksmith can do as he becomes a
          master.

    Salvaging Crafted Items
         If you find that you are losing money by selling your crafted items
         back to a merchant, you also have the option to salvage your crafted
         items.  By salvaging them, you will gain back some of the ingots needed
         to make the item.  To salvage an armor or weapon, simply click on the
         forge and place the item in the forge's inventory and close it.  You
         will see an option to salvage crafted armor or weapons.  Select this
         and depending on you Blacksmithing skill level, you will either succeed
         in which case you will gain back some of the ingots used to make the
         item or you will fail and the item will be consumed.  Failing to
         salvage an item is rare even for a beginning blacksmith.  Usually with
         little skill, you just produce less ingots from the item.  Salvaging is
         a good way to increase your skills.

    Jeweled Armor and Weapons
         More on this topic to come.

    Imbued Armor and Weapons
         More on this topic to come.


********************************************************************************


  How to edit your save game :
  ----------------------------

  This is an except taken from the Bioware NWN forums on how to properly edit
  a save game so that your players can keep their skill values if you need
  to modify the module.  As is, all skill values are saved on the player
  so make sure you have the line: SaveCharsInSaveGame=1 in your nwnplayer.ini
  file.
    ---------------------------------------------------------------------------
    Step One: Save a game. I didn't try this on the official campaign, because
    Bioware has stated that they treat the   official campaign differently then
    other modules, I tried this on my Sundabar AFLA module.

    The saved game is going to be in the nwn/saves directory. Each saved game
    has a directory under that. In the saved   game directory is the .sav file.


    Step Two: Rename the .sav file to .mod Then you will need to copy the .mod
    file into your modules directory. Once in   the modules directory, open the
    .mod file with the toolset. You have to be careful with this, as the .sav
    file will   have the name of the module. You DO NOT want to overwrite you
    existing module. BE SURE to backup the original module   before attempting
    any of this.

    Step Three: Once you have the new .mod file in your modules directory, you
    are ready to fire up the toolset and make whatever changes you need to make.

    Now while making these changes, make note of everything that you change.

    Step Four: Once you are done making the changes, export them all. This will
    create .erf file in the directory of your choice.

    Step Five: Once you have all the resources that you changed exported, then
    open that directory with windows explorer, and rename all the .erf files to
    .hak

    Step Six: Now go to the saved game directory, and rename the .mod file in
    that directory to .hak

    Step Seven: Once you have renamed that file, open it with the HakPak
    utility, located in the nwn/utils directory.

    Step Eight: Export all the items in that .hak file HAK directory that you
    will need to create in the saved game directory.

    Step Nine: Once all that information is exported, close this copy of the hak
    editor, and open a new copy. You will need to open each of the .hak files
    that you exported a few minutes ago from the toolset. Open each of these
    .hak files, and export them into the same directory that you just exported
    the contents of the saved game .hak If it asks to overwrite resources, just
    tell it yes.

    When you have finished going through each of the .hak files from the
    toolset, close the hak editor.

    Step Ten: Now reopen the saved game .hak file and remove all the resources
    that are in the file. You should have a blank file when you are done. Then
    click add, and readd all the resources that are in the HAK export directory
    that we created a minute ago. Just select them all, and then click open.
    This will add them all back, with the changed ones instead of the original
    ones from the saved game.

    Step Eleven: Once you have done that save the file. After you have saved the
    file, close the hak editor.

    Step Twelve: Now go back to windows explorer, and rename the saved game .hak
    file back to a .sav file.

    You should now be able to load the saved game with NWN and your changes
    should now be reflected.
    ---------------------------------------------------------------------------


---------------------------------------------------------------------------

  Disclaimer:  This module/add-on is not officially
  supported by Bioware or Infogrames.  Please do not
  contact them for support.  You can contact me(Mojo)
  for support, questions, or suggestions at
  mojo@worldofambrosia.com. Or visit the website at
  www.worldofambrosia.com/ats for more information.
  I am not responsible for any corruption to your modules
  and/or saves because of your use of this add-on.

  Please retain all credit information when using
  parts of this sytem such as headers and comments.
  Users are granted the right to modify the work as needed
  to function as desired in their modules.  Rights are
  granted to the end user as stated above, not to
  conflict with the agreements contained within the EULA.
  Infogrames and Bioware are the only entities granted
  unlimited rights to this system, in accordance with
  the EULA that accompanies NWN. Mucho thanks to BioWare
  for making such a great game!

  NEVERWINTER NIGHTS © 2002 Infogrames Entertainment,
  S.A. All Rights Reserved. Manufactured and marketed
  by Infogrames, Inc., New York, NY. Portions © 2002
  Bioware Corp. BioWare is a trademark of BioWare
  Corp. All Rights Reserved. Ultima Online™ ©1997
  Electronic Arts Inc. Ultima Online is a trademark
  or registered trademark of Electronic Arts Inc.
  in the U.S. and/or other countries. All rights
  reserved.

****************************************************/
void main()
{

}

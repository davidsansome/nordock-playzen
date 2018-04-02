/****************************************************
  The APTS About File
  apts_about

  Last Updated: September 22, 2002

  ***Ambrosia Persistent Token System v1.0***
    You may distribute this build freely as long as it remains unmodified.
    Scripts Created and Designed
    by Mojo(Allen Sun)
    Copyright © 2002 Allen Sun

  This system allows you to store persistent data on players as token items
  which can be carried across servers or between server shutdowns.
  You must have the Ambrosia Tradeskill System v0.60+ or the ATS compatibility
  pack v1.2+ installed in order for this token system to work because it requires
  these tokens to be no-drop/no-trade.

  Features:
    * Store booleans, integers(of any size), or floats on players persistently
      without the need for a hak pak.
    * Up to 1155 booleans, 105 integers, or 35 floats can be stored using only
      between 4 and 12 inventory spaces.
    * Carry persistent data across servers with ease.
    * Tokens are stored in special token boxes and cannot be traded or dropped.
    * Easy to use interface - Simply make calls to SetToken* and GetToken* just
      like SetLocal* and GetLocal*
    * Future versions will support storing of strings,locations, journal entries,
      and objects.

  Special Thanks
  --------------
  A big thanks to Pelemele for helping me create half of the item blueprints!
  It was tedious work but it was well worth it!  Also a big thanks to OLID from
  Daggerford for helping me do lots of tests!

  And big thanks for everyone for being patient while I get the next version of ATS
  out! =)

  Version History
  ---------------

  v1.01 - September 22, 2002
  -------------------------
   - Removed debug info that was left in accidently.

  v1.0 - September 22, 2002
  -------------------------
   - Initial Release

  Install Notes
  -------------

  You must have the Ambrosia Tradeskill System v0.60+ or the ATS compatibility
  pack v1.2+ installed in order for this token system to work properly because it
  requires these tokens to be no-drop/no-trade.  You can download ATS at:
        http://nwvault.ign.com/Files/scripts/data/1029506413380.shtml
  or the compatibility pack at:
        http://nwvault.ign.com/Files/scripts/data/1032087673608.shtml

  Included in this package, you will find three .ERFs named apts_main_v10.erf,
  apts_extra1.erf, and apts_extra2.erf.  You only need to import
  the apts_main_v10.erf for the system to work.   The other two .ERFs are for
  additional tokenss so that you can store more data.  By default, the system
  uses only 4 inventory spaces to store up to 35 integers, 385 booleans, or 11
  floats. The main pack has 385 token item blueprints.  Each additional optional
  pack adds 385 more item blueprints but also adds 35 integers, 385 booleans,
  and 12 floats.  Ignore any warnings about missing resources when importing and
  continue the import.

  You should only install the additional packs if you really need more than the
  default amount of storage because the additional item blueprints increases build
  times and module size.

  Once you are done importing you can begin using persistent tokens by first
  declaring them in the apts_declare_tok.  Although token variables can be
  declared anywhere before using them, it is best to do all your declarations
  in the apts_declare_tok script since it will get run onModuleLoad.  If you do
  not have ATS or the ATS compatibility pack installed, you will have to make
  sure the apts_declare_tok script gets run on your OnModuleLoad sript.

  To declare a token variable simply use DeclareToken* where * is the variable
  type.

  Declaration Function
  --------------------

  DeclareTokenInt("variablename", slot, signed, size);
    - This is used to declare an integer.  Replace variablename with the name
      that you wish to access this variable by.  The slot can be between 1-35 or
      higher if you have the extra packs installed.  This has to be unique. Make
      sure other declarations do not access the same slots.  Replace signed with
      TRUE if you want positive and negative integers or with FALSE if you want
      just positive.  Size indicates how large the integer can be and how many
      slots it takes up.
      ->Use APTS_SMALL_INT for small integers(about 8 times the size of a char).
        These take up 1 slot.
      ->Use APTS_MEDIUM_INT for medium integers(about 64 times the size of a short).
        These take up 2 slots.
      ->Use APTS_LARGE_INT for large integers(these are the same size as 32-bit longs).
        These take up 3 slots.
      Using the integers that take up more slots reserves the other slots.  For
      instance, if you DeclareTokenInt("test", 1, TRUE, APTS_LARGE_INT), in
      addition to slot 1 being reserved, slots 2 and 3 are also reserved and
      should not be used in other declarations.  This is because a large int
      takes up 3 slots.

  DeclareTokenBool("variablename", slot, bit_number);
    - This is used to declare a boolean.  Booleans can only two values, TRUE
      or FALSE.  Replace variablename with the name that you wish to access this
      variable by.  The slot can be between 1-35 or higher if you have the extra
      packs installed.  The bit_number can be between 0-10 and indicates which
      bit you wish to store the boolean.  The slot number is not unique in the
      case of multiple boolean declarations.  Instead, the slot and bit number
      combo should be unique.  This means you can have 11 booleans per slot.
      You need to declare each boolean for each bit of a slot in order to use
      one.

  DeclareTokenFloat("variablename", slot);
    - This is used to declare a floating point number. Replace variablename with
      the name that you wish to access this variable by.  The slot can be
      between 1-35 or higher if you have the extra packs installed.  Floats
      are represented in the 32-bit IEEE Floating Point format.  They require
      3 slots reserved.

  Below are some examples of how to use declarations:

     DeclareTokenInt("varname", 1, TRUE, APTS_SMALL_INT);
         This reserves slot 1 for a signed small integer(range from -1024 -> 1023)
         called "varname".

     DeclareTokenInt("bob", 2, FALSE, APTS_LARGE_INT);
         This reserves slots 2, 3, and 4 for a unsigned large integer
         (range from -2147483648 -> 2147483647) called "bob".

     DeclareTokenBool("test_bool", 5, 1);
         This reserves slot 5 and bit 1 for a boolean called "test_bool".

     DeclareTokenFloat("floatnum", 6);
         This reserves slots 6 through 8 for a floatint point number called
         "floatnum".

  Slot numbers range from 1 to 35 for the main install, 36 to 70 for the
  extra pack1 and 71 to 105 for the extra pack2.
  Slot numbers must be unique when declaring variables which means you cannot
  declare two different token variables using the same slot with the exception
  of booleans in which case the slot/bit combo has to be unique.
  Floats and Medium/Large integers take up more than one slot and thus
  are considered reserved and shouldnt be used in other declarations.
  Variable Types:
  Small Integers (APTS_SMALL_INT)
    Range: 0 -> 2047  (Unsigned)
           -1024 -> 1023 (Signed)
    Takes up 1 slot.
  Medium Integers (APTS_MEDIUM_INT)
    Range: 0 -> 4194303  (Unsigned)
           -2097152 -> 2097151 (Signed)
    Takes up 2 slot.
  Large Integers (APTS_LARGE_INT)
    Range: 0 -> 2147483647  (Unsigned)
           -2147483648 -> 2147483647 (Signed)
    Takes up 3 slot.
  Booleans
    Range: 0 or 1
    Takes up 1 slot.
  Floats
    Range: 0.238x10^-9 -> 4286578688 for positive numbers
          -0.4294x10^10 -> -0.2328x10^-9 for negative numbers
    Takes up 3 slot.
  --------------------

  Now that you have variables declared, you can use them anywhere in your
  scripts as long as you #include "apts_inc_ptok" at the top of your script.

  You can set variables and get variables with SetToken* and GetToken* which
  have the same format as SetLocal* and GetLocal*.

  For example, to set an integer token variable you have already declared called
  "gold" simply call SetTokenInt(oPlayer, "gold", 100);  Now to retrieve this
  you can simply call GetTokenInt(oPlayer, "gold");
  The first parameter of both SetToken* and GetToken* always has to be a player
  object since tokens are stored in inventory.  You cannot use this to store
  module wide data unless you have a special player which you always have logged
  in for this purpose.

  Please check your log file for any errors because of incorrect declarations
  or token function usage.

  If you have any comments, suggestions, or bug reports, please feel
  free to email me at mojo@worldofambrosia.com or visit the forum at:
  http://boards.stratics.com/php-bin/nwn/postlist.php?Cat=&Board=nwn_ats

  --------------------------------------------------
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
  Corp. All Rights Reserved.
****************************************************/
void main() {}

/****************************************************
  The Ambrosia Bank About File
  bank_about

  Last Updated: September 26, 2002

  ***Ambrosia Persistent Bank Demo Mod v0.5***
    You may distribute this build freely as long as it remains unmodified.
    Scripts Created and Designed
    by Mojo(Allen Sun)
    Copyright © 2002 Allen Sun

  This module demonstrates the power and versatility of the Ambrosia Persistent
  Token System.  This is a quick and dirty version of a player vault that I
  created to show off the token system.  You can store gold and most items
  persistently meaning you can shut down your server and not have to load
  from a save game.

  This version is very rough and unoptimized. There are still bugs to be worked
  out but I wanted to get this out there so others can get ideas on how to
  use the token system.  I will update this module when time permits but
  I welcome anyone to take this as a basis to make a more polished bank/player
  vault.  I just request that you give credit where credit it due.

  Items are currently stored as a hash value using only 2 tokens. I may be
  bumping this up to 3 tokens in the next version since there are a few
  hashing collisions.

  In order for an item to be stored persistently, you must place a copy of the
  item in the special Merchant object called Bank Item Templates.   All default
  Bioware items are already in there.  You will need to add all custom items
  if you want those to be saved.

  There is a limit of 15 items for storage which can be increased. You need
  to declare more variables in the ats_declare_ptok script and also change
  the constant in the bank_inc script.

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

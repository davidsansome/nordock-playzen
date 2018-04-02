/****************************************************
  Starting Condition Script : Difficulty Check
  ats_sc_cr_check

  Last Updated: July 20, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is responsible for checking to see if
  a craftable item is within a player's difficulty
  range.  If so, then the item gets displayed on
  the selection menu.
****************************************************/
#include "ats_inc_menustub"

int StartingConditional()
{
    object oPlayer = GetPCSpeaker();

    return ATS_CheckNextItemToDisplay(oPlayer);
}

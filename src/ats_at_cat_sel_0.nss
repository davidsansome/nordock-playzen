/****************************************************
  Action Taken Script : Category 0 selection
  ats_at_cat_sel_0

  Last Updated: July 29, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script sets the current craft category for a
  player.
****************************************************/
#include "ats_inc_menu"

void main()
{
    object oPlayer = GetPCSpeaker();
    ATS_SetCurrentCraftPart(oPlayer, 0);
    ATS_InitCraftArrayIndex(oPlayer);
    ATS_InitMakeableCount(oPlayer);
}

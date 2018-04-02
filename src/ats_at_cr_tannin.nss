/****************************************************
  Action Taken Script : Tanning craft type selection
  ats_at_cr_tannin

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script sets the current craft type for a
  player to tan leather.
****************************************************/
#include "ats_const_skill"
#include "ats_const_recipe"
#include "ats_inc_menu"

void main()
{
    object oPlayer = GetPCSpeaker();
    ATS_SetCurrentCraftType(oPlayer, ATS_CRAFT_TYPE_LEATHER);
    ATS_SetCurrentCraftPart(oPlayer, 1);
    SetLocalInt(oPlayer, "ats_tanning_subskill", ATS_TANNING_SUBSKILL_TANNING);

    ATS_InitCraftArrayIndex(oPlayer);
    ATS_InitMakeableCount(oPlayer);

}


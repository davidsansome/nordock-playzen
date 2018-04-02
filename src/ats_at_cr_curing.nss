/****************************************************
  Action Taken Script : Curing craft type selection
  ats_at_cr_curing

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script sets the current craft type for a
  player to tanning for curing leather.
****************************************************/
#include "ats_const_skill"
#include "ats_const_recipe"
#include "ats_inc_menu"

void main()
{
    object oPlayer = GetPCSpeaker();
    ATS_SetCurrentCraftType(oPlayer, ATS_CRAFT_TYPE_LEATHER);
    SetLocalInt(oPlayer, "ats_tanning_subskill", ATS_TANNING_SUBSKILL_CURING);
    ATS_SetCurrentCraftPart(oPlayer, 0);
    ATS_InitCraftArrayIndex(oPlayer);
    ATS_InitMakeableCount(oPlayer);
}


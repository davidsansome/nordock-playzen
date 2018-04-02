/****************************************************
  Action Taken Script : Hardening craft type selection
  ats_at_cr_harden

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script sets the current craft type for a
  player to harden leather.
****************************************************/
#include "ats_const_recipe"
#include "ats_const_skill"
#include "ats_inc_menu"

void main()
{
    object oPlayer = GetPCSpeaker();
    ATS_SetCurrentCraftType(oPlayer, ATS_CRAFT_TYPE_LEATHER);
    ATS_SetCurrentCraftPart(oPlayer, 2);
    SetLocalInt(oPlayer, "ats_tanning_subskill", ATS_TANNING_SUBSKILL_HARDENING);
    ATS_InitCraftArrayIndex(oPlayer);
    ATS_InitMakeableCount(oPlayer);
}


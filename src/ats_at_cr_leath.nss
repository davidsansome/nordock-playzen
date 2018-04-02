/****************************************************
  Action Taken Script : Leather craft type selection
  ats_at_cr_leath

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script sets the current craft type for a
  player to tanning or leathercrafing/tailoring.
****************************************************/
#include "ats_const_recipe"
#include "ats_inc_menu"

void main()
{
    ATS_SetCurrentCraftType(GetPCSpeaker(), ATS_CRAFT_TYPE_LEATHER);
}


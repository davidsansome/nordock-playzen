/****************************************************
  Action Taken Script : Weapon craft type part selection
  ats_at_cr_weapon

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script sets the current craft type for a
  player to weaponcrafting.
****************************************************/
#include "ats_const_recipe"
#include "ats_inc_menu"

void main()
{
    ATS_SetCurrentCraftType(GetPCSpeaker(), ATS_CRAFT_TYPE_WEAPON);
}

/****************************************************
  Starting Condition Script : Material Difficulty Check
  ats_sc_mat_check

  Last Updated: August 15, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is responsible for checking to see if
  a craftable item and material is within a player's
  difficulty range.  If so, then the material gets
  displayed on the selection menu.
****************************************************/
#include "ats_inc_menustub"

int StartingConditional()
{
    object oPlayer = GetPCSpeaker();

    return ATS_CheckNextMaterialToDisplay(oPlayer);
}

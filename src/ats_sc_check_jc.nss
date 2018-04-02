/****************************************************
  Starting Condition Script : Check Jewelcrafting skill
  ats_sc_check_jc
  Last Updated: 25 August 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)
    Assisted by Pelemele Malef'carum (Shawn Perreault)

  This script checks the player's blacksmithing skill
  to see if he can still be taught the basics.
****************************************************/
#include "ats_inc_common"
#include "ats_const_skill"


int StartingConditional()
{
    object oPlayer = GetPCSpeaker();
    if(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_JEWELCRAFTING) > 0)
        return FALSE;
    else
        return TRUE;
}

/****************************************************
  Starting Condition Script : Check Leathercrafting skill
  ats_sc_check_lc

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script checks the player's leathercrafting skill
  to see if he can still be taught the basics.
****************************************************/
#include "ats_inc_common"
#include "ats_const_skill"

int StartingConditional()
{
    object oPlayer = GetPCSpeaker();
    // Edited by Jarketh Thavin to ensure functionality
    // The following line is the only original line
    // return (ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_TANNING) > 0);
    if(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_TANNING) > 0)
        return TRUE;
    else
        return FALSE;
}

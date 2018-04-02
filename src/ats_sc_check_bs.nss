/****************************************************
  Starting Condition Script : Check Blacksmithing skill
  ats_sc_check_bs

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script checks the player's blacksmithing skill
  to see if he can still be taught the basics.
****************************************************/
#include "ats_inc_common"
#include "ats_const_skill"


int StartingConditional()
{
    object oPlayer = GetPCSpeaker();
    if(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_BLACKSMITHING) > 0)
        return FALSE;
    else
        return TRUE;
}

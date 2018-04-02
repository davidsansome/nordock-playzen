/****************************************************
  Starting Condition Script : Previous Display Check
  ats_sc_cr_prev

  Last Updated: July 26, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is responsible for checking to see if
  there are previous recipes to be displayed so that
  the previous button is active.
****************************************************/

#include "ats_inc_menu"
int StartingConditional()
{
    object oPlayer = GetPCSpeaker();

    if( ATS_GetMakeableCount(oPlayer) > 6 )
        return TRUE;
    else
        return FALSE;

}

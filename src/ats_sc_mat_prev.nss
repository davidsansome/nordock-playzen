/****************************************************
  Starting Condition Script : Previous Display Check
  ats_sc_cr_prev

  Last Updated: August 15 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is responsible for checking to see if
  there are previous recipes to be displayed so that
  the previous button is active.
****************************************************/

#include "ats_inc_menu_mat"
int StartingConditional()
{
    object oPlayer = GetPCSpeaker();

    if( ATS_GetMaterialMakeableCount(oPlayer) > 6 )
        return TRUE;
    else
        return FALSE;

}

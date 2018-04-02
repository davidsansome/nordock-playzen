/****************************************************
  Starting Condition Script : Next Material Check
  ats_sc_cr_next

  Last Updated: August 15 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is responsible for checking to see if
  there are more materials to be displayed so that
  the next button is active.
****************************************************/

#include "ats_inc_menu_mat"
int StartingConditional()
{
    object oPlayer = GetPCSpeaker();

    if( ATS_GetMaterialArrayIndex(oPlayer) < ATS_GetMaterialArraySize(oPlayer) )
        return TRUE;
    else
        return FALSE;

}

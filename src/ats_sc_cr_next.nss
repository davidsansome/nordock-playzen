/****************************************************
  Starting Condition Script : Next Display Check
  ats_sc_cr_next

  Last Updated: July 20, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is responsible for checking to see if
  there are more recipes to be displayed so that
  the next button is active.
****************************************************/

#include "ats_inc_menu"
int StartingConditional()
{
    object oPlayer = GetPCSpeaker();
    string sCurrentCraftType = ATS_GetCurrentCraftType(oPlayer);
    int iCurrentCraftPart = ATS_GetCurrentCraftPart(oPlayer);

    if( ATS_GetCraftArrayIndex(oPlayer) <
        ATS_GetCraftArraySize(sCurrentCraftType, iCurrentCraftPart) )
        return TRUE;
    else
        return FALSE;

}

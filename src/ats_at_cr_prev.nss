/****************************************************
  Actions Taken Script : Previous Display
  ats_at_cr_prev

  Last Updated: July 20, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is responsible for advancing the menu
  to the next display.
****************************************************/

#include "ats_inc_menu"
void main()
{
    object oPlayer = GetPCSpeaker();
    string sCurrentCraftType = ATS_GetCurrentCraftType(oPlayer);
    int iCurrentCraftPart = ATS_GetCurrentCraftPart(oPlayer);

    int iArraySize = ATS_GetCraftArraySize(sCurrentCraftType, iCurrentCraftPart);
    int iCurrentIndex = ATS_GetCraftArrayIndex(oPlayer);

    int iMakeableCount = ATS_GetMakeableCount(oPlayer);
    if(iMakeableCount > 0)
    {
        int iCountAdjustment = iMakeableCount % 6;
        if(iCountAdjustment == 0)
            iCountAdjustment = 6;
        ATS_SetMakeableCount(oPlayer, iMakeableCount - iCountAdjustment - 6);
    }

    ATS_SetCraftArrayIndex(oPlayer, GetLocalInt(oPlayer, "ats_prev_craft_arrayindex"));
}


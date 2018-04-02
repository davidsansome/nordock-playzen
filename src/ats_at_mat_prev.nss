/****************************************************
  Actions Taken Script : Previous Display
  ats_at_cr_prev

  Last Updated: August 15 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is responsible for advancing the menu
  to the next display.
****************************************************/

#include "ats_inc_menu_mat"
void main()
{
    object oPlayer = GetPCSpeaker();

    int iArraySize = ATS_GetMaterialArraySize(oPlayer);
    int iCurrentIndex = ATS_GetMaterialArrayIndex(oPlayer);

    int iMakeableCount = ATS_GetMaterialMakeableCount(oPlayer);
    if(iMakeableCount > 0)
    {
        int iCountAdjustment = iMakeableCount % 6;
        if(iCountAdjustment == 0)
            iCountAdjustment = 6;
        ATS_SetMaterialMakeableCount(oPlayer, iMakeableCount - iCountAdjustment - 6);
    }

    ATS_SetMaterialArrayIndex(oPlayer, GetLocalInt(oPlayer, "ats_prev_craftmat_arrayindex"));
}


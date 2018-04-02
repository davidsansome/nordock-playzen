/****************************************************
  Action Taken Script : Item Selection 1
  ats_at_cr_sel_01

  Last Updated: August 15 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script responds to an craftable item selection
  by grabbing the craft tag of the item selected.
****************************************************/
#include "ats_inc_menustub"

void main()
{
    object oPlayer = GetPCSpeaker();

    string sCraftTag = ATS_GetCraftItemFromDisplayList(oPlayer, 5);

    ATS_SetCurrentCraftTag(oPlayer, sCraftTag);
    ATS_InitMaterialArrayIndex(oPlayer);
    ATS_InitMaterialMakeableCount(oPlayer);
    ATS_BuildMaterialList(oPlayer);

    int iStartIndex = GetLocalInt(oPlayer, "ats_start_craft_arrayindex");
    SetLocalInt(oPlayer, "ats_current_craft_arrayindex", iStartIndex);

    int iMakeableCount = ATS_GetMakeableCount(oPlayer);
    if(iMakeableCount > 0)
    {
        int iCountAdjustment = iMakeableCount % 6;
        if(iCountAdjustment == 0)
            iCountAdjustment = 6;
        ATS_SetMakeableCount(oPlayer, iMakeableCount - iCountAdjustment);
    }

}

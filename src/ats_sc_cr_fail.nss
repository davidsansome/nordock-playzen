/****************************************************
  Starting Condition Script : Failed Crafting
  ats_sc_cr_fail

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script sets the custom token display for
  the failed item.

***************************************************/

#include "ats_inc_common"
#include "ats_const_common"
#include "ats_const_mat"
#include "ats_inc_menu"
#include "ats_inc_material"

int StartingConditional()
{
    object oPlayer = GetPCSpeaker();
    int iTokenOffset = ATS_GetTokenOffset(oPlayer);
    int iTokenOffsetCount = GetLocalInt(oPlayer, "ats_token_offset_count");

    if(ATS_GetTokenOffset(oPlayer) == iTokenOffsetCount)
    {
        string sCraftTag = ATS_GetCurrentCraftTag(oPlayer);
        int iMaterialType = ATS_GetCurrentCraftMaterial(oPlayer);
        string sItemTag = ATS_CraftToItemTag(sCraftTag, CSTR_QUALITY_NORMAL, ATS_GetMaterialTag(iMaterialType));
        if(GetIsObjectValid(GetObjectByTag(sItemTag)) == FALSE)
            sItemTag = GetLocalString(GetModule(), sItemTag);
        // Sets the custom tag
        SetCustomToken(55091 + iTokenOffset, GetName(GetObjectByTag(sItemTag)));

        return TRUE;
    }
    else
        return FALSE;
}

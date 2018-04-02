/****************************************************
  Starting Condition Script : Material List Display
  ats_sc_cr_mdisp

  Last Updated: July 30, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is responsible resetting the material
  display list and building the material tags so
  that the material types can be displayed after item
  selection.
****************************************************/

#include "ats_inc_menustub"

int StartingConditional()
{
    object oPlayer = GetPCSpeaker();

    string sCraftTag = ATS_GetCurrentCraftTag(oPlayer);
    if(ATS_IsCraftSingleType(sCraftTag) == TRUE)
    {
        int iMaterialType = ATS_GetMaterialTypeFromTag(ATS_GetCraftSingleTypeTag(sCraftTag));
        ATS_SetCurrentCraftMaterial(oPlayer, iMaterialType);
        return FALSE;
    }

    ATS_ResetMaterialDisplayList(oPlayer);
    ATS_InitDisplayCount(oPlayer);
    int iCurrentIndex = ATS_GetMaterialArrayIndex(oPlayer);
    SetLocalInt(oPlayer, "ats_start_craftmat_arrayindex", iCurrentIndex);
    return TRUE;
}

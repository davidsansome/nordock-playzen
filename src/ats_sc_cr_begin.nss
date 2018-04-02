/****************************************************
  Starting Condition Script : Begin Crafting
  ats_sc_cr_begin

  Last Updated: July 27, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script begins the crafting process and checks
  for success.
****************************************************/

#include "ats_inc_cr_begin"


int StartingConditional()
{
    object oPlayer = GetPCSpeaker();
    int iTokenOffsetCount = GetLocalInt(oPlayer, "ats_token_offset_count");

    iTokenOffsetCount += 100;
    SetLocalInt(oPlayer, "ats_token_offset_count", iTokenOffsetCount);

    if(ATS_GetTokenOffset(oPlayer) == iTokenOffsetCount)
    {
        string sCraftTag = ATS_GetCurrentCraftTag(oPlayer);
        int iMaterialType = ATS_GetCurrentCraftMaterial(oPlayer);

        int iReturnValue = BeginCrafting(oPlayer, sCraftTag, iMaterialType, 4.0);
        return iReturnValue;
    }
    else
        return FALSE;
}

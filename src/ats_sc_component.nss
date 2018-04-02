/****************************************************
  Starting Condition Script : Component check
  ats_sc_component

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is responsible for checking to see if
  the player has all the components needed to make
  an item.
****************************************************/
#include "ats_inc_common"
#include "ats_const_mat"
#include "ats_const_common"
#include "ats_config"
#include "ats_inc_menu"
#include "ats_inc_material"
#include "ats_inc_cr_get"
#include "ats_inc_cr_comp"

int StartingConditional()
{
    int iResult;
    object oPlayer = GetPCSpeaker();
    int iCraftMaterial = ATS_GetCurrentCraftMaterial(oPlayer);
    string sCraftTag = ATS_GetCurrentCraftTag(oPlayer);
    iResult = ATS_CheckCraftComponentsOnPlayer(oPlayer, sCraftTag, iCraftMaterial);
    while(iResult == FALSE && ATS_GetNextLinkedCraftTag(sCraftTag) != "")
    {
        sCraftTag = ATS_GetNextLinkedCraftTag(sCraftTag);
        iResult = ATS_CheckCraftComponentsOnPlayer(oPlayer, sCraftTag, iCraftMaterial);
    }
    if(iResult == TRUE)
    {
        ATS_SetCurrentCraftTag(oPlayer, sCraftTag);
        return FALSE;   // Do not display failure message
    }
    else
        return TRUE;    // Display failure message
}

/****************************************************
  Starting Condition Script : Confirm Selection 1
  ats_sc_confirm_1

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is responsible for filling the custom
  tokens after a selection has been made to make
  sure this was the correct selection.
****************************************************/
#include "ats_const_common"
#include "ats_const_mat"
#include "ats_inc_material"
#include "ats_inc_cr_get"
#include "ats_inc_menu"

int StartingConditional()
{
    object oPlayer = GetPCSpeaker();
    string sCraftTag = ATS_GetCurrentCraftTag(oPlayer);
    string sCraftName = ATS_GetCraftName(sCraftTag);

    SetCustomToken(55045, sCraftName);
    return TRUE;
}

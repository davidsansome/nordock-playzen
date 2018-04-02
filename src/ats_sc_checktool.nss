/****************************************************
  Starting Condition Script : Tool Check
  ats_sc_component

  Last Updated: July 20, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is responsible for checking to see if
  the player has the proper tool equipped to make
  the item.
****************************************************/

#include "ats_inc_common"
#include "ats_inc_constant"
#include "ats_config"
#include "ats_inc_material"
#include "ats_inc_tool"
#include "ats_inc_menu"
#include "ats_inc_skill"

int StartingConditional()
{
    object oPlayer = GetPCSpeaker();
    string sCraftTag = ATS_GetCurrentCraftTag(oPlayer);
    string sTradeskillName = ATS_GetTradeSkillFromCraftTag(sCraftTag);
    object oCraftTool = ATS_GetToolForCraft(oPlayer, sTradeskillName);
    return (!GetIsObjectValid(oCraftTool));

}

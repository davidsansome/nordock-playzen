/****************************************************
  On Avil Use Script
  ats_anvil_use

  Last Updated: August 18, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script should be placed on the custom anvil's
  OnUsed trigger.  This script checks to make sure
  the player has the blacksmith skill and has the
  proper smithing tool.  If so, it starts the anvil
  conversation menu.
****************************************************/
#include "ats_inc_common"
#include "ats_const_common"
#include "ats_const_skill"
#include "ats_const_mat"
#include "ats_const_recipe"
#include "ats_config"
#include "ats_inc_skill"
#include "ats_inc_material"
#include "ats_inc_tool"

void main()
{
    object oPlayer = GetLastUsedBy();
    // Check to make sure the player doesn't have no skill in blacksmithing
    if(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_BLACKSMITHING) <= 0)
        FloatingTextStringOnCreature("You do not know how to use this.", oPlayer, FALSE);
    // Check to make sure the proper tool is equipped
    else if(ATS_GetToolForCraft(oPlayer, CSTR_SKILLNAME_BLACKSMITHING) == OBJECT_INVALID)
        FloatingTextStringOnCreature("You do not have the proper tool equipped to use this.",
                                     oPlayer, FALSE);
    else if(IsInConversation(OBJECT_SELF) == TRUE)
        FloatingTextStringOnCreature(CSTR_ERROR1_INUSE, oPlayer, FALSE);
    else
        ActionStartConversation( GetLastUsedBy(), "", TRUE);
}

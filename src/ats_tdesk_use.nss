/****************************************************
  On Jeweler's Desk Use Script
  ats_anvil_use

  Last Updated: August 17, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script should be placed on the custom fletching
  desk's OnUsed trigger.  This script checks to make sure
  the player has the fletching skill and has the
  proper fletching tool.  If so, it starts the
  fletching conversation menu.
***********************************************/
#include "ats_inc_common"
#include "ats_inc_constant"
#include "ats_config"
#include "ats_inc_skill"
#include "ats_inc_material"
#include "ats_inc_tool"
#include "ats_inc_menu"

void main()
{
    object oPlayer = GetLastUsedBy();
    // Check to make sure the player doesn't have zero skill in fletching
    if(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_TAILOR) <= 0)
        FloatingTextStringOnCreature("You do not know how to use this.", oPlayer, FALSE);
    // Check to make sure the proper tool is equipped
    else if(ATS_GetToolForCraft(oPlayer, CSTR_SKILLNAME_TAILOR) == OBJECT_INVALID)
        FloatingTextStringOnCreature("You do not have the proper tool equipped to use this.",
                                     oPlayer, FALSE);
    else if(IsInConversation(OBJECT_SELF) == TRUE
            && IsInConversation(GetLocalObject(OBJECT_SELF, "ats_converser")) == TRUE)
        FloatingTextStringOnCreature(CSTR_ERROR1_INUSE, oPlayer, FALSE);
    else
    {
        SetLocalObject(OBJECT_SELF, "ats_converser", oPlayer);
        ClearAllActions();
        ATS_SetCurrentCraftType(oPlayer, ATS_CRAFT_TYPE_TAILOR);
        ActionStartConversation( GetLastUsedBy(), "", TRUE);
    }
}

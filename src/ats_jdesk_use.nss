/****************************************************
  On Jeweler's Desk Use Script
  ats_anvil_use

  Last Updated: August 17, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script should be placed on the custom jeweler
  desk's OnUsed trigger.  This script checks to make sure
  the player has the jewelcrafting skill and has the
  proper jewelcrafting tool.  If so, it starts the
  jewelcrafting conversation menu.
****************************************************/
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
    // Check to make sure the player doesn't have no skill in blacksmithing
    if(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_JEWELCRAFTING) <= 0)
        FloatingTextStringOnCreature("You do not know how to use this.", oPlayer, FALSE);
    // Check to make sure the proper tool is equipped
    else if(ATS_GetToolForCraft(oPlayer, CSTR_SKILLNAME_JEWELCRAFTING) == OBJECT_INVALID)
        FloatingTextStringOnCreature("You do not have the proper tool equipped to use this.",
                                     oPlayer, FALSE);
    else if(IsInConversation(OBJECT_SELF) == TRUE
            && IsInConversation(GetLocalObject(OBJECT_SELF, "ats_converser")) == TRUE)
        FloatingTextStringOnCreature(CSTR_ERROR1_INUSE, oPlayer, FALSE);
    else
    {
        SetLocalObject(OBJECT_SELF, "ats_converser", oPlayer);
        ClearAllActions();
        ATS_SetCurrentCraftType(oPlayer, ATS_CRAFT_TYPE_JEWELCRAFT);
        ActionStartConversation( GetLastUsedBy(), "", TRUE);
    }
}

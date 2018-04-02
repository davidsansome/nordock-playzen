/****************************************************
  Smoker On Use Script
  ats_smoker_use

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script should be placed on the custom smoker
  oven's OnUsed trigger.  This script checks to make sure
  the player has basic tanning skills. If so, it
  starts the smoker conversation menu.
****************************************************/

#include "ats_inc_common"
#include "ats_const_common"
#include "ats_const_skill"

void main()
{
    object oPlayer = GetLastUsedBy();
    // Check to make sure the player doesn't have no skill in tanning
    if(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_TANNING) <= 0)
        FloatingTextStringOnCreature("You are not sure how to use this.", oPlayer, FALSE);
    else if(IsInConversation(OBJECT_SELF) == TRUE
            && IsInConversation(GetLocalObject(OBJECT_SELF, "ats_converser")) == TRUE)
        FloatingTextStringOnCreature(CSTR_ERROR1_INUSE, oPlayer, FALSE);
    else
    {
        SetLocalObject(OBJECT_SELF, "ats_converser", oPlayer);
        ClearAllActions();
        ActionStartConversation( GetLastUsedBy(), "", TRUE);
    }
}

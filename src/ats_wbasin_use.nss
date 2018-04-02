/****************************************************
  Water Badin On Use Script
  ats_wbasin_use

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script should be placed on the custom water
  basin's OnUsed trigger. It starts the conversation
  menu.
****************************************************/
#include "ats_const_common"
void main()
{
    object oPlayer = GetLastUsedBy();
    if(IsInConversation(OBJECT_SELF) == TRUE
            && IsInConversation(GetLocalObject(OBJECT_SELF, "ats_converser")) == TRUE)
        FloatingTextStringOnCreature(CSTR_ERROR1_INUSE, oPlayer, FALSE);
    else
    {
        SetLocalObject(OBJECT_SELF, "ats_converser", oPlayer);
        ClearAllActions();
        ActionStartConversation( GetLastUsedBy(), "", TRUE);
    }
}

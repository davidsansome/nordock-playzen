/****************************************************
  Forge OnUsed Script
  ats_forge_use

  Last Updated: August 20, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script goes on the forge's OnUsed trigger.
  It locks the forge if the forge is already
  being used.
****************************************************/
#include "ats_inc_common"


void main()
{
    object oLastUser = GetLastUsedBy();
    object oCurrentUser =  GetLocalObject(OBJECT_SELF, "ats_current_user");
    string sCurrentUserName =  GetLocalString(OBJECT_SELF, "ats_current_username");

    int iTimesUsed = GetLocalInt(OBJECT_SELF, "ats_onused");

    if(oCurrentUser != oLastUser && GetLocked(OBJECT_SELF) == TRUE && GetIsObjectValid(oCurrentUser) == TRUE
       && GetDistanceBetween(OBJECT_SELF, oCurrentUser) < 3.0)
    {
        //Case: Player tries to open a forge while it is already opened by
        //      another player
        DEBUG_PrintString("Forge is locked and " + GetName(oLastUser) + " is trying to open it");
        FloatingTextStringOnCreature("The forge is already in use.", oLastUser, FALSE);
        return;

    }
    else
        ++iTimesUsed;

    if(iTimesUsed == 1)
    {   /*
        if(sCurrentUserName == "")
        {
        // Case: Forge is opened for the first time.
        // Do Nothing
        }
        else if(GetIsObjectValid(oCurrentUser) == FALSE || GetDistanceBetween(OBJECT_SELF, oCurrentUser) >= 5.0)
        {
            SetLocked(OBJECT_SELF, FALSE);
            iTimesUsed = 0;
            SetLocalObject(OBJECT_SELF, "ats_current_user", OBJECT_INVALID);
            SetLocalString(OBJECT_SELF, "ats_current_username", "");
        }  */

        //Case: Forge was not in use and has now been opened
        DEBUG_PrintString("Forge was not in use and has now been opened by " + GetName(oLastUser));

        SetLocalObject(OBJECT_SELF, "ats_current_user", oLastUser);
        SetLocalString(OBJECT_SELF, "ats_current_username", GetName(oLastUser));
        SetLocked(OBJECT_SELF, TRUE);
        SetLocalInt(OBJECT_SELF, "ats_onused", iTimesUsed );
    }
    else if(iTimesUsed == 2)
    {
        if(GetLocked(OBJECT_SELF) == TRUE &&
           (GetIsObjectValid(oCurrentUser) == FALSE ||
           GetDistanceBetween(OBJECT_SELF, oCurrentUser) >= 3.0))
        {
            // Case: Forge was bugged and is being reset
            DEBUG_PrintString("Forge was bugged and is being reset");

            SetLocked(OBJECT_SELF, FALSE);
            SetLocalObject(OBJECT_SELF, "ats_current_user", OBJECT_INVALID);
            SetLocalString(OBJECT_SELF, "ats_current_username", "");
            FloatingTextStringOnCreature("The forge has been reset.  Please try again.", oLastUser, FALSE);
        }
        else
        {
            // Case: Forge has been validly closed
            DEBUG_PrintString(" Forge has been validly closed by " + GetName(oLastUser));
            SetLocked(OBJECT_SELF, FALSE);
            ClearAllActions();
            ActionStartConversation( oLastUser, "", TRUE);
        }
        SetLocalInt(OBJECT_SELF, "ats_onused", 0 );
    }


}

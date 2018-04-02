// hc_on_cl_leave
// Archaegeo 2002 aug 10
// Now supports the PWDB saving system

#include "hc_inc"
#include "hc_inc_on_leave"
#include "ats_inc_leave"
#include "nw_i0_tool"


void PWDB_SaveCurrentLocation(object oClient)
{
    if (!GetIsPC(oClient))
        return;
}

void main()
{
    object oPC = GetExitingObject();
    object oMod = GetModule();
    string sCDK=GetPCPublicCDKey(oPC);
    string sName=GetName(oPC);
    string sID=sName+sCDK;
    // Handles reset vote counters
    if(GetLocalInt(oMod, "Reset"+GetPCPublicCDKey(oPC)) == TRUE)
    {
    int iVotes = GetLocalInt(oMod, "Reset");
    SetLocalInt(oMod, "Reset"+GetPCPublicCDKey(oPC), FALSE);
    SetLocalInt(oMod, "Reset", iVotes -= 1);
    }
//Added to save 40% of the time to reduce lag - Grug 08/10/2003
//Another chanced save is in hc_resting_inns script
//    if (d10()<=4)
//    {
//        ExportAllCharacters();
//        // ===== This is code for fixing shifters =====
//        object oPCSF = GetFirstPC();
//        while ( GetIsObjectValid(oPCSF) ) // Loop through all the Players
//        {
//            if ( GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCSF)) )
//                DelayCommand(0.1, ExecuteScript("ws_saveall_sub", oPCSF));
                // We HAVE to use DelayCommand here or else properties will not carry over no matter what you do.

//            oPCSF = GetNextPC();
//        } // while
//    }
ExportSingleCharacter(oPC);


    PWDB_SaveCurrentLocation(oPC);
    if(!preEvent()) return;
    if (HasItem(oPC,"SoulFrag_NOD"))
        SetLocalInt(oPC,"SOULFRAG"+sID,TRUE);
    if (!HasItem(oPC,"SoulFrag_NOD")&&GetLocalInt(oMod,"SOULFRAG"+sID))
        CreateItemOnObject("soulfrag_nod",oPC,1);
    ATS_ClientClose(GetExitingObject());
    postEvent();
}

//::///////////////////////////////////////////////
//:: FileName tuck_prior
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/13/2002 10:17:18 PM
//:://////////////////////////////////////////////


#include "hc_inc"

int StartingConditional()
{

    object oMod = GetModule();

    object oPC = GetPCSpeaker();
    string sCDK=GetPCPublicCDKey(oPC);
    string oName=GetName(oPC);

    string sID=sCDK+oName;

    // Inspect local variables
    if(!(GetLocalInt(oMod, "cohort"+sID) == 1))
        return FALSE;

    return TRUE;
}

//::///////////////////////////////////////////////
//:: FileName tuck_set_prior
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/13/2002 10:17:18 PM
//:://////////////////////////////////////////////

#include "hc_inc"

void main()
{

    object oMod = GetModule();

    object oPC = GetPCSpeaker();
    string sCDK=GetPCPublicCDKey(oPC);
    string oName=GetName(oPC);

    string sID=sCDK+oName;

    // set flag
    SetLocalInt(oMod,"cohort"+sID,TRUE);


}

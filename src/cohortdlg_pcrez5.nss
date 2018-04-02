#include "cohort_inc_vars"

void main()
{
    object oPC = GetPCSpeaker();

    if(REZFEEDBACK)
        SendMessageToPC(GetLocalObject(OBJECT_SELF, "RealMaster"), GetName(OBJECT_SELF) + ": " + GetName(oPC) + " has refused to aid me financially.");

    SetLocalInt(oPC, "RefusedCoin" + GetTag(OBJECT_SELF), TRUE);
}

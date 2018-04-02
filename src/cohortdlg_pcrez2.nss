#include "cohort_inc_vars"

void main()
{
    object oPC = GetPCSpeaker();

    if(REZFEEDBACK)
        SendMessageToPC(GetLocalObject(OBJECT_SELF, "RealMaster"), GetName(OBJECT_SELF) + ": " + GetName(oPC) + " has refused to help me.");

    SetLocalInt(oPC, "RefusedRez" + GetTag(OBJECT_SELF), TRUE);
}

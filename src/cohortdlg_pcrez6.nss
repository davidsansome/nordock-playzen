#include "cohort_inc_vars"

void main()
{
    object oPC = GetPCSpeaker();

    if(REZFEEDBACK)
        SendMessageToPC(GetLocalObject(OBJECT_SELF, "RealMaster"), GetName(OBJECT_SELF) + ": " + GetName(oPC) + " has offered to aid me financially.");

    TakeGoldFromCreature((GetLocalInt(OBJECT_SELF, "NPCNoRez") - GetGold(OBJECT_SELF)), oPC);

    SetLocalInt(OBJECT_SELF, "NPCNoRez", FALSE);
}

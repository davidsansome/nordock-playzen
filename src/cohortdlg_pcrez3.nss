#include "cohort_inc_vars"

void main()
{
    object oPC = GetPCSpeaker();

    if(REZFEEDBACK)
        SendMessageToPC(GetLocalObject(OBJECT_SELF, "RealMaster"), GetName(OBJECT_SELF) + ": " + GetName(oPC) + " has offered to help me.");

    SetLocalObject(OBJECT_SELF, "OfferedRez", oPC);
    SetLocalInt(OBJECT_SELF, "WaitingRez", 1);

    ClearAllActions();
    AssignCommand(OBJECT_SELF, ActionPutDownItem(GetItemPossessedBy(OBJECT_SELF, "PlayerCorpse")));
}

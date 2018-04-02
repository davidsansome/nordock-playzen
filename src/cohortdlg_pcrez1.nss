#include "cohort_inc_vars"

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    if((GetLevelByClass(CLASS_TYPE_CLERIC, oPC) >= PCSEEKLEVEL) && (GetIsPC(oPC)) && (!IsInConversation(oPC)) && (GetLocalInt(OBJECT_SELF, "SeekingRez")) && (!GetLocalInt(OBJECT_SELF, "WaitingRez")) && (!GetLocalInt(oPC, "RefusedRez" + GetTag(OBJECT_SELF))))
    {
        SetCustomToken(3850, GetName(GetLocalObject(OBJECT_SELF, "RealMaster")));
        return TRUE;
    }

    return FALSE;
}

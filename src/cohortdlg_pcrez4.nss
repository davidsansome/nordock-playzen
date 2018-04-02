#include "cohort_inc_vars"

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    if((GetLocalInt(OBJECT_SELF, "SeekingRez")) && (!GetLocalInt(OBJECT_SELF, "WaitingRez")) && (!GetLocalInt(oPC, "RefusedCoin" + GetTag(OBJECT_SELF))) && (GetLocalInt(OBJECT_SELF, "NPCNoRez") > 1) && (GetGold(oPC) >= (GetLocalInt(OBJECT_SELF, "NPCNoRez") - GetGold(OBJECT_SELF))))
    {
        SetCustomToken(3850, GetName(GetLocalObject(OBJECT_SELF, "RealMaster")));
        SetCustomToken(3851, IntToString(GetLocalInt(OBJECT_SELF, "NPCNoRez") - GetGold(OBJECT_SELF)));
        return TRUE;
    }

    return FALSE;
}


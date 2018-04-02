#include "rr_persist"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iStage = GetLocalInt(oPC, "InmateBennerQuest");
    int iFinishedQuest = GPI(oPC, "InmateBennerFinished");
    if ((iStage == 1) && (iFinishedQuest != 1))
    {
        AdjustReputation(oPC, GetObjectByTag("Faction_Defender"), -100);
        DelayCommand(300.0f, AdjustReputation(oPC, GetObjectByTag("Faction_Defender"), 50));

        ActionForceFollowObject(oPC, 1.0f);
        SetLocalInt(oPC, "InmateBennerQuest", 2);
        SetLocalInt(GetPCSpeaker(), "InmateBennerSpoken", 0);
        SetLocalObject(oPC, "InmateBenner", OBJECT_SELF);
        SetLocalObject(OBJECT_SELF, "Following", oPC);
        return TRUE;
    }
    return FALSE;
}


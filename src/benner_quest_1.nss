#include "rr_persist"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iStage = GetLocalInt(oPC, "InmateBennerQuest");
    int iFinishedQuest = GPI(oPC, "InmateBennerFinished");
    if ((iStage == 0) && (iFinishedQuest != 1))
    {
        SetLocalInt(oPC, "InmateBennerSpoken", 1);
        return TRUE;
    }
    return FALSE;
}

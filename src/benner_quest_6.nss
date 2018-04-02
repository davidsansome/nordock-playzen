#include "rr_persist"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iFinishedQuest = GPI(oPC, "InmateBennerFinished");
    if (iFinishedQuest == 1)
        return TRUE;
    return FALSE;
}

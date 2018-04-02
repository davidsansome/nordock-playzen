#include "rr_persist"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if ((GPI(oPC, "InmateBennerFinished") == 1) && (GPI(oPC, "InmateBennerReward") == 0))
        return TRUE;
    return FALSE;
}

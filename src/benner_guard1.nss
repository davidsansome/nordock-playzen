#include "rr_persist"

int StartingConditional()
{
    int iSpoken = GetLocalInt(GetPCSpeaker(), "InmateBennerSpoken");
    int iDone = GPI(GetPCSpeaker(), "InmateBennerFinished");
    if ((iSpoken == 1) && (iDone != 1))
        return TRUE;
    return FALSE;
}

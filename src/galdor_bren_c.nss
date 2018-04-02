#include "rr_persist"

int StartingConditional()
{
    if ((GetHitDice(GetPCSpeaker()) < 40) || (GPI(GetPCSpeaker(), "GaldorBren") == 1))
        return FALSE;
    return TRUE;
}

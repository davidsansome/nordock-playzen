#include "rr_persist"

int StartingConditional()
{
    if (GPI(GetPCSpeaker(), "KabuInnStage") == 2)
        return TRUE;
    return FALSE;
}

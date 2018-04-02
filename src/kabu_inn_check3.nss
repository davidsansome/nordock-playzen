#include "rr_persist"

int StartingConditional()
{
    if (GPI(GetPCSpeaker(), "KabuInnStage") == 3)
        return TRUE;
    return FALSE;
}

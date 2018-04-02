#include "rr_persist"

int StartingConditional()
{
    if (GPI(GetPCSpeaker(), "KabuInnStage") == 4)
        return TRUE;
    return FALSE;
}

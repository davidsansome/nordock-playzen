#include "rr_persist"

int StartingConditional()
{
    if (GPI(GetPCSpeaker(), "TrevorCompleted") == 1)
        return TRUE;
    return FALSE;
}

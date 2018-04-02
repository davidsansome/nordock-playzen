#include "rr_persist"

int StartingConditional()
{
    int iDone = GPI(GetPCSpeaker(), "KabuBringusCompleted");

    if (iDone == 1)
        return FALSE;

    return TRUE;
}

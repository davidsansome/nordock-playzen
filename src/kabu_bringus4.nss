#include "rr_persist"

int StartingConditional()
{
    int iDone = GPI(GetPCSpeaker(), "KabuBringusCompleted");
    int iDoneInn = GPI(GetPCSpeaker(), "KabuInnStage");
    if ((iDone == 1) && (iDoneInn == 0))
        return TRUE;

    return FALSE;
}

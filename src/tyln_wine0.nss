#include "rr_persist"

int StartingConditional()
{
    int complete = GPI(GetPCSpeaker(), "TylnWineCompleted");

    if (!complete)
        return TRUE;
    return FALSE;
}

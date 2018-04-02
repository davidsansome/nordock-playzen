#include "cohort_inc"

int StartingConditional()
{
    if (!GetCanWork(GetPCSpeaker(), OBJECT_SELF) && CanAddMoreHenchmen(GetPCSpeaker()))
            return (GetMaster()==OBJECT_INVALID);
    return FALSE;
}

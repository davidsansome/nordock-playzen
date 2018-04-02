#include "cohort_inc"

int StartingConditional()
{
    if (GetCanWork(GetPCSpeaker(), OBJECT_SELF) &&
        CanAddMoreHenchmen(GetPCSpeaker()) &&
        GetAlignmentIsOK(GetPCSpeaker(), OBJECT_SELF))
    {
        return (GetMaster()==OBJECT_INVALID);
    }
    else
        return FALSE;
}

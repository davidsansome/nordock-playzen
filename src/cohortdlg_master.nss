#include "cohort_inc"

int StartingConditional()
{
    return (GetPCSpeaker()!=GetRealMaster() && GetMaster()!=OBJECT_INVALID);
}


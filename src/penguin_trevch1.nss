#include "rr_persist"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if ((GetLevelByClass(CLASS_TYPE_DRUID, oPC) +
         GetLevelByClass(CLASS_TYPE_RANGER, oPC) +
         GetLevelByClass(CLASS_TYPE_SHIFTER, oPC)) >= 4)
    {
        if (GPI(GetPCSpeaker(), "TrevorCompleted") != 1)
            return TRUE;
    }
    return FALSE;
}

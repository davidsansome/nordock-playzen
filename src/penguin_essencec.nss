#include "nw_i0_tool"
#include "rr_persist"

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    // Has the PC done this before?
    if (GPI(oPC, "LegendaryPenguins") == 1)
        return FALSE;

    // Has he got some penguin essence?
    if(!HasItem(oPC, "PenguinEssence"))
        return FALSE;

    return TRUE;
}

#include "nw_i0_tool"
#include "apts_inc_ptok"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if (GetTokenBool(GetPCSpeaker(), "gurnal_quest_2") == 1)
        return TRUE;

    return FALSE;
}

#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "PortalStoneI")
        && HasItem(GetPCSpeaker(), "PortalStoneII")
        && HasItem(GetPCSpeaker(), "PortalStoneIII"))
            return FALSE;
    if(HasItem(GetPCSpeaker(), "ActivationStone"))
            return FALSE;

    return TRUE;
}


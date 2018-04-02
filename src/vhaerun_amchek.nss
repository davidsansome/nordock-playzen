//This checks to see if they have the quest item and do NOT have the
//quest completion token.

#include "nw_i0_tool"
#include "apts_inc_ptok"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "vhaerunsamuletof") && (GetTokenBool(GetPCSpeaker(), "drowquest")==0))
        return TRUE;

    return FALSE;

}

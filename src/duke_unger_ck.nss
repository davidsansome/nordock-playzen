#include "nw_i0_tool"
#include "apts_inc_ptok"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "Blackdragonscales") && (GetTokenBool(GetPCSpeaker(), "duke_unger")==0))
        return TRUE;

    return FALSE;
}

#include "nw_i0_tool"
#include "apts_inc_ptok"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(GetTokenBool(GetPCSpeaker(), "farmer_beetle")==1)
        return TRUE;

    return FALSE;
}

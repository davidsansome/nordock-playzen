#include "nw_i0_tool"
#include "apts_inc_ptok"

int StartingConditional()
{
    int iResult;

    iResult = ((HasItem(GetPCSpeaker(),"RuneofPowerSregtur")) &&
                (GetTokenBool(GetPCSpeaker(),"gal_rune_done")==0));
    return iResult;
}

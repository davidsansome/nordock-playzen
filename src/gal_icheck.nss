#include "apts_inc_ptok"

int StartingConditional()
{
    int iResult;

    iResult = GetTokenBool(GetPCSpeaker(),"galdor_intro")==1;
    return iResult;
}

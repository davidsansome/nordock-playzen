//::///////////////////////////////////////////////
//:: FileName galdorchektalked
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/13/2002 8:17:17 AM
//:://////////////////////////////////////////////

#include "apts_inc_ptok"

int StartingConditional()
{

    // Inspect local variables
    if((GetTokenBool(GetPCSpeaker(), "galdor_intro") == 0))
        return TRUE;

    return FALSE;
}

//::///////////////////////////////////////////////
//:: FileName gal_swamp1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/5/2002 12:07:32 PM
//:://////////////////////////////////////////////
#include "apts_inc_ptok"
int StartingConditional()
{

    // Inspect local variables
    if(!((GetTokenBool(GetPCSpeaker(), "galdor_intro")) &&
            (GetTokenBool(GetPCSpeaker(),"galdor_on_mission")==0)))
        return FALSE;

    return TRUE;
}

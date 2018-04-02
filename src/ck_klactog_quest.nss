//::///////////////////////////////////////////////
//:: FileName sc_001
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/30/2002 00:17:29
//:://///////////////////////////////////////////
#include "apts_inc_ptok"
int StartingConditional()
{

    // Inspect local variables
    if(!(GetTokenInt(GetEnteringObject(), "klactog_quest") == 0))
        return FALSE;

    return TRUE;
}

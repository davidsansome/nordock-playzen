//::///////////////////////////////////////////////
//:: FileName tald_chek_kb1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/10/2002 6:31:43 PM
//:://////////////////////////////////////////////

#include "apts_inc_ptok"

int StartingConditional()
{

    // Inspect local variables
    if(!(GetTokenBool(GetPCSpeaker(), "kobold_staff") == 1))
        return FALSE;

    return TRUE;
}

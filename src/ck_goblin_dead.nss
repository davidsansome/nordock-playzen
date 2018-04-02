//::///////////////////////////////////////////////
//:: FileName ck_goblin_dead
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/30/2002 13:18:58
//:://////////////////////////////////////////////

#include "rr_persist"

int StartingConditional()
{

    // Inspect local variables
    if(GPI(GetPCSpeaker(), "goblin_dead") != 1)
        return FALSE;

    return TRUE;
  // Inspect local variables
    if(GPI(GetPCSpeaker(), "decline_job2") != 0)
        return FALSE;

    return TRUE;
}

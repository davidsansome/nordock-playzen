//::///////////////////////////////////////////////
//:: FileName heaven_tspeech01
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2002-11-18 04:10:35
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(GetItemPossessor(GetObjectByTag("FaithofSteel_NOD")) != GetPCSpeaker())
        return FALSE;

    return TRUE;
}

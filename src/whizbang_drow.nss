//::///////////////////////////////////////////////
//:: FileName whizbang_drow
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/6/2002 10:26:56 AM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Reject player races
    if(GetStringLowerCase(GetSubRace(GetPCSpeaker())) == "drow")
        return TRUE;
    else
        return FALSE;

}
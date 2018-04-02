//::///////////////////////////////////////////////
//:: FileName pav_class_notpal
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2002-11-14 19:21:15
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Restrict based on the player's class
    int iPassed = 0;
    if(GetLevelByClass(CLASS_TYPE_PALADIN, GetPCSpeaker()) >= 1)
        iPassed = 1;
    if(iPassed == 0)
        return TRUE;

    return FALSE;
}

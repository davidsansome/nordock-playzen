//::///////////////////////////////////////////////
//:: FileName epic_chek_lvl1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 12/5/2002 1:27:18 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Restrict based on the player's class
    int iPassed = 0;
    if(GetHitDice(GetPCSpeaker()) >= 19)
        iPassed = 1;
    if(iPassed == 0)
        return FALSE;

    return TRUE;
}

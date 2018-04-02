//::///////////////////////////////////////////////
//:: FileName pav_class_pal
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2002-11-14 19:24:40
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Restrict based on the player's class
    object oSword = GetObjectByTag("FaithofSteel_NOD");
    int iPassed = 0;
    if((GetLevelByClass(CLASS_TYPE_PALADIN, GetPCSpeaker()) >= 1) && (GetLocalInt(GetPCSpeaker(), "sPaladinQuestOnProcess") != 1) && (GetItemPossessor(oSword) != GetPCSpeaker()))
        iPassed = 1;
    if(iPassed == 0)
        return FALSE;

    return TRUE;
}

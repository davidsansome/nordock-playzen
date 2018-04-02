//::///////////////////////////////////////////////
//:: FileName elemental_def
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Havack
//:: Created On: 10/20/2002 15:59:41
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Summons Elemental to defend forge based on the player's Level
    int iPassed = 0;

    if(GetHitDice(GetLastDamager()) >= 15)
        iPassed = 1;
    if(iPassed == 0)
        return FALSE;
        CreateObject(OBJECT_TYPE_CREATURE, "NW_FIREELDER", GetLocation(OBJECT_SELF));
    return TRUE;
    if(GetHitDice(GetLastDamager()) >= 10)
        iPassed = 1;
    if(iPassed == 0)
        return FALSE;
        CreateObject(OBJECT_TYPE_CREATURE, "NW_FIREGREAT", GetLocation(OBJECT_SELF));
    return TRUE;

    if(GetHitDice(GetLastDamager()) >= 5)
        iPassed = 1;
    if(iPassed == 0)
        return FALSE;
        CreateObject(OBJECT_TYPE_CREATURE, "NW_FIREHUGE", GetLocation(OBJECT_SELF));
    return TRUE;

    if(GetHitDice(GetLastDamager()) >= 1)
        iPassed = 1;
    if(iPassed == 0)
        return FALSE;
        CreateObject(OBJECT_TYPE_CREATURE, "NW_FIRE", GetLocation(OBJECT_SELF));
    return TRUE;
}

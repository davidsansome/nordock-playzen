
int HasFamiliar()
{
    if (GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_FAMILIAR)))
        return FALSE;
    int iClass = GetClassByPosition(1);
    if (iClass==CLASS_TYPE_WIZARD || iClass==CLASS_TYPE_SORCERER)
        return TRUE;
    iClass = GetClassByPosition(2);
    if (iClass==CLASS_TYPE_WIZARD || iClass==CLASS_TYPE_SORCERER)
        return TRUE;
    iClass = GetClassByPosition(3);
    if (iClass==CLASS_TYPE_WIZARD || iClass==CLASS_TYPE_SORCERER)
        return TRUE;
    return FALSE;
}

int StartingConditional()
{
    return (GetAbilityScore(GetPCSpeaker(),ABILITY_INTELLIGENCE) >= 9) && HasFamiliar();
}

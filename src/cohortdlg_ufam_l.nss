int StartingConditional()
{
    int HasFamiliar = GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_FAMILIAR));
    return (GetAbilityScore(GetPCSpeaker(),ABILITY_INTELLIGENCE) < 9) && HasFamiliar;
}

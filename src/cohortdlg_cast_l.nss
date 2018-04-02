
int CanCastSpell()
{
    int i;
    for (i = 1; i <=3; i++) {
        int iClass = GetClassByPosition(i);
        switch (iClass) {
            case CLASS_TYPE_CLERIC:
            case CLASS_TYPE_DRUID:
            case CLASS_TYPE_BARD:
            case CLASS_TYPE_SORCERER:
            case CLASS_TYPE_WIZARD:
                return TRUE;
            case CLASS_TYPE_PALADIN:
            case CLASS_TYPE_RANGER:
                if (GetHitDice(OBJECT_SELF) > 3) return TRUE;
        }
    }
    return FALSE;
}

int StartingConditional()
{
    return (GetAbilityScore(GetPCSpeaker(),ABILITY_INTELLIGENCE) < 9) && CanCastSpell();
}

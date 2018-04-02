void main()
{
    object oPC = GetLastUsedBy();

    if (!GetIsPC(oPC))
        return;

    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0, 13.0));
    DelayCommand(10.0, ActionCastSpellAtObject(SPELL_GREATER_RESTORATION, oPC, METAMAGIC_ANY, TRUE, 20, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
    DelayCommand(13.0, AssignCommand(oPC, ClearAllActions()));
}

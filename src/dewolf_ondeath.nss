void DespawnGuard(object oGuard)
{
    if (GetIsObjectValid(oGuard))
        DestroyObject(oGuard);
}

void main()
{
    object oPC = GetLastDamager();
    location lLoc = GetLocation(oPC);
    object oGuard1 = CreateObject(OBJECT_TYPE_CREATURE, "dewolf_guard", lLoc);
    object oGuard2 = CreateObject(OBJECT_TYPE_CREATURE, "dewolf_guard", lLoc);
    SetIsTemporaryEnemy(oPC, oGuard1);
    SetIsTemporaryEnemy(oPC, oGuard2);
    AssignCommand(oGuard1, ActionAttack(oPC));
    AssignCommand(oGuard2, ActionAttack(oPC));

    DelayCommand(60.0f, DespawnGuard(oGuard1));
    DelayCommand(60.0f, DespawnGuard(oGuard2));

    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}

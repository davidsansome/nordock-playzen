void main()
{
    object oPC = GetLastKiller();
    if (!GetIsPC(oPC)) return;

    DelayCommand(2.0, FloatingTextStringOnCreature("You feel dizzy and lightheaded", oPC));

    object oTarget;
    location lTarget;
    oTarget = GetWaypointByTag("kat_afterdeath");
    lTarget = GetLocation(oTarget);

    object oPlayer = GetFirstFactionMember(oPC, FALSE);
    while (GetIsObjectValid(oPlayer))
    {
        if (GetArea(oTarget) == GetArea(oPlayer))
        {
            AssignCommand(oPlayer, ClearAllActions());
            effect eEffect = EffectCutsceneImmobilize();
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPlayer, 3.5f);
            DelayCommand(3.0f, AssignCommand(oPlayer, ActionJumpToLocation(lTarget)));
        }
        oPlayer=GetNextFactionMember(oPC, FALSE);
    }
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}

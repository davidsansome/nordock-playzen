void main()
{
    object oPC = GetLastUsedBy();
    object oWP = GetObjectByTag("WP_TO_HEAVEN");
    location lWP = GetLocation(oWP);

    if(GetLevelByClass(CLASS_TYPE_PALADIN, oPC) > 0)
        AssignCommand(oPC, ActionJumpToLocation(lWP));
    else
        FloatingTextStringOnCreature("Only a pure heart can fuse into this light.", oPC, TRUE);
}

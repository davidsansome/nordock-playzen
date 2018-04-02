void main()
{
    object oPC = GetPCSpeaker();

    if (GetGold(oPC) < 750)
    {
        FloatingTextStringOnCreature("You do not have enough gold.", oPC);
        return;
    }
    TakeGoldFromCreature(750, oPC, TRUE);
    AssignCommand(oPC, ActionJumpToLocation(GetLocation(GetObjectByTag("kabu_arrive3"))));
}

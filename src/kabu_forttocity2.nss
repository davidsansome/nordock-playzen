void main()
{
    object oPC = GetPCSpeaker();

    if (GetGold(oPC) < 40)
    {
        FloatingTextStringOnCreature("You do not have enough gold.", oPC);
        return;
    }
    TakeGoldFromCreature(40, oPC, TRUE);
    AssignCommand(oPC, ActionJumpToLocation(GetLocation(GetObjectByTag("kabu_arrive3"))));
}

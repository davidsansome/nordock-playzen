void main()
{
    object oPC = GetPCSpeaker();

    if (GetGold(oPC) < 50)
    {
        FloatingTextStringOnCreature("You do not have enough gold.", oPC);
        return;
    }
    TakeGoldFromCreature(50, oPC, TRUE);
    AssignCommand(oPC, ActionJumpToLocation(GetLocation(GetObjectByTag("kabu_arrive2"))));
}

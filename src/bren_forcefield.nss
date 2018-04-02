void main()
{
    object oPC = GetClickingObject();
    if (GetHitDice(oPC) < 40)
    {
        FloatingTextStringOnCreature("*Buzzzzzzzz*", oPC);
        SendMessageToAllDMs(GetName(oPC) + " has level " + IntToString(GetHitDice(oPC)));
        return;
    }

    AssignCommand(oPC, ActionJumpToObject(GetObjectByTag("WP_RudashEntrance")));
}

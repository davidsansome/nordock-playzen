void main()
{
    object oPC = GetPCSpeaker();
    string sBlueprint = GetLocalString(OBJECT_SELF, "Recipe3");
    int iGold = GetLocalInt(OBJECT_SELF, "Gold3");

    if (sBlueprint == "")
        return;

    if (GetGold(oPC) < iGold)
    {
        FloatingTextStringOnCreature("* Not enough gold *", oPC);
        return;
    }

    TakeGoldFromCreature(iGold, oPC, TRUE);
    CreateItemOnObject(sBlueprint, oPC);
}

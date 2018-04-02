void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC))
        SetLocalInt(oPC,"IsAPC",TRUE);

    GiveGoldToCreature(oPC,500000);
}

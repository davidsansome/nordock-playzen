//::///////////////////////////////////////////////
//:: FileName goto_trondor_ship
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/7/2002 1:19:03 PM
//:://////////////////////////////////////////////
void main()
{
    object oPC = GetPCSpeaker();

    // Take gold
    if (GetGold(oPC) < 1)
    {
        FloatingTextStringOnCreature("Not enough gold", oPC);
        return;
    }

    TakeGoldFromCreature(1, oPC, TRUE);
    AssignCommand(oPC, JumpToLocation(GetLocation(GetObjectByTag ("trondor_ship_arrive"))));
}

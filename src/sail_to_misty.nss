//::///////////////////////////////////////////////
//:: FileName sail_to_misty
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/7/2002 3:51:05 PM
//:://////////////////////////////////////////////
void main()
{
    object oPC = GetPCSpeaker();

    // Take gold
    if (GetGold(oPC) < 150)
    {
        FloatingTextStringOnCreature("Not enough gold", oPC);
        return;
    }

    TakeGoldFromCreature(150, oPC, TRUE);
    AssignCommand(oPC, JumpToLocation(GetLocation(GetObjectByTag ("misty_ship_arrive"))));
}

//::///////////////////////////////////////////////
//:: FileName sailtobeznor
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/7/2002 1:44:08 PM
//:://////////////////////////////////////////////
void main()
{
object oPC = GetPCSpeaker();

    // Take gold
    if (GetGold(oPC) < 50)
    {
        FloatingTextStringOnCreature("Not enough gold", oPC);
        return;
    }

    TakeGoldFromCreature(50, oPC, TRUE);
    AssignCommand(oPC, JumpToLocation(GetLocation(GetObjectByTag ("benzor_ship_arrive"))));

}

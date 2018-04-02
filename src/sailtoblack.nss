//::///////////////////////////////////////////////
//:: FileName sailtoblack
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/1/2002 7:30:38 AM
//:://////////////////////////////////////////////
void main()
{
    object oPC = GetPCSpeaker();

    // Take gold
    if (GetGold(oPC) < 75)
    {
        FloatingTextStringOnCreature("Not enough gold", oPC);
        return;
    }

    TakeGoldFromCreature(75, oPC, TRUE);
    AssignCommand(oPC, JumpToLocation(GetLocation(GetObjectByTag ("bh_ship"))));
}

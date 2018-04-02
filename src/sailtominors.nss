//::///////////////////////////////////////////////
//:: FileName sailtominors
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/12/2002 2:16:04 PM
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
    AssignCommand(oPC, JumpToLocation(GetLocation(GetObjectByTag ("minersship"))));
}

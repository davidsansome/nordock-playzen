//::///////////////////////////////////////////////
//:: FileName sailtomurlok
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/20/2002 12:58:32 PM
//:://////////////////////////////////////////////
void main()
{
    object oPC = GetPCSpeaker();

    // Take gold
    if (GetGold(oPC) < 65)
    {
        FloatingTextStringOnCreature("Not enough gold", oPC);
        return;
    }

    TakeGoldFromCreature(65, oPC, TRUE);
    AssignCommand(oPC, JumpToLocation(GetLocation(GetObjectByTag ("mulrock_ship"))));
}

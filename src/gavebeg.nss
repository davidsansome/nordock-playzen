//::///////////////////////////////////////////////
//:: FileName gavebeg
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/20/2002 10:33:27 AM
//:://////////////////////////////////////////////
void main()
{

    // Remove some gold from the player
    TakeGoldFromCreature(1, GetPCSpeaker(), TRUE);
    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_GOOD, 1);
}

//::///////////////////////////////////////////////
//:: FileName loknarstone_dest
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/10/2002 11:53:01 PM
//:://////////////////////////////////////////////
void main()
{
    object oPC=GetPCSpeaker();
    effect eVis = EffectVisualEffect(VFX_IMP_PULSE_COLD);
    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "loknarstone");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    // Apply visual effect on PC
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
}

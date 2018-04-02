//::///////////////////////////////////////////////
//:: FileName llothstone_take
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/26/2002 11:11:18 AM
//:://////////////////////////////////////////////
void main()
{
    object oPC=GetPCSpeaker();
    effect eVis = EffectVisualEffect(VFX_IMP_PULSE_COLD);
    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "llothstone");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    // Apply visual effect on PC
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
}

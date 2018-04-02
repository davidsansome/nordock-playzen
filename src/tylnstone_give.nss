//::///////////////////////////////////////////////
//:: FileName llothstone_give
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Jarketh Thavin
//:: Created On: 9/21/2002 4:45:56 PM
//:://////////////////////////////////////////////
void main()
{
    object oPC=GetPCSpeaker();
    effect eVis = EffectVisualEffect(VFX_IMP_HOLY_AID);
    // Give the speaker the items
    CreateItemOnObject("tylncastlebindst", GetPCSpeaker(), 1);
    // Apply visual effect on PC
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
}

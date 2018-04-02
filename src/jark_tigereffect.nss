///////////////////////////////////////////
//apply permanent visual effects to an NPC
//Jarketh Thavin
///////////////////////////////////////////

void main()
{

 // Target NPC

 object oTarget = OBJECT_SELF;


 // Set effect duration to permanent.

 int nDurationType = DURATION_TYPE_PERMANENT;


 // Declare effect1. Blue Light.

 effect eEffect1 = EffectVisualEffect (VFX_DUR_LIGHT_BLUE_20);


 // Declare effect2. Protection from Elements.

 effect eEffect2 = EffectVisualEffect (VFX_DUR_PROT_STONESKIN);


 // Now apply it, and keep it.

 ApplyEffectToObject (nDurationType, eEffect1, oTarget);

 ApplyEffectToObject (nDurationType, eEffect2, oTarget);

}

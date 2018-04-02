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

 effect eEffect2 = EffectVisualEffect (VFX_DUR_PROTECTION_ELEMENTS);


 // Declare effect3. Magic Resistance.

 effect eEffect3 = EffectVisualEffect (VFX_DUR_MAGIC_RESISTANCE);

// Declare effect4. Freedom of Movement.

 effect eEffect4 = EffectVisualEffect (VFX_DUR_FREEDOM_OF_MOVEMENT);


 // Now apply it, and keep it.

 ApplyEffectToObject (nDurationType, eEffect1, oTarget);

 ApplyEffectToObject (nDurationType, eEffect2, oTarget);

 ApplyEffectToObject (nDurationType, eEffect3, oTarget);

 ApplyEffectToObject (nDurationType, eEffect4, oTarget);

}

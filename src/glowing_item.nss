void main()

{

 // Target Self

 object oTarget = OBJECT_SELF;



 // Don't want this wearing off now, do we?

 int nDurationType = DURATION_TYPE_PERMANENT;



 // Declare effect1, the visual

 effect eEffect1 = EffectVisualEffect (VFX_DUR_GLOBE_INVULNERABILITY);



 // now apply it, and keep it.

 ApplyEffectToObject (nDurationType, eEffect1, oTarget);


 SetPlotFlag(oTarget, TRUE);

}

void main()

{

 // Target NPC

 object oTarget = OBJECT_SELF;


 // Don't want this wearing off now, do we?

 int nDurationType = DURATION_TYPE_PERMANENT;


 // Declare effect1, the paralyze.

 effect eEffect1 = EffectParalyze();


 // now apply it, and keep it.

 ApplyEffectToObject (nDurationType, eEffect1, oTarget);

 SetPlotFlag(oTarget, TRUE);

}

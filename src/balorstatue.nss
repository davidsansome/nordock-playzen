void main()
{
    effect ePar = EffectParalyze();
    effect eVis = EffectVisualEffect(VFX_DUR_PROT_STONESKIN);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePar, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, OBJECT_SELF);
}

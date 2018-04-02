void main()
{
    object oPC=OBJECT_SELF;
    location lTarget = GetLocation(GetObjectByTag("pillar"));
    AssignCommand(oPC, DelayCommand( 2.0, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), lTarget)));
    DestroyObject(GetObjectByTag("summonpillar"));
    CreateObject(OBJECT_TYPE_PLACEABLE,"galdorport",lTarget,TRUE);
}

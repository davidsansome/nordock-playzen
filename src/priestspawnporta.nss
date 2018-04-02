//Put this on action taken in the conversation editor
void main()
{
    object oPC = GetPCSpeaker();
    object oTarget;
    object oSpawn;

    oTarget = GetWaypointByTag("portalappear");
    oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_portal", GetLocation(oTarget));
    SetLocalObject(oTarget, "KAT_PORTAL", oSpawn);

    DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_TIME_STOP), GetLocation(oSpawn)));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_STRIKE_HOLY), GetLocation(oPC));
}


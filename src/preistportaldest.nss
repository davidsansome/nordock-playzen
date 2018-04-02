void main()
{
    object oTarget;

    oTarget = GetWaypointByTag("portalappear");
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DESTRUCTION), GetLocation(oTarget));
    DestroyObject(GetLocalObject(oTarget, "KAT_PORTAL"), 3.0);
}


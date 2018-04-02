void main()
{
    if (!GetIsPC(OBJECT_SELF))
        return;

    vector vPos = GetPosition(OBJECT_SELF);
    vPos.x += 1.0f;
    // Duration = 2 minutes plus 1 minute per 10 levels
    float fDuration = 180.0 + (GetHitDice(OBJECT_SELF) * 6.0f);

    effect ePenguin = EffectSummonCreature("penguinpet", VFX_FNF_STRIKE_HOLY, 0.5f);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, ePenguin, GetLocation(OBJECT_SELF), fDuration);
}

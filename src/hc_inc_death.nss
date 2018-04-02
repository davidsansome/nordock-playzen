effect eMove=EffectMovementSpeedDecrease(80);
effect eCurse=EffectCurse(5,5,0,5,5,0);
effect eSlow=EffectSlow();

void hcDisabledSetup(object oPlayer)
{
    int nHP=GetCurrentHitPoints(oPlayer);
    if(nHP != 1)
    {
        effect eHeal = EffectHeal(abs(nHP)+1);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,oPlayer);
    }
    int nPS=GetLocalInt(oMod,"DR_APPLIED"+GetName(oPlayer)+GetPCPublicCDKey(oPlayer));
    if(nPS==FALSE)
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eMove, oPlayer);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCurse, oPlayer);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSlow, oPlayer);
    }
    SetLocalInt(oMod,"DR_APPLIED"+GetName(oPlayer)+GetPCPublicCDKey(oPlayer),TRUE);
}


void hcDisabledRemove(object oVictim)
{
    effect eBad=GetFirstEffect(oVictim);
    while (GetIsEffectValid (eBad) )
    {
        int nEtype=GetEffectType(eBad);
        if(nEtype == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE ||
           nEtype == EFFECT_TYPE_CURSE ||
          nEtype == EFFECT_TYPE_SLOW)
          RemoveEffect (oVictim, eBad);
         eBad = GetNextEffect (oVictim);
    }
    SetLocalInt(oMod,"DR_APPLIED"+GetName(oVictim)+GetPCPublicCDKey(oVictim),FALSE);
}

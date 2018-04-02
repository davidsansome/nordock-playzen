#include "hc_inc"

// the familiar heals itself fully (no effects)
void main()
{
    if(!GetLocalInt(oMod,"REALFAM"))
    {
        int nHeal = GetMaxHitPoints();
        effect eHeal = EffectHeal(nHeal);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,OBJECT_SELF);
    }
}

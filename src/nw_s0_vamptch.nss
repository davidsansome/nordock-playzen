#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Vampiric Touch
//:: NW_S0_VampTch
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Caster must make a touch attack to drain 1d6
    HP per 2 caster levels from the target.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 29, 2001
//:://////////////////////////////////////////////

/*
bugfix by Kovi 2002.07.22
- did double damage with maximize
- temporary hp was stacked
2002.08.25
- got temporary hp some immune creatures (Negative Energy Protection), lost
temporary hp against other resistant (SR, Shadow Shield)
*/

#include "NW_I0_SPELLS"


void main()
{
    if(SpellSuccess()){
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage = d6(nDuration/2);
    if(nDamage == 0)
    {
        nDamage = d6();
    }
    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nDamage = 6 * nDuration / 2;//Damage is at max
    }
    else if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        nDamage = nDamage + (nDamage/2); //Damage/Healing is +50%
    }
    else if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration *= 2;
    }
    int nMax = GetCurrentHitPoints(oTarget) + 10;
    //Limit damage to max hp + 10
    if(nMax < nDamage)
    {
        nDamage = nMax;
    }
    //Declare effects
    effect eHeal = EffectTemporaryHitpoints(nDamage);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eHeal, eDur);

    effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eVisHeal = EffectVisualEffect(VFX_IMP_HEALING_M);
    if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
    {
        if(!GetIsReactionTypeFriendly(oTarget) &&
            GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD &&
            GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT &&
            !GetHasSpellEffect(SPELL_NEGATIVE_ENERGY_PROTECTION, oTarget))
        {

            //Signal spell cast at event
            SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_VAMPIRIC_TOUCH, FALSE));
            SignalEvent(OBJECT_SELF, EventSpellCastAt(oTarget, SPELL_VAMPIRIC_TOUCH, FALSE));
            //Spell resistance
            if(MyResistSpell(OBJECT_SELF, oTarget) == 0)
            {
                //Apply effects to target and caster
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisHeal, OBJECT_SELF);
                RemoveTempHitPoints();
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(nDuration));
            }
        }
    }
}}

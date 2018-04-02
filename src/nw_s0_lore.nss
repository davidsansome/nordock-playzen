#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Legend Lore
//:: NW_S0_Lore.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Gives the caster a boost to Lore skill of 10
    plus 1 / 2 caster levels.  Lasts for 1 Turn per
    caster level.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 22, 2001
//:://////////////////////////////////////////////


void main()
{
    if(SpellSuccess()){
    //Declare major variables
    int nLevel = GetCasterLevel(OBJECT_SELF);
    int nBonus = 10 + (nLevel / 2);
    effect eLore = EffectSkillIncrease(SKILL_LORE, nBonus);
    effect eVis = EffectVisualEffect(VFX_IMP_MAGICAL_VISION);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eLore, eDur);

    int nMetaMagic = GetMetaMagicFeat();
    //Meta-Magic checks
    if(nMetaMagic == METAMAGIC_EXTEND)
    {
        nLevel *= 2;
    }
    //Make sure the spell has not already been applied
    if(!GetHasSpellEffect(SPELL_IDENTIFY, OBJECT_SELF) || !GetHasSpellEffect(SPELL_LEGEND_LORE, OBJECT_SELF))
    {
         SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_LEGEND_LORE, FALSE));
         //Apply linked and VFX effects
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, TurnsToSeconds(nLevel));
         ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    }
}
}

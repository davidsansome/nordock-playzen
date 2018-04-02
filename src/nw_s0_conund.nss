#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: [Control Undead]
//:: [NW_S0_ConUnd.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
/*
    A single undead with up to 3 HD per caster level
    can be dominated.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Feb 2, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk
//:: Last Updated On: April 6, 2001

#include "NW_I0_SPELLS"
void main()
{
    if(SpellSuccess()){
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eControl = EffectDominated();
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DOMINATED);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eVis = EffectVisualEffect(VFX_IMP_DOMINATE_S);
    effect eLink = EffectLinkEffects(eMind, eControl);
    eLink = EffectLinkEffects(eLink, eDur);

    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDuration = nCasterLevel;
    int nHD = nCasterLevel * 3;
    //Make meta magic
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nCasterLevel * 2;
    }
    if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD && GetHitDice(oTarget) <= nHD)
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
           //Fire cast spell at event for the specified target
           SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CONTROL_UNDEAD));
           if (!MyResistSpell(OBJECT_SELF, oTarget))
           {
                //Make a Will save
                if (!/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF, 1.0))
                {
                    //Apply VFX impact and Link effect
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration)));
                    //Increment HD affected count
                }
            }
        }
    }
}}

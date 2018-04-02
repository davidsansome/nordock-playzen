#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: [Daze]
//:: [NW_S0_Daze.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Will save or the target is dazed for 1 round
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 15, 2001
//:://////////////////////////////////////////////
//:: Update Pass By: Preston W, On: July 27, 2001

#include "NW_I0_SPELLS"
void main()
{
    if(SpellSuccess()){
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
    effect eDaze = EffectDazed();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

    effect eLink = EffectLinkEffects(eMind, eDaze);
    eLink = EffectLinkEffects(eLink, eDur);

    effect eVis = EffectVisualEffect(VFX_IMP_DAZED_S);
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = 2;
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DAZE));
    //check meta magic for extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = 4;
    }


    //Make sure the target is a humaniod
    if (AmIAHumanoid(oTarget) == TRUE)
    {
        if(GetHitDice(oTarget) <= 5)
        {
            if(!GetIsReactionTypeFriendly(oTarget))
            {
               //Make SR check
               if (!MyResistSpell(OBJECT_SELF, oTarget))
               {
                    //Make Will Save to negate effect
                    if (!/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_MIND_SPELLS))
                    {
                        //Apply VFX Impact and daze effect
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    }
                }
            }
        }
    }
}}

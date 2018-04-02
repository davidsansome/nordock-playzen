#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Mind Blank
//:: NW_S0_MindBlk.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All allies are granted immunity to mental effects
    in the AOE.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////
#include "NW_I0_SPELLS"

void main()
{
    if(SpellSuccess()){
    //Declare major variables
    effect eImm1 = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);
    effect eLink = EffectLinkEffects(eImm1, eVis);
    eLink = EffectLinkEffects(eLink, eDur);
    float fDelay;
    effect eSearch;
    int bValid;
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetSpellTargetLocation());
    while(GetIsObjectValid(oTarget))
    {
        fDelay = GetRandomDelay();
        if(GetIsFriend(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MIND_BLANK, FALSE));
            //Search through effects
            eSearch = GetFirstEffect(oTarget);
            while(GetIsEffectValid(eSearch))
            {
                bValid = FALSE;
                //Check to see if the effect matches a particular type defined below
                if (GetEffectType(eSearch) == EFFECT_TYPE_DAZED)
                {
                    bValid = TRUE;
                }
                else if(GetEffectType(eSearch) == EFFECT_TYPE_CHARMED)
                {
                    bValid = TRUE;
                }
                else if(GetEffectType(eSearch) == EFFECT_TYPE_SLEEP)
                {
                    bValid = TRUE;
                }
                else if(GetEffectType(eSearch) == EFFECT_TYPE_CONFUSED)
                {
                    bValid = TRUE;
                }
                else if(GetEffectType(eSearch) == EFFECT_TYPE_STUNNED)
                {
                    bValid = TRUE;
                }
                else if(GetEffectType(eSearch) == EFFECT_TYPE_DOMINATED)
                {
                    bValid = TRUE;
                }

                //remove effect if the effect is a match
                if (bValid == TRUE)
                {
                    RemoveEffect(oTarget, eSearch);
                }
                eSearch = GetNextEffect(oTarget);
            }
            //After effects are removed we apply the immunity to mind spells to the target
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration)));
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetSpellTargetLocation());
    }
}}

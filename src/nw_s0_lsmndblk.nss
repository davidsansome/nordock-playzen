#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Lesser Mind Blank
//:: NW_S0_LsMndBlk.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:: [Description of File]
//:://////////////////////////////////////////////
//:: Created By: [Your Name]
//:: Created On: [date]
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 20, 2001

//*****  Repaired by Q'el  16-June-2003
// pasted in the Clarity spell script
// replaced the last two lines of clarity with the ApplyEffectToObject line from Mindblank

void main()
{
    if(SpellSuccess()){
    //Declare major variables
    effect eImm1 = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);
    effect eDam = EffectDamage(1, DAMAGE_TYPE_NEGATIVE);
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    effect eLink = EffectLinkEffects(eImm1, eVis);
    eLink = EffectLinkEffects(eLink, eDur);

    object oTarget = GetSpellTargetObject();
    effect eSearch = GetFirstEffect(oTarget);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }
    int bValid;
    int bVisual;
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CLARITY, FALSE));
    //Search through effects
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
        //Apply damage and remove effect if the effect is a match
        if (bValid == TRUE)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            RemoveEffect(oTarget, eSearch);
            bVisual = TRUE;
        }
        eSearch = GetNextEffect(oTarget);
    }
    //After effects are removed we apply the immunity to mind spells to the target
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
}
}

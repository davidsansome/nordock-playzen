#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Mass Blindness and Deafness
//:: [NW_S0_BlindDead.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Causes the target creature to make a Fort
//:: save or be blinded and deafened.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 12, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 10, 2001
//:: Update Pass By: Preston W, On: Aug 2, 2001

#include "NW_I0_SPELLS"
void main()
{
    if(SpellSuccess()){
    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    effect eBlind =  EffectBlindness();
    effect eDeaf = EffectDeaf();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

    //Link the blindness and deafness effects
    effect eLink = EffectLinkEffects(eBlind, eDeaf);
    eLink = EffectLinkEffects(eLink, eDur);
    effect eVis = EffectVisualEffect(VFX_IMP_BLIND_DEAF_M);
    effect eXpl = EffectVisualEffect(VFX_FNF_BLINDDEAF);
    //Check for metamagic extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
         nDuration = nDuration * 2;
    }
    //Play area impact VFX
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eXpl, GetSpellTargetLocation());
    //Get the first target in the spell area
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation());
    while (GetIsObjectValid(oTarget))
    {
        if(GetIsEnemy(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MASS_BLINDNESS_AND_DEAFNESS));
            //Make SR check
            if (!MyResistSpell(OBJECT_SELF, oTarget))
            {
                //Make Fort save
                if (!/*Fort Save*/ MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC()))
                {
                    //Apply the linked effects and the VFX impact
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                }
            }
        }
        //Get next object in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation());
    }
}}

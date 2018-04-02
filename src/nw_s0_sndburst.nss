#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: [Sound Burst]
//:: [NW_S0_SndBurst.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Does 1d8 damage to all creatures in a 10ft
//:: radius.  Will save or the creature is stunned
//:: for 1 round.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 31, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 11, 2001
//:: VFX Pass By: Preston W, On: June 25, 2001

#include "NW_I0_SPELLS"
void main()
{
    if(SpellSuccess()){
    //Declare major variables
    object oTarget;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    effect eStun = EffectStunned();
    effect eVis = EffectVisualEffect(VFX_IMP_SONIC);
    effect eFNF = EffectVisualEffect(VFX_FNF_SOUND_BURST);
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

    effect eLink = EffectLinkEffects(eStun, eMind);
    eLink = EffectLinkEffects(eLink, eDur);

    effect eDam;
    //Apply the FNF to the spell location
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eFNF, GetSpellTargetLocation());
    //Get the first target in the spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation());
    while (GetIsObjectValid(oTarget))
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SOUND_BURST));
            //Make a SR check
            if(!MyResistSpell(OBJECT_SELF, oTarget))
            {
                //Roll damage
                nDamage = d8();
                //Make a Will roll to avoid being stunned
                if(!/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_SONIC))
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(2));
                }
                //Make meta magic checks
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                    nDamage = 8;
                }
                if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                    nDamage = nDamage + (nDamage/2);
                }
                //Set the damage effect
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_SONIC);
                //Apply the VFX impact and damage effect
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis,oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam,oTarget);
            }
        }
        //Get the next target in the spell area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation());
    }
}
}

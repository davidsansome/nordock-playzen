#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Finger of Death
//:: NW_S0_FingDeath
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// You can slay any one living creature within range.
// The victim is entitled to a Fortitude saving throw to
// survive the attack. If he succeeds, he instead
// sustains 3d6 points of damage +1 point per caster
// level.
*/
//:://////////////////////////////////////////////
//:: Created By: Noel Borstad
//:: Created On: Oct 17, 2000
//:://////////////////////////////////////////////
//:: Update Pass By: Preston W, On: July 31, 2001

#include "NW_I0_SPELLS"
void main()
{
    if(SpellSuccess()){
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_IMP_DEATH_L);
    effect eVis2 = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FINGER_OF_DEATH));
        //Make SR check
        if (!MyResistSpell(OBJECT_SELF, oTarget))
           {
             //Make Forttude save
             if (!MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_DEATH))
             {
                //Apply the death effect and VFX impact
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oTarget);
                //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
             }
             else
             {
                //Roll damage
                nDamage = d6(3) + nCasterLvl;
                //Make metamagic checks
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                    nDamage = 18 + nCasterLvl;
                }
                if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                    nDamage = nDamage + (nDamage/2);
                }
                //Set damage effect
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
                //Apply damage effect and VFX impact
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
            }
        }
    }
}}

#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Healing Circle
//:: NW_S0_HealCirc
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// Positive energy spreads out in all directions
// from the point of origin, curing 1d8 points of
// damage plus 1 point per caster level (maximum +20)
// to nearby living allies.
//
// Like cure spells, healing circle damages undead in
// its area rather than curing them.
*/
//:://////////////////////////////////////////////
//:: Created By: Noel Borstad
//:: Created On: Oct 18,2000
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 20, 2001
//:: Update Pass By: Preston W, On: Aug 1, 2001

#include "NW_I0_SPELLS"
void main()
{
    if(SpellSuccess()){
  //Declare major variables
  object oTarget;
  int nCasterLvl = GetCasterLevel(OBJECT_SELF);
  int nDamagen, nModify, nHurt, nHP;
  int nMetaMagic = GetMetaMagicFeat();
  effect eKill;
  effect eHeal;
  effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
  effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_M);
  effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_20);
  float fDelay;
  //Limit caster level
  if (nCasterLvl > 20)
  {
    nCasterLvl = 20;
  }
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    //Get first target in shape
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation());
    while (GetIsObjectValid(oTarget))
    {
        fDelay = GetRandomDelay();
        //Check if racial type is undead
        if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD )
        {
            if(!GetIsReactionTypeFriendly(oTarget))
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEALING_CIRCLE));
                //Make SR check
                if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                {
                    nModify = d8() + nCasterLvl;
                    //Make metamagic check
                    if (nMetaMagic == METAMAGIC_MAXIMIZE)
                    {
                        nModify = 8 + nCasterLvl;
                    }
                    //Make Fort save
                    if (MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_NONE, OBJECT_SELF, fDelay))
                    {
                        nModify /= 2;
                    }
                    //Calculate damage
                    nHurt =  nModify;
                    //Set damage effect
                    eKill = EffectDamage(nHurt, DAMAGE_TYPE_POSITIVE);
                    //Apply damage effect and VFX impact
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
            }
        }
        else
        {
            if(GetIsReactionTypeFriendly(oTarget) || GetFactionEqual(oTarget))
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEALING_CIRCLE, FALSE));
                nHP = d8();
                //Enter Metamagic conditions
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                    nHP =8;//Damage is at max
                }
                if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                    nHP = nHP + (nHP/2); //Damage/Healing is +50%
                }
                //Set healing effect
                nHP = nHP + nCasterLvl;
                eHeal = EffectHeal(nHP);
                //Apply heal effect and VFX impact
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
            }
        }
        //Get next target in the shape
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation());
    }
}}

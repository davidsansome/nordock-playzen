#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Melf's Acid Arrow
//:: MelfsAcidArrow.nss
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
/*
    An acidic arrow springs from the caster's hands
    and does 3d6 acid damage to the target.  For
    every 3 levels the caster has the target takes an
    additional 1d6 per round.
*/
/////////////////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Aidan Scanlan
//:: Created On: 01/09/01
//:://////////////////////////////////////////////
//:: Update Pass By: Preston W, On: Aug 2, 2001

#include "NW_I0_SPELLS"

void RunMelfAcidImpact(int nSecondsRemaining, object oTarget);

void main()
{
    if(SpellSuccess()){
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
    int nCount, nDamage;
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_IMP_ACID_S);
    effect eArrow;
    int nDuration = GetCasterLevel(OBJECT_SELF) / 3;
    //figure out projectile timing
    float fDist = GetDistanceToObject(oTarget);
    float fDelay = (fDist/25.0);//(3.0 * log(fDist) + 2.0);
    //Check that there is at least one payload damage
    if (nDuration < 1)
    {
        nDuration = 1;
    }
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MELFS_ACID_ARROW));
         eArrow = EffectVisualEffect(245);
         //Make an SR check
         if(!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
         {
            //Roll initial damage
            nDamage = d6(3);
            //Enter Metamagic conditions
            if (nMetaMagic == METAMAGIC_MAXIMIZE)
            {
                nDamage = 18;//Damage is at max
            }
            else if (nMetaMagic == METAMAGIC_EMPOWER)
            {
                nDamage = nDamage + (nDamage/2);//Damage/Healing is +50%
            }
            //Set the initial damage effect
            eDam = EffectDamage(nDamage,DAMAGE_TYPE_ACID);
            //Apply the inital VFX impact and damage effect
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis,oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam,oTarget));
            //Apply the bonus damage
            nDuration = nDuration * 6;
            DelayCommand(6.0, RunMelfAcidImpact(nDuration, oTarget));
        }
    }
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eArrow, oTarget);
}}

void RunMelfAcidImpact(int nSecondsRemaining, object oTarget)
{
    if (GetIsDead(oTarget) == FALSE)
    {
       int nMetaMagic = GetMetaMagicFeat();
       if (nSecondsRemaining % 6 == 0)
       {
            //Roll damage
            int nDamage = d6();
            //check for metamagic
            if (nMetaMagic == METAMAGIC_EMPOWER)
            {
                nDamage = nDamage + (nDamage/2);
            }
            if (nMetaMagic == METAMAGIC_MAXIMIZE)
            {
                nDamage = 6;
            }
            effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_ACID);
            effect eVis = EffectVisualEffect(VFX_IMP_ACID_S);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
       }
       --nSecondsRemaining;
       if (nSecondsRemaining > 0)
       {
          DelayCommand(1.0f,RunMelfAcidImpact(nSecondsRemaining,oTarget));
       }
   }
   // Note:  if the target is dead during one of these second-long heartbeats,
   // the DelayCommand doesn't get run again, and the whole package goes away.
   // Do NOT attempt to put more than two parameters on the delay command.  They
   // may all end up on the stack, and that's all bad.  60 x 2 = 120.
}



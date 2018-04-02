#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Mass Heal
//:: [NW_S0_MasHeal.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Heals all friendly targets within 10ft to full
//:: unless they are undead.
//:: If undead they reduced to 1d4 HP.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 11, 2001
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
void main()
{
    if(SpellSuccess()){
  //Declare major variables
  effect eKill;
  effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
  effect eHeal;
  effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_G);
  effect eStrike = EffectVisualEffect(VFX_FNF_LOS_HOLY_10);
  int nTouch, nModify, nDamage, nHeal;
  int nMetaMagic = GetMetaMagicFeat();
  float fDelay;
  //Apply VFX area impact
  ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStrike, GetSpellTargetLocation());
  //Get first target in spell area
  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation());
  while(GetIsObjectValid(oTarget))
  {
      fDelay = GetRandomDelay();
      //Check to see if the target is an undead
      if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD && !GetIsReactionTypeFriendly(oTarget))
      {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MASS_HEAL));
            //Make a touch attack
            nTouch = TouchAttackRanged(oTarget);
            if (nTouch == 1)
            {
                if(!GetIsReactionTypeFriendly(oTarget))
                {
                    //Make an SR check
                    if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                    {
                        //Roll damage
                        nModify = d4();
                        //make metamagic check
                        if (nMetaMagic == METAMAGIC_MAXIMIZE)
                        {
                            nModify = 1;
                        }
                        //Detemine the damage to inflict to the undead
                        nDamage =  GetCurrentHitPoints(oTarget) - nModify;
                        //Set the damage effect
                        eKill = EffectDamage(nDamage, DAMAGE_TYPE_POSITIVE);
                        //Apply the VFX impact and damage effect
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    }
                 }
            }
      }
      else
      {
            //Make a faction check
            if(GetIsFriend(oTarget) && GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MASS_HEAL, FALSE));
                //Determine amount to heal
                nHeal = GetMaxHitPoints(oTarget);
                //Set the damage effect
                eHeal = EffectHeal(nHeal);
                //Apply the VFX impact and heal effect
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
            }
      }
      //Get next target in the spell area
      oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation());
   }
}}

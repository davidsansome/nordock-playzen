#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Chain Lightning
//:: NW_S0_ChLightn
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The primary target is struck with 1d6 per caster,
    1/2 with a reflex save.  1 secondary target per
    level is struck for 1d6 / 2 caster levels.  No
    repeat targets can be chosen.
*/
//:://////////////////////////////////////////////
//:: Created By: Brennon Holmes
//:: Created On:  March 8, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 26, 2001
//:: Update Pass By: Preston W, On: July 26, 2001

/*
bugfix by Kovi 2002.07.28
- successful saving throw and (improved) evasion was ignored for
 secondary targets,
- all secondary targets suffered exactly the same damage
2002.08.25
- primary target was not effected
*/

#include "NW_I0_SPELLS"
void main()
{
    if(SpellSuccess()){
    //Declare major variables
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDamage = d6(nCasterLevel);
    int nDamStrike;
    int nNumAffected = 0;
    int nMetaMagic = GetMetaMagicFeat();
    //Declare lightning effect connected the casters hands
    effect eLightning = EffectBeam(VFX_BEAM_LIGHTNING, OBJECT_SELF, BODY_NODE_HAND);;
    effect eVis  = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
    effect eDamage;
    object oFirstTarget = GetSpellTargetObject();
    object oHolder;
    object oTarget;
    location lSpellLocation;
    //Limit caster level
    if (nCasterLevel > 20)
    {
        nCasterLevel = 20;
    }
    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nDamage = 6 * nCasterLevel;//Damage is at max
    }
    if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        nDamage = nDamage + (nDamage/2); //Damage/is +50%
    }
    //Damage the initial target
    if(GetIsEnemy(oFirstTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oFirstTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CHAIN_LIGHTNING));
        //Make an SR Check
        if (!MyResistSpell(OBJECT_SELF, oFirstTarget))
        {
            //Adjust damage via Reflex Save or Evasion or Improved Evasion
            nDamStrike = GetReflexAdjustedDamage(nDamage, oFirstTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_ELECTRICITY);
            //Set the damage effect for the first target
            eDamage = EffectDamage(nDamStrike, DAMAGE_TYPE_ELECTRICAL);
            //Apply damage to the first target and the VFX impact.
            if(nDamStrike > 0)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oFirstTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oFirstTarget);
            }
        }
    }
    //Apply the lightning stream effect to the first target, connecting it with the caster
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oFirstTarget,0.5);
    //Reinitialize the lightning effect so that it travels from the first target to the next target
    eLightning = EffectBeam(VFX_BEAM_LIGHTNING, oFirstTarget, BODY_NODE_CHEST);
    //Halve the damage for all secondary targets beyond the first.
//    eDamage = EffectDamage(nDamage/2, DAMAGE_TYPE_ELECTRICAL);
    float fDelay = 0.2;
    int nCnt;
    //Get the first target in the spell shape
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oFirstTarget), TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while (GetIsObjectValid(oTarget) && nCnt < nCasterLevel)
    {
        //Make sure the caster's faction is not hit and the first target is not hit
        if (oTarget != oFirstTarget && GetIsEnemy(oTarget) && oTarget != OBJECT_SELF)
        {
            //Connect the new lightning stream to the older target and the new target
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oTarget,0.5));
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CHAIN_LIGHTNING));
            //Do an SR check
            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            {
                nDamage = d6(nCasterLevel);
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                    nDamage = 6 * nCasterLevel;//Damage is at max
                }
                if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                    nDamage = nDamage + (nDamage/2); //Damage/is +50%
                }
                //Adjust damage via Reflex Save or Evasion or Improved Evasion
                nDamStrike = GetReflexAdjustedDamage(nDamage, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_ELECTRICITY);
                //Apply the damage and VFX impact to the current target
                eDamage = EffectDamage(nDamStrike, DAMAGE_TYPE_ELECTRICAL);
                if(nDamStrike > 0) //age > 0)
                {
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget));
                }
            }
            oHolder = oTarget;
            //change the currect holder of the lightning stream to the current target
            eLightning = EffectBeam(VFX_BEAM_LIGHTNING, oHolder, BODY_NODE_CHEST);
            fDelay = fDelay + 0.1f;
        }
        //Count the number of targets that have been hit.
        if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
        {
            nCnt++;
        }
        //Get the next target in the shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oFirstTarget), TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
      }
 }}

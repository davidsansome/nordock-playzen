#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: [Circle of Doom]
//:: [NW_S0_CircDoom.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: All enemies of the caster take 1d8 damage +1
//:: per caster level (max 20).  Undead are healed
//:: for the same amount
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk and Keith Soleski
//:: Created On: Jan 31, 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 20, 2001
//:: Update Pass By: Preston W, On: July 25, 2001

#include "NW_I0_SPELLS"
void main()
{
    if(SpellSuccess()){
    //Declare major variables
    object oTarget;
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_M);
    effect eFNF = EffectVisualEffect(VFX_FNF_LOS_EVIL_10);
    effect eHeal;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    //Limit Caster Level
    if(nCasterLevel > 20)
    {
        nCasterLevel = 20;
    }
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    float fDelay;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFNF, GetSpellTargetLocation());
    //Get first target in the specified area
    oTarget =GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation());
    while (GetIsObjectValid(oTarget))
    {
        fDelay = GetRandomDelay();
        //Roll damage
        nDamage = d8() + nCasterLevel;
        //Make metamagic checks
        if (nMetaMagic == METAMAGIC_MAXIMIZE)
        {
            nDamage = 8 + nCasterLevel;
        }
        else if (nMetaMagic == METAMAGIC_EMPOWER)
        {
            nDamage = nDamage + (nDamage/2) + nCasterLevel;
        }
        //If the target is an allied undead it is healed
        if(GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CIRCLE_OF_DOOM, FALSE));
            //Set the heal effect
            eHeal = EffectHeal(nDamage);
            //Apply the impact VFX and healing effect
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
        }
        else
        {
            if(!GetIsReactionTypeFriendly(oTarget))
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CIRCLE_OF_DOOM));
                //Make an SR Check
                if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                {
                    if (MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_NEGATIVE, OBJECT_SELF, fDelay))
                    {
                        nDamage = nDamage/2;
                    }
                    //Set Damage
                    eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
                    //Apply impact VFX and damage
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
            }
        }
        //Get next target in the specified area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation());
    }
}
}

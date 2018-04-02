#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Hammer of the Gods
//:: [NW_S0_HammGods.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Does 1d8 damage to all enemies within the
//:: spells 20m radius and dazes them if a
//:: Will save is failed.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 12, 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 21, 2001
//:: Update Pass By: Preston W, On: Aug 1, 2001

#include "NW_I0_SPELLS"
void main()
{
    if(SpellSuccess()){
    //Declare major variables
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    effect eDam;
    effect eDaze = EffectDazed();
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

    effect eLink = EffectLinkEffects(eMind, eDaze);
    eLink = EffectLinkEffects(eLink, eDur);

    effect eVis = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY);
    effect eStrike = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);
    float fDelay;
    int nDamageDice = nCasterLvl/2;
    if(nDamageDice == 0)
    {
        nDamageDice = 1;
    }
    //Limit caster level
    if (nDamageDice > 5)
    {
        nDamageDice = 5;
    }
    int nDamage;
    //Apply the holy strike VFX
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStrike, GetSpellTargetLocation());
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetSpellTargetLocation());
    while (GetIsObjectValid(oTarget))
    {
       //Make faction checks
        if(!GetIsReactionTypeFriendly(oTarget)  && !GetIsFriend(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HAMMER_OF_THE_GODS));
            //Make SR Check
            if (!MyResistSpell(OBJECT_SELF, oTarget))
            {
                fDelay = GetRandomDelay(0.6, 1.3);
                //Roll damage
                nDamage = d8(nDamageDice);
                //Make metamagic checks
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                    nDamage = 8 * nDamageDice;
                }
                else if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                    nDamage = FloatToInt( IntToFloat(nDamage) * 1.5 );
                }
                //Make a will save for half damage and negation of daze effect
                if (MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_DIVINE, OBJECT_SELF, 0.5))
                {
                    nDamage = nDamage / 2;
                }
                else
                {
                    //Apply daze effect
                    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(d6())));
                }
                //Set damage effect
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_DIVINE );
                //Apply the VFX impact and damage effect
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
             }
        }
        //Get next target in shape
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetSpellTargetLocation());
    }
}}

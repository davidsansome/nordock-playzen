#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Word of Faith
//:: [NW_S0_WordFaith.nss]
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    A 30ft blast of divine energy rushs out from the
    Cleric blasting all enemies with varying effects
    depending on their HD.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Feb 5, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 11, 2001
//:: Sep 2002: fixed the 'level 8' instantkill problem
//:: description is slightly inaccurate but I won't change it

#include "NW_I0_SPELLS"
void main()
{
    if(SpellSuccess()){
        //Declare major variables
        object oTarget;
        int nCasterLevel = GetCasterLevel(OBJECT_SELF);
        effect eBlind = EffectBlindness();
        effect eStun = EffectStunned();
        effect eConfuse = EffectConfused();
        effect eDeath = EffectDeath();
        effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
        effect eSmite = EffectVisualEffect(VFX_FNF_WORD);
        effect eSonic = EffectVisualEffect(VFX_IMP_SONIC);
        effect eUnsummon =  EffectVisualEffect(VFX_IMP_UNSUMMON);
        effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
        effect eLink;
        int nHD;
        float fDelay;
        int nDuration = nCasterLevel / 2;
        //Apply the FNF VFX impact to the target location
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSmite, GetSpellTargetLocation());
        //Get the first target in the spell area
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetSpellTargetLocation());
        while (GetIsObjectValid(oTarget))
        {
            //Make a faction check
            if(GetIsEnemy(oTarget))
            {
                fDelay = GetRandomDelay(0.5, 2.0);
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_WORD_OF_FAITH));
                //Make SR check
                if(!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eSonic, oTarget);
                    //Check if the target is an outsider
                    if (GetRacialType(oTarget) == RACIAL_TYPE_OUTSIDER || GetRacialType(oTarget) == RACIAL_TYPE_ELEMENTAL)
                    {
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eUnsummon, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));
                    }
                    else
                    {
                        //Check the HD of the creature
                        nHD = GetHitDice(oTarget);
                        //Apply the appropriate effects based on HD
                        if (nHD >= 12)
                        {
                            eLink = EffectLinkEffects(eBlind, eDur);
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlind, oTarget, RoundsToSeconds(nDuration)));
                        }
                        else if (nHD >= 8 && nHD < 12)
                        {
                            eLink = EffectLinkEffects(eStun, eMind);
                            eLink = EffectLinkEffects(eLink, eDur);
                            eLink = EffectLinkEffects(eLink, eBlind);

                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
                        }
                        else if (nHD > 4 && nHD < 8)
                        {
                            eLink = EffectLinkEffects(eStun, eMind);
                            eLink = EffectLinkEffects(eLink, eDur);
                            eLink = EffectLinkEffects(eLink, eConfuse);
                            eLink = EffectLinkEffects(eLink, eBlind);

                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
                        }
                        else
                        {
                           if(!GetIsImmune(oTarget, IMMUNITY_TYPE_DEATH))
                           {
                                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                           }
                           DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));
                        }
                    }
                }
            }
            //Get the next target in the spell area
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetSpellTargetLocation());
        }
}}

#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Doom
//:: NW_S0_Doom.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    If the target fails a save they recieve a -2
    penalty to all saves, attack rolls, damage and
    skill checks for the duration of the spell.

    July 22 2002 (BK): Made it mind affecting.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 22, 2001
//:://////////////////////////////////////////////


#include "NW_I0_SPELLS"
void main()
{

    if(SpellSuccess()){
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_DOOM);
    effect eLink = CreateDoomEffectsLink();

    int nLevel = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    //Meta-Magic checks
    if(nMetaMagic == METAMAGIC_EXTEND)
    {
        nLevel *= 2;
    }
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DOOM));
        //Spell Resistance and Saving throw
        if (!MyResistSpell(OBJECT_SELF, oTarget) && !/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_MIND_SPELLS))
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink , oTarget, TurnsToSeconds(nLevel));
        }
    }
}
}

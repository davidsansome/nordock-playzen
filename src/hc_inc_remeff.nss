#include "subraces"
void RemoveEffects(object oDead)
{
    //Declare major variables
    object oTarget = oDead;
    effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION);
    int bValid;

    effect eBad = GetFirstEffect(oTarget);
    //Search for negative effects
    while(GetIsEffectValid(eBad))
    {
        int nEtype=GetEffectType(eBad);
        if (nEtype == EFFECT_TYPE_ABILITY_DECREASE ||
            nEtype == EFFECT_TYPE_INVISIBILITY ||
            nEtype == EFFECT_TYPE_AC_DECREASE ||
            nEtype == EFFECT_TYPE_ATTACK_DECREASE ||
            nEtype == EFFECT_TYPE_DAMAGE_DECREASE ||
            nEtype == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
            nEtype == EFFECT_TYPE_SAVING_THROW_DECREASE ||
            nEtype == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
            nEtype == EFFECT_TYPE_SKILL_DECREASE ||
            nEtype == EFFECT_TYPE_BLINDNESS ||
            nEtype == EFFECT_TYPE_DEAF ||
            nEtype == EFFECT_TYPE_PARALYZE ||
            nEtype == EFFECT_TYPE_NEGATIVELEVEL ||
            nEtype == EFFECT_TYPE_FRIGHTENED ||
            nEtype == EFFECT_TYPE_DAZED ||
            nEtype == EFFECT_TYPE_CONFUSED ||
            nEtype == EFFECT_TYPE_POISON ||
            nEtype == EFFECT_TYPE_DISEASE
                )
            {
                //Remove effect if it is negative.
                Subraces_SafeRemoveEffect(oTarget, eBad);
            }
        eBad = GetNextEffect(oTarget);
    }
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RESTORATION, FALSE));

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);

    // * May 2002: Removed this because ActionRest is no longer an instant.
    // * rest the player
    //AssignCommand(oDead, ActionRest());
}


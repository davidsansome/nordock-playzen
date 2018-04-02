#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Implosion
//:: NW_S0_Implosion.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All persons within a 5ft radius of the spell must
    save at +3 DC or die.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 13, 2001
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
void main()
{
    if(SpellSuccess()){
    //Declare major variables
    object oTarget;
    effect eDeath = EffectDeath(TRUE);
    effect eImplode= EffectVisualEffect(VFX_FNF_IMPLOSION);
    float fDelay;
    //Apply the implose effect
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImplode, GetSpellTargetLocation());
    //Get the first target in the shape
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation());
    while (GetIsObjectValid(oTarget))
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
           //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_IMPLOSION));
           fDelay = GetRandomDelay(0.4, 1.2);
           //Make SR check
           if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
           {
                //Make Reflex save
                if(!MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC()+3, SAVING_THROW_TYPE_DEATH, OBJECT_SELF, fDelay))
                {
                    //Apply death effect and the VFX impact
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));
                }
           }
        }
       //Get next target in the shape
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation());
    }
}
}

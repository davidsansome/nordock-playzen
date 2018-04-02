#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Bestow Curse
//:: NW_S0_BesCurse.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Afflicted creature must save or suffer a -2 penalty
    to all ability scores. This is a supernatural effect.
*/
//:://////////////////////////////////////////////
//:: Created By: Bob McCabe
//:: Created On: March 6, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk
//:: VFX Pass By: Preston W, On: June 20, 2001
//:: Update Pass By: Preston W, On: July 20, 2001

#include "NW_I0_SPELLS"
void main()
{
    if(SpellSuccess()){
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
    effect eCurse = EffectCurse(2, 2, 2, 2, 2, 2);

    //Make sure that curse is of type supernatural not magical
    eCurse = SupernaturalEffect(eCurse);
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Signal spell cast at event
        SignalEvent(oTarget, EventSpellCastAt(oTarget, SPELL_BESTOW_CURSE));
         //Make SR Check
         if (!MyResistSpell(OBJECT_SELF, oTarget))
         {
            //Make Will Save
            if (!/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC()))
            {
                //Apply Effect and VFX
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCurse, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            }
        }
    }
}}

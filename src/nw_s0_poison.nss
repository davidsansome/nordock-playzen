#include "nx_sf_include"
//::///////////////////////////////////////////////
//:: Poison
//:: NW_S0_Poison.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Must make a touch attack. If successful the target
    is struck down with wyvern poison.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 22, 2001
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
void main()
{
    if(SpellSuccess()){
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect ePoison = EffectPoison(POISON_LARGE_SCORPION_VENOM);
    int nTouch = 1;//
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_POISON));
        //Make touch attack
        if (nTouch > 0)
        {
            //Make SR Check
            if (!MyResistSpell(OBJECT_SELF, oTarget))
            {
                //Apply the poison effect and VFX impact
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePoison, oTarget);
            }
        }
    }
}
}

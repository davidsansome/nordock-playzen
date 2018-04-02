//cohort_ac8, built from nw_ch_ac8
//
//Modified by Edward Beck (0100010) for Cohort system on September 1, 2002.
//Renamed in order to maintain independance from Bioware files
//and for easier itegration.

//::///////////////////////////////////////////////
//:: Henchmen: On Disturbed
//:: NW_C2_AC8
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determine Combat Round on disturbed.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//::///////////////////////////////////////////

#include "paus_inc_generic"

void main()
{
    object oTarget = GetLastDisturbed();
    if(!GetIsObjectValid(GetAttemptedAttackTarget()) && !GetIsObjectValid(GetAttemptedSpellTarget())) {
        if(GetIsObjectValid(oTarget))
            DetermineCombatRound(oTarget);
    }
    if(GetSpawnInCondition(NW_FLAG_DISTURBED_EVENT))
        SignalEvent(OBJECT_SELF, EventUserDefined(1008));
}

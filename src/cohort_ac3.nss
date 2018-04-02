//cohort_ac3, built from nw_ch_ac3
//originally modified by Pausanias.
//
//Modified by Edward Beck (0100010) for Cohort system on September 1, 2002.
//Renamed in order to maintain independance from Bioware files
//and for easier itegration.


//::///////////////////////////////////////////////
//:: Associate: End of Combat End
//:: NW_CH_AC3
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Calls the end of combat script every round
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//:://////////////////////////////////////////////
#include "paus_inc_generic"

void main()
{
    if(!GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
        DetermineCombatRound();
    if(GetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT))
        SignalEvent(OBJECT_SELF, EventUserDefined(1003));
}

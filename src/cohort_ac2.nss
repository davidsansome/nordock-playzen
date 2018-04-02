//cohort_ac2, built from nw_ch_ac2
//originally modified by Pausanias.
//
//Modified by Edward Beck (0100010) for Cohort system on September 1, 2002.
//Renamed in order to maintain independance from Bioware files
//and for easier itegration.


//::///////////////////////////////////////////////
//:: Associate: On Percieve
//:: NW_CH_AC2
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 19, 2001
//:://////////////////////////////////////////////
#include "paus_inc_generic"

void main()
{
    //This is the equivalent of a force conversation bubble, should only be used if you want an NPC
    //to say something while he is already engaged in combat.
    if(GetSpawnInCondition(NW_FLAG_SPECIAL_COMBAT_CONVERSATION))
        ActionStartConversation(OBJECT_SELF);

    if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND)) {
        //Do not bother checking the last target seen if already fighting
        if(!GetIsObjectValid(GetAttemptedAttackTarget()) &&
           !GetIsObjectValid(GetAttackTarget()) &&
           !GetIsObjectValid(GetAttemptedSpellTarget()))
        {
            //Check if the last percieved creature was actually seen
            if(GetLastPerceptionSeen()) {
                if(GetIsEnemy(GetLastPerceived())) {
                    SetFacingPoint(GetPosition(GetLastPerceived()));
                    DetermineCombatRound();
                }
                //Linked up to the special conversation check to initiate a special one-off conversation
                //to get the PCs attention
                else if(GetSpawnInCondition(NW_FLAG_SPECIAL_CONVERSATION) && GetIsPC(GetLastPerceived()))
                    ActionStartConversation(OBJECT_SELF);
            }
        }
    }
    if(GetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT))
        SignalEvent(OBJECT_SELF, EventUserDefined(1002));
}

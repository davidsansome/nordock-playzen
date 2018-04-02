//cohort_ac6, built from nw_ch_ac6
//
//Modified by Edward Beck (0100010) for Cohort system on September 1, 2002.
//Renamed in order to maintain independance from Bioware files
//and for easier itegration.

/*
    If already fighting then ignore, else determine
    combat round
*/

#include "paus_inc_generic"

void main()
{

    if(!GetAssociateState(NW_ASC_IS_BUSY)) {
        if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND) && GetCurrentAction() != ACTION_FOLLOW) {
            if(!GetIsObjectValid(GetAttackTarget()) && !GetIsObjectValid(GetAttemptedSpellTarget())) {
                if(GetIsObjectValid(GetLastHostileActor())) {
                    if(GetAssociateState(NW_ASC_MODE_DEFEND_MASTER)) {
                        if(!GetIsObjectValid(GetLastHostileActor(GetRealMaster())))
                            DetermineCombatRound();
                    }
                    else
                        DetermineCombatRound();
                }
            }
            else {
                object oTarget = GetAttackTarget();
                object oAttacker = GetLastDamager();
                if (GetIsObjectValid(oAttacker) && oTarget != oAttacker && GetIsEnemy(oAttacker) &&
                   ( GetTotalDamageDealt() > (GetMaxHitPoints(OBJECT_SELF) / 4) ||
                    GetHitDice(oAttacker) > GetHitDice(oTarget) ) )
                {
                  DetermineCombatRound(oAttacker);
                }
            }
        }
    }
    if(GetSpawnInCondition(NW_FLAG_DAMAGED_EVENT))
        SignalEvent(OBJECT_SELF, EventUserDefined(1006));
}

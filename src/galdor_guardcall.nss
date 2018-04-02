//::///////////////////////////////////////////////
//:: Default: End of Combat Round
//:: NW_C2_DEFAULT3
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Calls the end of combat script every round
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//:://////////////////////////////////////////////

#include "NW_I0_GENERIC"
void main()
{
    if (GetCurrentHitPoints() < GetMaxHitPoints()/2)
    {
        if (GetLocalInt(OBJECT_SELF, "CalledGuards") != 1)
        {
            SpeakString("Guards!  Come to my aid!");
            object oArea = GetArea(OBJECT_SELF);
            object oHostile = GetLastHostileActor();
            object oGuard = GetFirstObjectInArea(oArea);
            while (GetIsObjectValid(oGuard))
            {
                string sResRef = GetResRef(oGuard);
                if ((sResRef == "capttucker") || (sResRef == "benzorelite002"))
                {
                    SetIsTemporaryEnemy(oHostile, oGuard);
                    AssignCommand(oGuard, ActionAttack(oHostile));
                }
                oGuard = GetNextObjectInArea(oArea);
            }
            SetLocalInt(OBJECT_SELF, "CalledGuards", 1);
        }
    }

    if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
    {
        DetermineSpecialBehavior();
    }
    else if(!GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
    {
       DetermineCombatRound();
    }
    if(GetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1003));
    }
}



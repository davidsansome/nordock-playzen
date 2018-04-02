//::///////////////////////////////////////////////
//:: Default On Heartbeat
//:: NW_C2_DEFAULT1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script will have people perform default
    animations.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 23, 2001
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"
#include "bm_scroll_inc"

void main()
{
    if(GetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY))
    {
        if(TalentAdvancedBuff(40.0))
        {
            SetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY, FALSE);
            return;
        }
    }

    if(GetSpawnInCondition(NW_FLAG_DAY_NIGHT_POSTING))
    {
        int nDay = FALSE;
        if(GetIsDay() || GetIsDawn())
        {
            nDay = TRUE;
        }
        if(GetLocalInt(OBJECT_SELF, "NW_GENERIC_DAY_NIGHT") != nDay)
        {
            if(nDay == TRUE)
            {
                SetLocalInt(OBJECT_SELF, "NW_GENERIC_DAY_NIGHT", TRUE);
            }
            else
            {
                SetLocalInt(OBJECT_SELF, "NW_GENERIC_DAY_NIGHT", FALSE);
            }
            WalkWayPoints();
        }
    }

    if(!GetHasEffect(EFFECT_TYPE_SLEEP))
    {
        if(!GetIsPostOrWalking())
        {
            if(!GetIsObjectValid(GetAttemptedAttackTarget()) && !GetIsObjectValid(GetAttemptedSpellTarget()))
            {
                if(!GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN)))
                {
                    if(!GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL) && !IsInConversation(OBJECT_SELF))
                    {
                        if(GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS) || GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS_AVIAN))
                        {
                            PlayMobileAmbientAnimations();
                        }
                        else if(GetIsEncounterCreature() &&
                        !GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN)))
                        {
                            PlayMobileAmbientAnimations();
                        }
                        else if(GetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS) &&
                           !GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN)))
                        {
                            PlayImmobileAmbientAnimations();
                        }
                    }
                    else
                    {
                        DetermineSpecialBehavior();
                    }
                }
                else
                {
                    //DetermineCombatRound();
                }
            }
        }
    }
    else
    {
        if(GetSpawnInCondition(NW_FLAG_SLEEPING_AT_NIGHT))
        {
            effect eVis = EffectVisualEffect(VFX_IMP_SLEEP);
            if(d10() > 6)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
            }
        }
    }
    if(GetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1001));
    }
    //Cycle through all the players to see if they have a scroll waiting to be created.
    if(SCROLLWAITTIME) //Only bother if scrollwait time is more than 0
    {
        object oPlayer = GetFirstPC();
        object oMod = GetModule();
        while (oPlayer != OBJECT_INVALID)
        {
            string sPCName=GetName(oPlayer);
            string sCDK=GetPCPublicCDKey(oPlayer);
            if(GetLocalInt(oMod, "ScrollCreated"+sPCName+sCDK))
            //player has a scroll waiting.
            {
                if ( GetIsInCombat(oPlayer) )
                {
                   SetLocalInt(oMod, "ScrollCreated"+sPCName+sCDK, 0);
                   SetLocalInt(oMod, "nScrollCreatedHour"+sPCName+sCDK, 0);
                   SetLocalInt(oMod, "nScrolLCreatedDay"+sPCName+sCDK, 0);
                   SetLocalInt(oMod, "nScrollCreatedMonth"+sPCName+sCDK, 0);
                   SetLocalInt(oMod, "nScrolLCreatedYear"+sPCName+sCDK, 0);
                   SetLocalInt(oMod, "nScrollCreationTime"+sPCName+sCDK, 0);
                   SetLocalString(oMod, "sCreatedScroll"+sPCName+sCDK, "");
                   SendMessageToPC(oPlayer, "Entering combat interrupts your attempt at making a scroll");
                }
                else
                {

                    int nCreatedHour = GetLocalInt(oMod, "nScrollCreatedHour"+sPCName+sCDK);
                    int nCreatedDay = GetLocalInt(oMod, "nScrolLCreatedDay"+sPCName+sCDK);
                    int nCreatedMonth = GetLocalInt(oMod, "nScrollCreatedMonth"+sPCName+sCDK);
                    int nCreatedYear = GetLocalInt(oMod, "nScrolLCreatedYear"+sPCName+sCDK);

                    int nScrollCreationTime = GetLocalInt(oMod, "nScrollCreationTime"+sPCName+sCDK);
                    int nCurrentHour = GetTimeHour();
                    int nCurrentDay = GetCalendarDay();
                    int nCurrentMonth = GetCalendarMonth();
                    int nCurrentYear = GetCalendarYear();

                    int iHowLong;
                    int nCanCreate = 1;

                    iHowLong = nCurrentHour - nCreatedHour;
                    iHowLong = iHowLong + ((nCurrentDay - nCreatedDay) * 24);
                    iHowLong = iHowLong + ((nCurrentMonth - nCreatedMonth) * 24 * 28);
                    iHowLong = iHowLong + ((nCurrentYear - nCreatedYear) * 24 * 28 * 12);

                    if (iHowLong >= nScrollCreationTime) //Time to check to see if PC can still make scroll
                    {
                       location lCreatedLoc = GetLocalLocation(oMod, "lScrollCreationLoc"+sPCName+sCDK);

                       if (nCanCreate)
                       {
                           string sScroll = GetLocalString(oMod, "sCreatedScroll"+sPCName+sCDK);
                           CreateItemOnObject(sScroll, oPlayer);
                       }
                       SetLocalInt(oMod, "ScrollCreated"+sPCName+sCDK, 0);
                       SetLocalInt(oMod, "nScrollCreatedHour"+sPCName+sCDK, 0);
                       SetLocalInt(oMod, "nScrolLCreatedDay"+sPCName+sCDK, 0);
                       SetLocalInt(oMod, "nScrollCreatedMonth"+sPCName+sCDK, 0);
                       SetLocalInt(oMod, "nScrolLCreatedYear"+sPCName+sCDK, 0);
                       SetLocalInt(oMod, "nScrollCreationTime"+sPCName+sCDK, 0);
                       SetLocalString(oMod, "sCreatedScroll"+sPCName+sCDK, "");
                    }
                }
            }
            oPlayer = GetNextPC();
        }
    }

}

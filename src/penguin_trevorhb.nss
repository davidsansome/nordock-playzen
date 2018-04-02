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

void DisappearCow(object oCow)
{
    if (GetIsDead(OBJECT_SELF))
        return;

    effect eSummon = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSummon, GetLocation(oCow));
    DestroyObject(oCow);
}

void ReappearCow(object oMarker)
{
    if (GetIsDead(OBJECT_SELF))
        return;

    object oCow = CreateObject(OBJECT_TYPE_CREATURE, "trevorcow", GetLocation(oMarker));
    effect eSummon = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSummon, GetLocation(oCow));
    AssignCommand(oCow, SetFacing(135.0));
    ClearAllActions();
    WalkWayPoints();
}

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

    // Magical Trevor specific
    if ((GetCurrentAction() != ACTION_ATTACKOBJECT) &&
        (!GetIsDead(OBJECT_SELF)) &&
        (GetLocalInt(OBJECT_SELF, "TrevorDisabled") != 1))
    {
        // Only do this once every 6 heartbeats
        if (GetLocalInt(OBJECT_SELF, "TrevorCountdown") > 0)
        {
            SetLocalInt(OBJECT_SELF, "TrevorCountdown", GetLocalInt(OBJECT_SELF, "TrevorCountdown")-1);
            return;
        }
        SetLocalInt(OBJECT_SELF, "TrevorCountdown", 6);

        // Disappear the cow
        object oCow = GetObjectByTag("TrevorCow");
        if (!GetIsObjectValid(oCow))
            return;

        ActionCastFakeSpellAtObject(SPELL_RAY_OF_FROST, oCow);
        DelayCommand(3.0f, DisappearCow(oCow));

        // Reappear the cow
        object oMarker = GetObjectByTag("TrevorCowMarker");
        DelayCommand(8.0f, ActionAttack(oMarker));
        DelayCommand(11.0f, ReappearCow(oMarker));
        DelayCommand(14.0f, SpeakString("Yeah yeah, the cow is back!"));
    }
}

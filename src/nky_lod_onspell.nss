//::///////////////////////////////////////////////
//:: Default: On Spell Cast At
//:: NW_C2_DEFAULTB
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This determines if the spell just cast at the
    target is harmful or not.

    Changes by Nakey:
    Makes Lord of Despair laugh at the players if
    they cast time stop because he is now immune
    to it.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Dec 6, 2001
//:://////////////////////////////////////////////
//:: Edited By: Nakey
//:: Edited On: Jan 24, 2004
//:://////////////////////////////////////////////

#include "NW_I0_GENERIC"

void main()
{
    object oCaster = GetLastSpellCaster();
    if(GetLastSpellHarmful())
    {
        if(
         !GetIsObjectValid(GetAttackTarget()) &&
         !GetIsObjectValid(GetAttemptedSpellTarget()) &&
         !GetIsObjectValid(GetAttemptedAttackTarget()) &&
         GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN))
        )
        {
            if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
            {
                DetermineSpecialBehavior(oCaster);
            }
            else
            {
                DetermineCombatRound(oCaster);
            }
            //Shout Attack my target, only works with the On Spawn In setup
            SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);
            //Shout that I was attacked
            SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK);
        }
    }
    if(GetSpawnInCondition(NW_FLAG_SPELL_CAST_AT_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1011));
    }
    // Makes Lord of Despair laugh at the player(s) if they cast IGMS because hes now immune to it
    if(GetLastSpell() == SPELL_ISAACS_GREATER_MISSILE_STORM && GetIsPC(oCaster) && GetIsEnemy(oCaster))
    {
        FloatingTextStringOnCreature("Hahaha. Puny mortal fool! Your spells are useless.", OBJECT_SELF, FALSE);
        PlayVoiceChat(VOICE_CHAT_LAUGH, OBJECT_SELF);
    }
}

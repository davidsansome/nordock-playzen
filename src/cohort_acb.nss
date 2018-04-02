//cohort_acb, built from nw_ch_acb
//
//Modified by Edward Beck (0100010) for Cohort system on September 1, 2002.
//Renamed in order to maintain independance from Bioware files
//and for easier itegration.

//::///////////////////////////////////////////////
//:: Henchmen: On Spell Cast At
//:: NW_CH_ACB
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This determines if the spell just cast at the
    target is harmful or not.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Dec 6, 2001
//:://////////////////////////////////////////////

#include "paus_inc_generic"

void main()
{
    object oCaster = GetLastSpellCaster();

    if(GetLastSpellHarmful()) {
        SetCommandable(TRUE);
        if(!GetIsObjectValid(GetAttackTarget()) &&
            !GetIsObjectValid(GetAttemptedSpellTarget()) &&
            !GetIsObjectValid(GetAttemptedAttackTarget()) &&
            !GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN)) &&
            !GetIsFriend(oCaster))
        {
            SetCommandable(TRUE);
            //Shout Attack my target, only works with the On Spawn In setup
            SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);
            //Shout that I was attacked
            SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK);
            DetermineCombatRound(oCaster);
        }
    }
}

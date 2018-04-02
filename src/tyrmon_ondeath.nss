//::///////////////////////////////////////////////
//:: Default:On Death
//:: NW_C2_DEFAULT7
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Shouts to allies that they have been killed
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 25, 2001
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"

void main()
{
    int nClass = GetLevelByClass(CLASS_TYPE_COMMONER);
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
    if(nClass > 0 && (nAlign == ALIGNMENT_GOOD || nAlign == ALIGNMENT_NEUTRAL))
    {
        object oKiller = GetLastKiller();
        AdjustAlignment(oKiller, ALIGNMENT_EVIL, 5);
    }

    SpeakString("NW_I_AM_DEAD", TALKVOLUME_SILENT_TALK);
    //Shout Attack my target, only works with the On Spawn In setup
    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);
    if(GetSpawnInCondition(NW_FLAG_DEATH_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1007));
    }

    object oSpawnWP = GetObjectByTag("WP_SPAWN_SWORD");
    object oRecallWP = GetObjectByTag("WP_SPAWN_PORTAL");
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL, FALSE), GetLocation(oSpawnWP), 3.0);
    CreateObject(OBJECT_TYPE_PLACEABLE, "recall_to_totd", GetLocation(oRecallWP),TRUE);
    CreateObject(OBJECT_TYPE_PLACEABLE, "totd_at_hider", GetLocation(oSpawnWP), TRUE);
    CreateObject(OBJECT_TYPE_PLACEABLE, "totd_portaltohea", GetLocation(oSpawnWP), TRUE);
    DestroyObject(GetObjectByTag("recall_to_totd"), 3600.0);





}

//::///////////////////////////////////////////////
//:: Default: On Spawn In
//:: NW_C2_DEFAULT9
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines the course of action to be taken
    after having just been spawned in
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 25, 2001
//:://////////////////////////////////////////////

// change by Q'el, loot generation code no longer required here, so no need for header
//#include "RR_TREASURE"
//
#include "NW_I0_GENERIC"

void main()
{
    SetListeningPatterns();    // Goes through and sets up which shouts the NPC will listen to.
    WalkWayPoints();           // Optional Parameter: void WalkWayPoints(int nRun = FALSE, float fPause = 1.0)
                               // 1. Looks to see if any Way Points in the module have the tag "WP_" + NPC TAG + "_0X", if so walk them
                               // 2. If the tag of the Way Point is "POST_" + NPC TAG the creature will return this way point after
                               //    combat.
    if (!((GetClassByPosition(1,OBJECT_SELF)==CLASS_TYPE_ANIMAL)||(GetClassByPosition(1,OBJECT_SELF)==CLASS_TYPE_VERMIN)))
    {
         SetLocalInt(OBJECT_SELF, "noloot", TRUE);
    }
    // Applies a permanent Ultravision effect to combat darkness users
ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectUltravision(), OBJECT_SELF);
}



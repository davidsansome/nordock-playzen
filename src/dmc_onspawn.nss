//::///////////////////////////////////////////////
//:: DM Console - OnSpawn
//:: dmc_onspawn
//:: Copyright (c) 2003 Kelby Pethybridge.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Kelby Pethybridge
//:: Created On: 06 November 2003
//:://////////////////////////////////////////////

#include "nw_i0_generic"

void main()
{
    SetListening(OBJECT_SELF,TRUE);
    SetListenPattern(OBJECT_SELF,"**",2001);
}

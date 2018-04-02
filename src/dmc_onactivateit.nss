//::///////////////////////////////////////////////
//:: DM Console - OnActivateItem
//:: dmc_onactivateit
//:: Copyright (c) 2003 Kelby Pethybridge.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Kelby Pethybridge
//:: Created On: 06 November 2003
//:://////////////////////////////////////////////

#include "dmc_main"

void main()
{
    if(GetTag(GetItemActivated()) == "DMConsoleRecallRod")
    {
        spawn(GetItemActivator());
    }
}

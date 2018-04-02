// Removed by Grug 18-Apr-2004 - nodrops are now set by item flag
//#include "ats_inc_nodrop"

void ATS_OnUnAcquireItem(object oItemLost, object oLostBy, object oAcquiredFrom)
{
    object oPlayer = GetLocalObject(oItemLost, "ats_obj_possessor");
    if(GetIsObjectValid(oPlayer) == FALSE)
        oPlayer = oAcquiredFrom;
//    ATS_CheckForRemovedNoDropItems(oPlayer, oItemLost);

}

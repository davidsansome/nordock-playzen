//hc_dc_heartbeat
//Archaegeo June 27, 2002
// Called by the Death Corpse itself.
// Deletes the corpse if empty and gives items back if player is alive.

#include "hc_inc"
#include "hc_inc_transfer"

void main()
{
    object oDC=OBJECT_SELF;
    object oOwner=GetLocalObject(oDC,"Owner");
// If im empty, destroy me.
    if(GetIsObjectValid(GetFirstItemInInventory(oDC))==FALSE)
       DestroyObject(oDC);
    if(GetIsObjectValid(oOwner)==FALSE)
    {
        oOwner=GetFirstPC();
        while(GetIsObjectValid(oOwner))
        {
            if(GetName(oOwner)==GetLocalString(oDC,"Name"))
            break;
            oOwner=GetNextPC();
        }
    }
    if(GetIsObjectValid(oOwner)==FALSE) return;
// If my creator has returned to life, give his stuff back
    int nPS=GPS(oOwner);
    if(GetIsObjectValid(oOwner) &&
       GetCurrentHitPoints(oOwner) > 0 &&
       (nPS == PWS_PLAYER_STATE_ALIVE ||
       nPS == PWS_PLAYER_STATE_DISABLED ||
       nPS == PWS_PLAYER_STATE_RECOVERY)
       )
    {
        if(GetLocalInt(oOwner,"MOVING")) return;
        hcTransferObjects(oDC, oOwner, 1);
// Then destroy myself after 3 seconds to let it all be done
        DestroyObject(oDC,3.0);
    }
}

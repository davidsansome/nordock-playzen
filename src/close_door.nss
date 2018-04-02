/////////////////////////////////////
// sc_safedoor
//
// Created By: David Sauve
// On:         August 14, 2002
//
// Use: Call this script from the On_Heartbeat function
//      of a door and it will door will close itself
//      whenever it's opened and left that way.  Also,
//      the door will be locked at night, and unlocked
//      during the day.  Perfect for shops!
/////////////////////////////////////

void main()
{
    string sDistance = "PlayerLastDistance";

    object oPlayer       = GetLastUsedBy();
    float  fLastDistance = GetLocalFloat(OBJECT_SELF, sDistance);      // This returns 0.0f if not set
    float  fDistance     = GetDistanceToObject(oPlayer);

    // Close the door if it's left open and the player has moved away
    if ((fDistance) > (fLastDistance))
    {
        ActionCloseDoor(OBJECT_SELF);
    }

    // If it's day, unlock the door
    // Otherwise, lock it up for the night
    //SetLocked(OBJECT_SELF, !(GetIsDay()));

    // Save the last distance to compare during the next On_Heartbeat
    SetLocalFloat(OBJECT_SELF, sDistance, fDistance);
}

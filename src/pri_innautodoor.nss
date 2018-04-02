//::///////////////////////////////////////////////
//:: Closes and locks door when all Roommates are in Room
//:: pri_innautodoor.nss
//:: Copyright (c) 2002 Shepherd Software Inc.
//:://////////////////////////////////////////////
/*

This script goes on the Triggers inside an inn room.
It's main function is to count how many roommates
are in the room and when it gets to the max number of
roommates the door to the room is closed and locked.

It also unlocks and opens the door when the players
go to leave the room.

Works for both Normal and Poor Rooms. Suite Rooms
have their own special AutoDoor Trigger called
"_rsa_stautodoor."

*/
//:://////////////////////////////////////////////
//:: Created By: Russell S. Ahlstrom
//:: Created On: July 11, 2002
//:://////////////////////////////////////////////

#include "pri_inc"

void main()
{
 object oPC = GetEnteringObject();

 GetInnArea(oPC);

 object oTrigger = OBJECT_SELF;
 string sTrigger = GetTag(oTrigger);
 int iRoomMates = GetLocalInt(oTrigger, "RSA_RoomMates");
 if (GetIsPC(oPC))
  {
   object oDoor = GetNearestObjectByTag("RoomDoor");
   if (GetLocked(oDoor)== FALSE)
  {
   if (iRoomMates == 0 && sTrigger == "NormalAutoDoor") iRoomMates = GetLocalInt(oPC, "RSA_RMNorm");
   if (iRoomMates == 0 && sTrigger == "PoorAutoDoor") iRoomMates = GetLocalInt(oPC, "RSA_RMPoor");
   iRoomMates--;
   SetLocalInt(oTrigger, "RSA_RoomMates", iRoomMates);
   if (iRoomMates == 0)
   {
    ActionCloseDoor(oDoor);
    SetLocked(oDoor, TRUE);
   }
  }
 else
  {
   SetLocked(oDoor, FALSE);
   ActionOpenDoor(oDoor);
   SetLocalInt(oTrigger, "RSA_RoomMates", 0);
  }
 }
}

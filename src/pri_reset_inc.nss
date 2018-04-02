//::///////////////////////////////////////////////
//:: Included file for reset Room
//:: pri_reset_inc
//:: Copyright (c) 2002 Shepherd Software Inc.
//:://////////////////////////////////////////////
/*

This script is activied on a DM Option in the Innkeeper
Conversation. If a player logs out when a room is rented,
it will need to be reset so that the room can be rented out
again without having to wait for the player to log back in and
exit the room.

There are two commands in this script one is ResetRoom() which
is used for normal rooms and poor rooms and the other is ResetRoomRich()
which is used to reset the Suite since that command is much more
difficult.

In order for these scripts to work, there must be a Servant and a
Butler in your Inn as they are assigned the commands to close, lock,
and clean up the rooms.


*/
//:://////////////////////////////////////////////
//:: Created By: Russell S. Ahlstrom
//:: Created On: July 11, 2002
//:://////////////////////////////////////////////

#include "pri_inc"

void ResetRoom(string sNRoom, float fX, float fY)
{
object oPC = GetPCSpeaker();

GetInnArea(oPC);

string sInnKeeper = GetLocalString(oPC, "RSA_InnKeeper");
string sRoomArea = GetLocalString(oPC, "RSA_RoomArea");
string sServant = GetLocalString(oPC, "RSA_Servant");
string sServantCommand = GetLocalString(oPC, "RSA_ServantCommand");
string sServantRespond = GetLocalString(oPC, "RSA_ServantRespond");

object oArea = GetObjectByTag(sRoomArea);
vector vTrigger = Vector(fX, fY, 0.0);
location lTrigger = Location(oArea, vTrigger, 0.0);
object oTrigger = GetNearestObjectToLocation(OBJECT_TYPE_TRIGGER, lTrigger);
object oInnKeeper = GetObjectByTag(sInnKeeper);
object oDoor = GetNearestObjectToLocation(OBJECT_TYPE_DOOR, lTrigger);
object oServant = GetObjectByTag(sServant);
object oWayPoint = GetObjectByTag("POST_"+sServant);

SetLocalInt(oTrigger, "RSA_RoomMates", 0);
SetLocalInt(oInnKeeper, sNRoom, 0);

AssignCommand(oInnKeeper, ActionSpeakString(sServantCommand));
AssignCommand(oServant, ClearAllActions());
AssignCommand(oServant, ActionSpeakString(sServantRespond));
AssignCommand(oServant, ActionCloseDoor(oDoor));
SetLocked(oDoor, TRUE);
AssignCommand(oServant, ActionMoveToObject(oWayPoint, FALSE));
AssignCommand(oServant, ActionDoCommand(SetFacing(GetFacing(oWayPoint))));
}

void ResetRoomRich(string sNRoom, float fX, float fY)
{
object oPC = GetPCSpeaker();

GetInnArea(oPC);

string sInnKeeper = GetLocalString(oPC, "RSA_InnKeeper");
string sRoomArea = GetLocalString(oPC, "RSA_RoomArea");
string sServant = GetLocalString(oPC, "RSA_Servant");
string sButler = GetLocalString(oPC, "RSa_Butler");
string sServantCommand = GetLocalString(oPC, "RSA_ServantCommand");
string sServantRespond = GetLocalString(oPC, "RSA_ServantRespond");

object oArea = GetObjectByTag(sRoomArea);
vector vTrigger = Vector(fX, fY, 0.0);
location lTrigger = Location(oArea, vTrigger, 0.0);
object oTrigger = GetNearestObjectToLocation(OBJECT_TYPE_TRIGGER, lTrigger);
object oInnKeeper = GetObjectByTag(sInnKeeper);
object oDoor = GetNearestObjectToLocation(OBJECT_TYPE_DOOR, lTrigger);
object oButler = GetObjectByTag(sButler);
object oServant = GetObjectByTag(sServant);
object oWayPoint = GetObjectByTag("POST_"+sServant);

SetLocalInt(oTrigger, "RSA_NGuests", 0);
SetLocalInt(oTrigger, "RSA_Guests", 0);
SetLocalInt(oInnKeeper, sNRoom, 0);
SetLocalInt(oButler, "RSA_Guests", 0);

AssignCommand(oInnKeeper, ActionSpeakString(sServantCommand));
AssignCommand(oServant, ClearAllActions());
AssignCommand(oServant, ActionSpeakString(sServantRespond));
AssignCommand(oServant, ActionCloseDoor(oDoor));
SetLocked(oDoor, TRUE);
AssignCommand(oServant, ActionMoveToObject(oWayPoint, FALSE));
AssignCommand(oServant, ActionDoCommand(SetFacing(GetFacing(oWayPoint))));
}

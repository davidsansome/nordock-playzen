//::///////////////////////////////////////////////
//:: Reports to DM which rooms are full
//:: pri_roomsfull
//:: Copyright (c) 2002 Shepherd Software Inc.
//:://////////////////////////////////////////////
/*

Script is called from DM InnKeeper Options. The Local
Variables of the InnKeeper are scanned to determine which
rooms are full. If the room is full, that room is added to
a string. After all the rooms have been checked the string
is sent to the DM in a private message. Rooms can than be
reset as needed.

*/
//:://////////////////////////////////////////////
//:: Created By: Russell S. Ahlstrom
//:: Created On: July 20, 2002
//:://////////////////////////////////////////////

#include "pri_inc"
#include "pri_text"

void main()
{
object oPC = GetPCSpeaker();

int iWhatRoom = 1;

string sRoomsFull = "";

GetInnArea(oPC);

int iNumberPoor = GetLocalInt(oPC, "RSA_NumberPoor");
int iNumberNorm = GetLocalInt(oPC, "RSA_NumberNorm");

string sInnKeeper = GetLocalString(oPC, "RSA_InnKeeper");

object oInnKeeper = GetObjectByTag(sInnKeeper);

int iSuite = GetLocalInt(oInnKeeper, "RSA_FullSuite");
int iNormal = GetLocalInt(oInnKeeper, "RSA_Normal_1");
int iPoor = GetLocalInt(oInnKeeper, "RSA_Poor_1");

if (iSuite > 0) sRoomsFull = "Suite Full";

while (iWhatRoom <= iNumberNorm)
{
 if (iNormal == 1) sRoomsFull = sRoomsFull + " Regular Room "+IntToString(iWhatRoom)+" Full";
 iWhatRoom++;
 iNormal = GetLocalInt(oInnKeeper, "RSA_Normal_"+IntToString(iWhatRoom));
}

iWhatRoom = 1;

while (iWhatRoom <= iNumberPoor)
{
 if (iPoor == 1) sRoomsFull = sRoomsFull + " Cheap Room "+IntToString(iWhatRoom)+" Full";
 iWhatRoom++;
 iPoor = GetLocalInt(oInnKeeper, "RSA_Poor_"+IntToString(iWhatRoom));
}

if (sRoomsFull == "") sRoomsFull = ALLEMPTY;

SendMessageToPC(oPC, sRoomsFull);
}

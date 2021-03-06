//::///////////////////////////////////////////////
//:: Sells a Normal Room to player and flags as full
//:: pri_normalroom.nss
//:: Copyright (c) 2002 Shepherd Software Inc.
//:://////////////////////////////////////////////
/*

This script is called by the player from the InnKeeper
Conversation. The InnKeeper scans through his Local Variables
to find out what rooms can be rented out and which rooms
are already rented out.

The Innkeeper then sells the first unrented room to the player
if they have enough money. The correct key is created and given
to the player and the room is marked as full.

The player is also marked with having already bought a room and
can not buy another room until he uses the first one.

*/
//:://////////////////////////////////////////////
//:: Created By: Russell S. Ahlstrom
//:: Created On: July 20, 2002
//:://////////////////////////////////////////////

#include "pri_inc"

void main()
{
object oPC = GetPCSpeaker();

int iWhatRoom = 1;

string sWhereRoom = "Error in _rsa_normalroom script!";
string sKey = "";

GetInnArea(oPC);

int iGold = GetGold(oPC);
int iPrice = GetLocalInt(oPC, "RSA_PriceNorm");
int iNumberRooms = GetLocalInt(oPC, "RSA_NumberNorm");

string sInnKeeper = GetLocalString(oPC, "RSA_InnKeeper");
string sNoMoreNorm = GetLocalString(oPC, "RSA_NoMoreNorm");
string sHaveRoom = GetLocalString(oPC, "RSA_HaveRoom");
string sNotEnoughGold = GetLocalString(oPC, "RSA_NotEnoughGoldN");

object oInnKeeper = GetObjectByTag(sInnKeeper);

int iFull = GetLocalInt(oInnKeeper, "RSA_Normal_1");
int iHasRoom = GetLocalInt(oPC, "RSA_HasRoom");

if (iHasRoom == 1)
 {
  ActionSpeakString(sHaveRoom);
  return;
 }

while (iWhatRoom <= iNumberRooms)
{
 if (iFull == 0)
 {
  iFull = 1;
  sWhereRoom = GetLocalString(oPC, "RSA_WhereNorm"+IntToString(iWhatRoom));
  sKey = GetLocalString(oPC, "RSA_KeyNorm"+IntToString(iWhatRoom));
  break;
 }
 iWhatRoom++;
 iFull = GetLocalInt(oInnKeeper, "RSA_Normal_"+IntToString(iWhatRoom));
}

if (iFull == 0)
 {
 ActionSpeakString(sNoMoreNorm);
 return;
 }

if (iGold - iPrice >= 0)
 {
  TakeGoldFromCreature(iPrice, oPC, TRUE);
  CreateItemOnObject(sKey, oPC, 1);
  ActionSpeakString(sWhereRoom);
  SetLocalInt(oInnKeeper, "RSA_Normal_"+IntToString(iWhatRoom), 1);
  SetLocalInt(oPC, "RSA_HasRoom", 1);
 }
else
 {
  ActionSpeakString(sNotEnoughGold);
 }
}

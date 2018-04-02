//::///////////////////////////////////////////////
//:: Asking if the Player Wishes to Rest
//:: pri_bedyesno.nns
//:: Copyright (c) 2002 Shepherd Software Inc.
//:://////////////////////////////////////////////
/*

This script should be attached to any bed that you
wish to allow the player to sleep on. Make the bed
usable and then place this script on the event "OnUsed."

A conversation is started with the player that asks them
if they wish to rest.

*/
//:://////////////////////////////////////////////
//:: Created By: Russell S. Ahlstrom
//:: Created On: June 26, 2002
//:://////////////////////////////////////////////

#include "pri_text"

void main()
{
object oBed = OBJECT_SELF;
string sName = GetTag(oBed);
if (sName == "KingSizeBed")
 {
  object oPC = GetClickingObject();
  int iRenter = GetLocalInt(oPC, "RSA_BoughtSuite");
  if (iRenter > 0)
  {
   ActionStartConversation(oPC, "pri_bed", TRUE);
  }
  else
  {
   FloatingTextStringOnCreature(MASTERBED, oPC, FALSE);
   return;
  }
 }
else if (sName == "suitebed")
 {
  object oPC = GetLastUsedBy();
  int iRenter = GetLocalInt(oPC, "RSA_BoughtSuite");
  if (iRenter == 0)
  {
   ActionStartConversation(oPC, "pri_bed", TRUE);
  }
  else
  {
   FloatingTextStringOnCreature(GUESTBED, oPC, FALSE);
   return;
  }
 }
else
 {
  ActionStartConversation(GetLastUsedBy(), "pri_bed", TRUE);
 }
}

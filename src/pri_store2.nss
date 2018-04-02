//::///////////////////////////////////////////////
//:: Drink Vendor for any Barmaid
//:: pri_store2
//:: Copyright (c) 2002 Shepherd Software Inc.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Russell S. Ahlstrom
//:: Created On: July 11, 2002
//:://////////////////////////////////////////////

#include "pri_inc"

void main()
{

object oPC = GetPCSpeaker();

GetInnArea(oPC);

string sStore = GetLocalString(oPC, "RSA_DrinkStore");
string sBarmaid = GetLocalString(oPC, "RSA_Barmaid");

object oStore = GetNearestObjectByTag(sStore);
object oBarmaid = GetObjectByTag(sBarmaid);

if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
 OpenStore(oStore, GetPCSpeaker());
else
 ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
}

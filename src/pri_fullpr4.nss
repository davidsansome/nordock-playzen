//::///////////////////////////////////////////////
//:: Sets Poor Room 4 to Full
//:: pri_fullpr4
//:: Copyright (c) 2002 Shepherd Software Inc.
//:://////////////////////////////////////////////
/*

DM Option to flag room as full so player can not rent
out that room. Useful if you want to have NPC's stay
in a room or not what them to use the Suite, etc.

*/
//:://////////////////////////////////////////////
//:: Created By: Russell S. Ahlstrom
//:: Created On: July 11, 2002
//:://////////////////////////////////////////////

#include "pri_text"

void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(OBJECT_SELF, "RSA_Poor_4", 1);
    SendMessageToPC(oPC, FULLP4);
}

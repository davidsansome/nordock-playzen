//::///////////////////////////////////////////////
//:: Reset Normal Room 2
//:: pri_renorm2
//:: Copyright (c) 2002 Shepherd Software Inc.
//:://////////////////////////////////////////////
/*

DM Option to reset the room so that it may be rented
out again by players. See "_rsa_dmreset" for more
information.

*/
//:://////////////////////////////////////////////
//:: Created By: Russell S. Ahlstrom
//:: Created On: July 11, 2002
//:://////////////////////////////////////////////

#include "pri_reset_inc"

void main()
{
ResetRoom("RSA_Normal_2", 27.0, 35.0);
}

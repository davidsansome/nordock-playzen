//::///////////////////////////////////////////////
//:: Reset Poor Room 1
//:: pri_repoor1
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
ResetRoom("RSA_Poor_1", 44.0, 8.0);
}

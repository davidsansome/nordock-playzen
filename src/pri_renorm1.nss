//::///////////////////////////////////////////////
//:: Reset Normal Room 1
//:: pri_renorm1
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
ResetRoom("RSA_Normal_1", 27.0, 24.0);
}

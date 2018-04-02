//::///////////////////////////////////////////////
//:: Checks to see if Speaker is the DM
//:: pri_con_isdm
//:: Copyright (c) 2002 Shepherd Software Inc.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Russell S. Ahlstrom
//:: Created On: July 1, 2002
//:://////////////////////////////////////////////

int StartingConditional()
{

    if(!(GetIsDM(GetPCSpeaker())))
        return FALSE;

    return TRUE;
}

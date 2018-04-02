//::///////////////////////////////////////////////
//:: General Treasure Spawn Script   Medium
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Spawns in general purpose treasure, usable
    by all classes.
*/
//:://////////////////////////////////////////////
//:: Created By:   Brent
//:: Created On:   February 26 2001
//:://////////////////////////////////////////////
//#include "NW_O2_CONINCLUDE"
#include "RR_TREASURE"

void main()

{
    if (GetLocalInt(OBJECT_SELF,"NW_DO_ONCE") != 0)
    {
       return;
    }
    object oLastOpener = GetLastOpener();


//    GenerateMediumTreasure(oLastOpener, OBJECT_SELF);
    CT_rr_master_lewt_med(oLastOpener, OBJECT_SELF);
    SetLocalInt(OBJECT_SELF,"NW_DO_ONCE",1);

    ShoutDisturbed();
}

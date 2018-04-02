//::///////////////////////////////////////////////
//:: General Treasure Spawn Script     BOOK
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
#include "NW_O2_CONINCLUDE"

void main()

{
    if (GetLocalInt(OBJECT_SELF,"NW_DO_ONCE") != 0)
    {
       return;
    }
    object oLastOpener = GetLastOpener();
    int iScrolls = 5 + d4();
    int i;
    for(i=0 ; i<iScrolls ; i++)
    {
        CreateArcaneScroll(OBJECT_SELF, oLastOpener, 4);
    }
    SetLocalInt(OBJECT_SELF,"NW_DO_ONCE",1);
    ShoutDisturbed();
}



//------------------------------------------------------------------------------
//
// nky_lod_onspawn
//
// Determines the course of action to be taken after having just been spawned in
// Altered to suit LoD
//
//------------------------------------------------------------------------------
//
// Created By: Preston Watamaniuk
// Created On: 25-10-2001
//
// Altered By: Michael Tuffin [Grug]
// Altered On: 02-01-2004
//
//------------------------------------------------------------------------------
//
// Known bugs/issues...
// - None
//
//------------------------------------------------------------------------------
//
// Changelog...
// Version: 002 (24-May-2004)
// - Noticed that the OneInTenChance function could be replaced with a die roll
//   in the if statement instead
// Version: 001 (24-May-2004)
// - Altered to include Nakey's function OneInTenChance and a lines to spawn a
//   whip
// Version: 000 (everything before 24-May-2004)
// - Stolen from generic NW_C2_DEFAULT9
//
//------------------------------------------------------------------------------

#include "NW_I0_GENERIC"

//------------------------------------------------------------------------------

void main()
  {
  SetListeningPatterns();
  WalkWayPoints();
  if (!((GetClassByPosition(1,OBJECT_SELF)==CLASS_TYPE_ANIMAL)||(GetClassByPosition(1,OBJECT_SELF)==CLASS_TYPE_VERMIN)))
    {
    SetLocalInt(OBJECT_SELF, "noloot", TRUE);
    }
    // Changes by Nakey 20-02-04
    // Makes LoD drop a whip when he dies
    if (d10() == 1)
    {
        CreateItemOnObject("lashofdispair", OBJECT_SELF);
    }
  }

//------------------------------------------------------------------------------

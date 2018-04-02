//------------------------------------------------------------------------------
//
// onexit_exec
//
// Manages area cleanup when all PCs have left the area  and it has been empty
// of them for a certain period of time. Cleans up all encounter creatures.
// Should not be run directly, use 'onexit' instead.
// Objects with a tag containing '_KEEP' will be preserved as set by Death in
// the previous cleanup script.
// Designed to be used as a set of three scripts ('onexit', 'onexit_exec' &
// 'onexit_inc').
//
//------------------------------------------------------------------------------
//
// Created By: Michael Tuffin [Grug]
// Created On: 19-12-2003
//
// Altered By: Michael Tuffin [Grug]
// Altered On: 19-12-2003
//
//------------------------------------------------------------------------------
//
// Known bugs/issues...
// - None
//
//------------------------------------------------------------------------------
//
// Changelog...
// Version: 000
// - None
//
//------------------------------------------------------------------------------

#include "onexit_inc"

//------------------------------------------------------------------------------

void main()
{
    if (AreaEmptyOfPlayers())
    {
        DestroyEncounters();
    }
}

//------------------------------------------------------------------------------

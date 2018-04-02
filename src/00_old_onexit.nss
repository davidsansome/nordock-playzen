//------------------------------------------------------------------------------
//
// onexit
//
// Manages area cleanup when all PCs have left the area  and it has been empty
// of them for a certain period of time. Cleans up all encounter creatures.
// Should be set as the script to run when an area's OnExit event is triggered.
// Objects with a tag containing '_KEEP'
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
// - All processing is done in one hit, staggered destruction would be less
//   laggy
//
//------------------------------------------------------------------------------
//
// Changelog...
// Version: 000
// - Added inventory destruction to prevent code duplication
// - Split into three scripts ('onexit', 'onexit_exec' and 'onexit_inc')
//
//------------------------------------------------------------------------------

#include "onexit_inc"

//------------------------------------------------------------------------------

void main()
{
    object oFirstObjectInArea = GetFirstObjectInArea();
    int iCurrentObjectValid;

    // Ensure there is at least one object in the area before continuing
    if (GetIsObjectValid(oFirstObjectInArea))
    {
        if (AreaEmptyOfPlayers())
        {
            // 'onexit_exec' does the actual cleanup after confirming that the
            // area is still empty after CLEANUP_DELAY seconds. This second
            // script exists as a workaround to delay the cleanup.
            DelayCommand(GA_CLEANUP_DELAY, ExecuteScript("onexit_exec", GetArea(oFirstObjectInArea)));
        }
    }
}

//------------------------------------------------------------------------------

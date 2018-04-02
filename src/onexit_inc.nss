//------------------------------------------------------------------------------
//
// onexit_inc
//
// Manages area cleanup when all PCs have left the area  and it has been empty
// of them for a certain period of time. Cleans up all encounter creatures.
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
// Version: 001
// - Set GA_CLEANUP_DELAY as a constant for the time delay between PC checks
//   rather than use a hardcoded value
// Version: 000
// - Added function to destroy encounter creatures 'DestroyEncounters()'
// - Added function to check for PCs in an area 'AreaEmptyOfPlayers()'
// - Added function to destroy the inventories of creatures because the slots at
//   least are not destroyed when the creature is, causing a memory leak
//
//------------------------------------------------------------------------------

const float GA_CLEANUP_DELAY = 600.0;

//------------------------------------------------------------------------------

// Tests to see if current area is empty of players. Returns TRUE if has no PCs
int AreaEmptyOfPlayers();
// Destroys spawned encounters in current area
void DestroyEncounters();
// Destroys the inventory of oCreature where oCreature is an encounter creature
void DestroyCreatureInventory(object oCreature);

//------------------------------------------------------------------------------

int AreaEmptyOfPlayers()
{
    object oCurrentObject = GetFirstObjectInArea();
    int iCurrentObjectValid;
    int iAreaEmptyOfPCs = TRUE;
    int iResult;

    if (GetIsObjectValid(oCurrentObject))
    {
        iCurrentObjectValid = TRUE;
    }
    else
    {
        iCurrentObjectValid = FALSE;
    }
    while (iCurrentObjectValid && iAreaEmptyOfPCs)
    {
        if (GetIsObjectValid(oCurrentObject))
        {
            if (GetIsPC(oCurrentObject))
            {
                iAreaEmptyOfPCs = FALSE;
            }
            else
            {
                oCurrentObject = GetNextObjectInArea();
            }
        }
        else
        {
            iCurrentObjectValid = FALSE;
        }
    }

    if (iAreaEmptyOfPCs)
    {
        iResult = TRUE;
    }
    else
    {
        iResult = FALSE;
    }

    return iResult;
}

//------------------------------------------------------------------------------

void DestroyEncounters()
{
    object oCurrentObject = GetFirstObjectInArea();
    int iCurrentObjectValid;

    if (GetIsObjectValid(oCurrentObject))
    {
        iCurrentObjectValid = TRUE;
    }
    else
    {
        iCurrentObjectValid = FALSE;
    }
    while (GetIsObjectValid(oCurrentObject))
    {
        if (GetIsEncounterCreature(oCurrentObject) && (FindSubString(GetTag(oCurrentObject), "_KEEP") < 0))
        {
            DestroyCreatureInventory(oCurrentObject);
            AssignCommand(oCurrentObject, SetIsDestroyable(TRUE, FALSE, FALSE));
            DestroyObject(oCurrentObject);
        }
        oCurrentObject = GetNextObjectInArea();
    }
}

//------------------------------------------------------------------------------

void DestroyCreatureInventory(object oCreature)
{
    if (GetIsObjectValid(oCreature) && GetIsEncounterCreature(oCreature))
    {
        int iSlot;
        object oItem;
        for(iSlot = 0; iSlot <= 17; iSlot++)
        {
            oItem=GetItemInSlot(iSlot, oCreature);
            AssignCommand(oItem, SetIsDestroyable(TRUE, FALSE, FALSE));
            DestroyObject(oItem);
        }

        // Storage inventory is normally cleared automatically, but it will be
        // done anyway because im paranoid.
        oItem=GetFirstItemInInventory(oCreature);
        while (GetIsObjectValid(oItem))
        {
            DestroyObject(oItem);
            AssignCommand(oItem, SetIsDestroyable(TRUE, FALSE, FALSE));
            oItem = GetNextItemInInventory(oCreature);
        }
    }
}

//------------------------------------------------------------------------------

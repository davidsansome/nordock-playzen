//
//  NWSubraceDrop
//
//  Script for when a character drops a subrace item.
//  Place in the OnUnAcquireItem module event.
//
//  (c) Shir'le E. Illios, 2002 (shirle@drowwanderer.com)
//
////////////////////////////////////////////////////////

#include "subraces"


void main()
{

    // Get te item that was lost.
    object oItem = GetModuleItemLost();

    // Get the character who lost the item.
    object oChar = GetModuleItemLostBy();

    // SEI_Note: There seems to be a bug in GetModuleItemLostBy(), which
    //           returns the lost object, not the lost character holding the
    //           object. But strangely enough GetEnteringObject does return the
    //           character. Done like this for backwards compatibility if
    //           BioWare ever fixes the bug.
    if( oChar == oItem )
    {
        oChar = GetEnteringObject();
    }

    // Check if the item being dropped is a spell-like abilities item.
    if( ! SEI_DropSubraceItem( oItem ) )
    {

        // SEI_NOTE: Here one could test for other items.

    }

} // End main


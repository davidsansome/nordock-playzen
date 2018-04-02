//
//  NWOnPCRested
//
//  When a PC finishes resting give them back the subrace items
//  (if they've lost it).
//
//  (c) Shir'le E. Illios, 2002 (shirle@drowwanderer.com)
//
////////////////////////////////////////////////////////

#include "subraces"


void main()
{

    object oPC = GetLastPCRested();

    switch( GetLastRestEventType() )
    {

        case REST_EVENTTYPE_REST_FINISHED:
        {
            SEI_KeepSubraceItem( oPC );
        }
        break;

        case REST_EVENTTYPE_REST_STARTED:
        case REST_EVENTTYPE_REST_CANCELLED:
        case REST_EVENTTYPE_REST_INVALID:
        default:
        break;

    } // End switch-case

} // End main


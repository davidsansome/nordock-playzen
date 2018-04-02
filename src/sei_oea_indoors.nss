//
//  NWOnEnterAreaIndoors
//
//  OnEnter script for indoors areas.
//
//  (c) Shir'le E. Illios, 2002 (shirle@drowwanderer.com)
//
////////////////////////////////////////////////////////

#include "subraces"

void main()
{
    Subraces_OnEnterArea( GetEnteringObject(), AREA_DARK + SUBRACE_AREA_ABOVEGROUND );
}


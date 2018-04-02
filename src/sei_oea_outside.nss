//
//  NWOnEnterAreaOutside
//
//  OnEnter script for areas outside.
//
//  (c) Shir'le E. Illios, 2002 (shirle@drowwanderer.com)
//
////////////////////////////////////////////////////////

#include "subraces"

void main()
{
    Subraces_OnEnterArea( GetEnteringObject(), AREA_SUN + SUBRACE_AREA_ABOVEGROUND );
}


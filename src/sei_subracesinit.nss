//
//  NWSubracesInit
//
//  Initializes the subraces script.
//  To be placed in the OnModuleLoad event of the module.
//
//  (c) Shir'le E. Illios, 2002 (shirle@drowwanderer.com)
//
////////////////////////////////////////////////////////

#include "subraces"


void main()
{
    Subraces_InitSubraces();
    Subraces_SetDefaultAreaSettings( AREA_DARK + SUBRACE_AREA_UNDERGROUND );
}


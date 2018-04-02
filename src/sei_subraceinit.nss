//
//  NWSubraceInit
//
//  Subrace initialization script.
//  To be placed in the OnClientEnter event of the module.
//
//  (c) Shir'le E. Illios, 2002 (shirle@drowwanderer.com)
//
////////////////////////////////////////////////////////

#include "subraces"

void main()
{
    Subraces_InitSubrace( GetEnteringObject() );
}

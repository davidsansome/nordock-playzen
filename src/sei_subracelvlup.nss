//
//  NWSubraceLevelUp
//
//  Subrace level up script.
//  To be placed in the OnPlayerLevelUp event of the module.
//
//  (c) Shir'le E. Illios, 2002 (shirle@drowwanderer.com)
//
////////////////////////////////////////////////////////

#include "subraces"

void main()
{
    Subraces_LevelUpSubrace( GetPCLevellingUp() );
}

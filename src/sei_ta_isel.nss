//
//  NWIsElf
//
//  Check if the conversing object is an elf.
//
//  (c) Shir'le E. Illios, 2002 (shirle@drowwanderer.com)
//
////////////////////////////////////////////////////////

int StartingConditional()
{
    return ( GetRacialType( OBJECT_SELF ) == RACIAL_TYPE_ELF );
}


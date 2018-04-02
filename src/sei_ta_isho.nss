//
//  NWIsHalforc
//
//  Check if the conversing object is a half-orc.
//
//  (c) Shir'le E. Illios, 2002 (shirle@drowwanderer.com)
//
////////////////////////////////////////////////////////

int StartingConditional()
{
    return ( GetRacialType( OBJECT_SELF ) == RACIAL_TYPE_HALFORC );
}


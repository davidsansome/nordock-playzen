void main()

{

    object oPC = GetLastUsedBy();

    object oTarget = GetWaypointByTag( "WP_lalaith1a");  //tag of destination waypoint or object

    AssignCommand( oPC, JumpToObject( oTarget));

}

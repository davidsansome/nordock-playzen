void main()
{
    object oTarget = GetNearestObjectByTag("WP_SewerExit");
    AssignCommand(GetLastUsedBy(), ActionJumpToLocation(GetLocation(oTarget)));
}

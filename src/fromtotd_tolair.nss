void main()
{
    object oUser = GetLastUsedBy();
    location lWP = GetLocation(GetObjectByTag("WP_TOTD_PASS"));
    AssignCommand(oUser, ActionJumpToLocation(lWP));
}

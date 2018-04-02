void main()
{
    object oPC = GetLastUsedBy();
    object oWP = GetObjectByTag("WP_TYLNTREASURE");

    AssignCommand(oPC, ActionJumpToObject(oWP));
}

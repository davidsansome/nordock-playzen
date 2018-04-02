void main()
{
    object oPC = GetLastUsedBy();
    object oWP = GetObjectByTag("POST_F104_TCG");

    AssignCommand(oPC, ActionJumpToObject(oWP));
}

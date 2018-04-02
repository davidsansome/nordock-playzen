void main()
{
    object oPC=GetLastUsedBy();
    AssignCommand(oPC, JumpToLocation(GetLocation(GetObjectByTag ("chaos_in"))));
}

void main()
{
//    CreateItemOnObject("stoneofreturn", GetLastUsedBy(), 1);
    AssignCommand(GetLastUsedBy(), JumpToLocation(GetLocation(GetObjectByTag ("port_mulrock"))));
}

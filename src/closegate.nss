void main()
{
    object oDoor = GetNearestObjectByTag("MBMain");
    SetLocked(oDoor,TRUE);
    AssignCommand(oDoor,ActionCloseDoor(oDoor));
}

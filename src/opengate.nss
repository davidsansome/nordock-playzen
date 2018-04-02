void main()
{
    object oDoor = GetNearestObjectByTag("MBMain");
    SetLocked(oDoor,FALSE);
    AssignCommand(oDoor,ActionOpenDoor(oDoor));

    /*oDoor = GetNearestObjectByTag("MBMain");
    SetLocked(oDoor,TRUE);
    AssignCommand(oDoor,ActionCloseDoor(oDoor));*/
}

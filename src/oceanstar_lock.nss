void main()
{
    object oDoor = GetObjectByTag("OceanStarTreasureDoor");
    ActionCloseDoor(oDoor);
    SetLocked(oDoor, TRUE);
}

void main()
{
    object oDoor = GetObjectByTag("FancyDoorJulianna05");
    DelayCommand(30.0, ActionCloseDoor(oDoor));
}

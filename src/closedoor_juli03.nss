void main()
{
    object oDoor = GetObjectByTag("FancyDoorJulianna03");
    DelayCommand(30.0, ActionCloseDoor(oDoor));
}

void main()
{
    object oDoor = GetObjectByTag("FancyDoorJulianna02");
    DelayCommand(30.0, ActionCloseDoor(oDoor));
}

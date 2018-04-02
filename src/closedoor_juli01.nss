void main()
{
    object oDoor = GetObjectByTag("FancyDoorJulianna01");
    DelayCommand(30.0, ActionCloseDoor(oDoor));
}

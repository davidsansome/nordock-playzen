void main()
{
    object oDoor = GetObjectByTag("FancyDoorJulianna06");
    DelayCommand(30.0, ActionCloseDoor(oDoor));
}

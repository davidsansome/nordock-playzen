void main()
{
    object oDoor = GetObjectByTag("FancyDoorJulianna08");
    DelayCommand(30.0, ActionCloseDoor(oDoor));
}

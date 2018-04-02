void main()
{
    object oDoor = GetObjectByTag("FancyDoorJulianna07");
    DelayCommand(30.0, ActionCloseDoor(oDoor));
}

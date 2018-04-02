void main()
{
    object oDoor = GetObjectByTag("FancyDoorJulianna04");
    DelayCommand(30.0, ActionCloseDoor(oDoor));
}

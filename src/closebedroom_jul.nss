void main()
{
    object oDoor = GetObjectByTag("BedroomJulianna");
    DelayCommand(10.0, ActionCloseDoor(oDoor));
}

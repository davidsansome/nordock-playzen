void main()
{
    DelayCommand(300.0, ActionCloseDoor(OBJECT_SELF));
    SetLocked(OBJECT_SELF, TRUE);

}

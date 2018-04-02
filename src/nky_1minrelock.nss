void main()
{
    DelayCommand(60.0, ActionCloseDoor(OBJECT_SELF));
    DelayCommand(61.0, SetLocked(OBJECT_SELF, 1));
}

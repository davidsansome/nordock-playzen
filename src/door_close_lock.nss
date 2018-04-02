void main()
{
  DelayCommand(30.0, ActionCloseDoor(OBJECT_SELF));
  DelayCommand(31.0, SetLocked(OBJECT_SELF, 1));
}

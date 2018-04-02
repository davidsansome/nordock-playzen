void main()
{
  DelayCommand(1800.0, ActionCloseDoor(OBJECT_SELF));
  SetLocked(OBJECT_SELF, 1);
}

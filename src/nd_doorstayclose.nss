void main()
{
  DelayCommand(5.0, ActionCloseDoor(OBJECT_SELF));
  SetLocked(OBJECT_SELF, 1);
}

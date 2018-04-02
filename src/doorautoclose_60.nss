void main()
{
DelayCommand(60.0, ActionCloseDoor(OBJECT_SELF));
DelayCommand(90.0, ActionLockObject(OBJECT_SELF));
}

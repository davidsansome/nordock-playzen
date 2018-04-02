void main()
{
if (GetIsOpen(OBJECT_SELF))
    {
        DelayCommand(15.0, ActionCloseDoor(OBJECT_SELF));
    }
}

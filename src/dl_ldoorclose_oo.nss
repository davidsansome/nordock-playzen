void main()
{
if (GetLocalInt(OBJECT_SELF, "doorstatus") == 1)
    {
        ActionOpenDoor(OBJECT_SELF);
    }
else
    {
        ActionCloseDoor(OBJECT_SELF);
        ActionStartConversation( GetLastUsedBy(), "dl_lilroom", TRUE );
    }
}

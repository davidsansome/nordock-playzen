

// I hate the world being untidy.  So I created this little script to shut the door behind you after 3 minutes.
// It also relocks relockable doors.  I am trying to make a adventure that 'resets' for new adventure's so this
// is one of the first steps.
//
// Place in the Heartbeat of the door
//Rutree@hotmail.com

void main()
{
    //Is the door open? then close it in 3 minutes
    if(GetIsOpen(OBJECT_SELF))
    {
        ActionWait(60.0);//wait 1 mins
        ActionCloseDoor (OBJECT_SELF);// close door
    }
    //Lock the door if it can be relocked!
    if(GetLockLockable(OBJECT_SELF) && !GetLocked(OBJECT_SELF) && !GetIsOpen(OBJECT_SELF))
    {
        ActionLockObject(OBJECT_SELF);// lock door
    }
}



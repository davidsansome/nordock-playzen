/////////////////////////////////////////////////////////////
//Unlock and open multiple doors, then close and lock them
//with the added delight of locking and unlocking a MainDoor
/////////////////////////////////////////////////////////////

/*
This goes in the OnUsed and OnDeath events on the door. It will check
the state of multiple doors with the same tag. If you don't
want to modify this script you must make sure the tag of all
the doors is set to Door1. This script will also check the
state of one MainDoor - tag must be set to MainDoor. While
the doors with the Door1 tag are open, it will lock the main
door. A second use of the lever will close all doors with the
tag Door1, lock them, and lastly will unlock the MainDoor.
*/
void main()
{
  //This part switches the animation from activated to deactivated
  //or vice versa
  object oDoor ;
  int nDoorLocked;
  int nDoorOpen;
  int count = 0;
  string sDoorTag;
    oDoor = GetObjectByTag ("Door1", count);
    if ( GetLocalInt ( OBJECT_SELF, "m_bActivated" )==TRUE)
   {
    SetLocalInt (OBJECT_SELF,"m_bActivated",FALSE);
    ActionPlayAnimation ( ANIMATION_PLACEABLE_ACTIVATE);
   }
    else if ( GetLocalInt (OBJECT_SELF,"m_bActivated") ==FALSE)
   {
    SetLocalInt (OBJECT_SELF,"m_bActivated",TRUE);
    ActionPlayAnimation (ANIMATION_PLACEABLE_DEACTIVATE);
   }
    while (oDoor != OBJECT_INVALID)
    if ( GetIsObjectValid (oDoor) == TRUE )
   {
    sDoorTag = GetTag (oDoor);
    nDoorLocked = GetLocked (oDoor);
    nDoorOpen = GetIsOpen (oDoor);
    //The following part checks the state of the doors. Initial
    //state should be closed and locked. If it is, it will unlock
    //the doors with the tag Door1 and open them.
    if ( nDoorLocked && nDoorOpen==FALSE)
   {
    SetLocked ( oDoor,FALSE );
    ActionOpenDoor ( oDoor );
   }
    else if ( nDoorOpen && nDoorLocked==FALSE)
   {
    ActionCloseDoor (oDoor);
    SetLocked (oDoor,TRUE);
   }
    else if ( nDoorOpen==FALSE && nDoorLocked==FALSE)
   {
    ActionOpenDoor (oDoor);
   }
    count++;
    oDoor = GetObjectByTag ("Door1", count);
 }
  //The next part is where it looks at the door with the tag
  //MainDoor and locks it while the doors are open. It will
  //unlock it when the other doors are shut again.
  object oDoorMain;
  int nDoorLockedMain;
  int nDoorOpenMain;
  string sDoorTagMain;
    oDoorMain = GetObjectByTag ("MainDoor", 0);
    if ( GetIsObjectValid (oDoorMain) == TRUE )
    {
    sDoorTagMain = GetTag (oDoorMain);
    nDoorLockedMain = GetLocked (oDoorMain);
    nDoorOpenMain = GetIsOpen (oDoorMain);
    if ( nDoorLockedMain==FALSE && nDoorOpenMain==FALSE)
   {
    SetLocked ( oDoorMain,TRUE );
   }
    else if ( nDoorLockedMain==TRUE && nDoorOpenMain==FALSE)
   {
    SetLocked (oDoorMain,FALSE);
   }
 }
}


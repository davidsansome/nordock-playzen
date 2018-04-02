void main()
{
  object oDoor = GetObjectByTag ("CryptExit2");
  if ( GetLocalInt( OBJECT_SELF, "m_bActivated" ) == TRUE )
  {
    SetLocalInt( OBJECT_SELF, "m_bActivated", FALSE );
    PlayAnimation( ANIMATION_PLACEABLE_DEACTIVATE );
    SetLocked(oDoor, FALSE);
    ActionOpenDoor(oDoor);
  }
  else
  {
    SetLocalInt( OBJECT_SELF, "m_bActivated", TRUE );
    PlayAnimation( ANIMATION_PLACEABLE_ACTIVATE );
    ActionCloseDoor(oDoor);
    SetLocked(oDoor, TRUE);
  }
}

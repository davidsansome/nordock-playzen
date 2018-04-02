void main()
{
object oDoor = GetObjectByTag ("CryptExit2");
if ( GetLocalInt( OBJECT_SELF, "m_bActivated" ) == FALSE )
{
ActionWait(10.0);
SetLocalInt( OBJECT_SELF, "m_bActivated", TRUE );
PlayAnimation( ANIMATION_PLACEABLE_ACTIVATE );
ActionCloseDoor(oDoor);
SetLocked(oDoor, TRUE);
}
}

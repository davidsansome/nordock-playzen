void main()
{
object oSirPat = GetObjectByTag("sirpatrick");

SetLocalInt(oSirPat, "doorstatus", 1);
//SetLocked(OBJECT_SELF, FALSE);
ActionOpenDoor(oSirPat);
DelayCommand(30.0, ActionCloseDoor(oSirPat));
}

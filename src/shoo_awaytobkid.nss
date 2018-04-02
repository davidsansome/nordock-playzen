void main ()
{
object oFocalPoint = GetObjectByTag("UNIQUE_OBJECT_TAG");
ActionSpeakString("My daddy went north to get rid of the bandits.");
SetFacingPoint(GetPosition(oFocalPoint));
}


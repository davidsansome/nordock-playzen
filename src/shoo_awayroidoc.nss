void main ()
{
object oFocalPoint = GetObjectByTag("UNIQUE_OBJECT_TAG");
ActionSpeakString("Please do be considerate, and move along.");
SetFacingPoint(GetPosition(oFocalPoint));
}


void main ()
{
object oFocalPoint = GetObjectByTag("UNIQUE_OBJECT_TAG");
ActionSpeakString("Leave me alone, I talking here.");
SetFacingPoint(GetPosition(oFocalPoint));
}


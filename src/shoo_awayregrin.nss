void main ()
{
object oFocalPoint = GetObjectByTag("UNIQUE_OBJECT_TAG");
ActionSpeakString("Can't you see, we just want to be alone.");
SetFacingPoint(GetPosition(oFocalPoint));
}


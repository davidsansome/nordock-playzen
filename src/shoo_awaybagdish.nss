void main ()
{
object oFocalPoint = GetObjectByTag("UNIQUE_OBJECT_TAG");
ActionSpeakString("Can'ya see I'm busy...I'm paid to move things, not talk.");
SetFacingPoint(GetPosition(oFocalPoint));
}


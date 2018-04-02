void main ()
{
object oFocalPoint = GetObjectByTag("MilmandirBenzface");
ActionSpeakString("What are you daft, we're talking here.");
SetFacingPoint(GetPosition(oFocalPoint));
}


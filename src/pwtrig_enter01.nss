void main()
{
  object riddledoor = GetObjectByTag("JeweledDoorJulianna");
  if (!GetIsOpen(riddledoor))
  {
     location loc = GetLocation(OBJECT_SELF);
     vector temp = GetPositionFromLocation(loc);
     vector zIndexCorrection = Vector(temp.x,temp.y,GetPositionFromLocation(GetLocation(riddledoor)).z);
     location correctedloc = Location(GetAreaFromLocation(loc),zIndexCorrection,90.0);

     object listener = CreateObject(OBJECT_TYPE_PLACEABLE,"pwlistener01",correctedloc); // remember blueprint not tag.

     SetListenPattern(listener,"gloria eternam",1000);
     SetListening(listener,TRUE);
     int seconds;
     for (seconds = 1; seconds < 7; seconds++)
        DelayCommand(IntToFloat(seconds),SignalEvent(listener,EventUserDefined(1300)));
  }
}


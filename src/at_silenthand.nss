void main()
{
  object oClicker = GetClickingObject();
  object oTarget = GetTransitionTarget(OBJECT_SELF);
  location lLoc = GetLocation(oTarget);

  if(GetItemPossessedBy(oClicker,"cotsh_door_NOD") != OBJECT_INVALID)
    {
    AssignCommand(oClicker,JumpToLocation(lLoc));
    }
    else
     {
     SpeakString("Powerfull magics guard this entrance, you may not pass.");
     }

}

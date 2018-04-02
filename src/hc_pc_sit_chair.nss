// hc_sit_chair
// Archaegeo 2002 June 29
// All code here thanks to Logxen
// This allows pc's or NPC's to sit in this chair
// Sitting chair script by Chaz Mead.
// Add this script to sittable object's OnUsed event.
void main()
{
  object oPlayer = GetLastUsedBy ();
  object oChair = OBJECT_SELF;
  object oSitter=GetSittingCreature(oChair);
  if (GetIsPC (oPlayer))
    {
        if (GetIsObjectValid(oChair) && !GetIsObjectValid
            (oSitter))
        {
            AssignCommand (oPlayer, ActionSit (oChair));
        }
    }
  else if(!GetIsObjectValid(oSitter))
  {
    AssignCommand(oPlayer, ActionSit(oChair));
  }
}


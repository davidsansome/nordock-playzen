// chair sitting script by Jhenne

void main()
{
// get the User
object oPC=GetLastSpeaker();
// get the closest chair, couch and/or throne
object oChair = GetNearestObjectByTag("Chair", OBJECT_SELF);
object oCouch = GetNearestObjectByTag("Couch", OBJECT_SELF);
object oThroneGood = GetNearestObjectByTag("ThroneGood", OBJECT_SELF);
object oStool=GetNearestObjectByTag("Stool", OBJECT_SELF);
// get the distance between the user and each object (-1.0 is the result if no
// object is found
float fDistanceChair = GetDistanceToObject(oChair);
float fDistanceGood = GetDistanceToObject(oThroneGood);
float fDistanceCouch = GetDistanceToObject(oCouch);
float fDistanceStool = GetDistanceToObject(oStool);

object oSit;

// if any of the objects are invalid (not there), change the return value
// to a high number so the distance math can work
if (fDistanceChair == -1.0)
{
  fDistanceChair =1000.0;
}

if (fDistanceGood == -1.0)
{
  fDistanceGood = 1000.0;
}

if (fDistanceCouch == -1.0)
{
  fDistanceCouch = 1000.0;
}
if (fDistanceStool == -1.0)
{
  fDistanceStool = 1000.0;
}


// find out which object is closest to the PC

if (fDistanceChair<fDistanceGood && fDistanceChair<fDistanceCouch && fDistanceChair<fDistanceStool)
{
  oSit=oChair;
}

if (fDistanceGood<fDistanceChair && fDistanceGood<fDistanceCouch && fDistanceGood<fDistanceStool)
{
  oSit=oThroneGood;
}

if (fDistanceCouch<fDistanceChair && fDistanceCouch<fDistanceGood && fDistanceCouch<fDistanceStool)
{
 oSit=oCouch;
}
if (fDistanceStool<fDistanceChair && fDistanceStool<fDistanceGood && fDistanceStool<fDistanceCouch)
{
 oSit=oStool;
}


// if no one is sitting in the object the PC is closest to, have him sit in it
if (GetIsObjectValid(GetSittingCreature(oSit)) == FALSE)
{
ActionSit(oSit);
}

}


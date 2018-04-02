// To spawn a creature at a waypoint each time a PC enters an area,
// set the following variables on the waypoint:
//   SpawnBP    (string)       The blueprint of the creature to spawn
//   SpawnTag   (string)       The tag to assign to the creature
//
// This method lets you create multiple creatures from a single blueprint
// with unique tags.  See Tyln Castle - Courtyard for an example.
//
// Added by Robin 17-Feb-05

void main()
{
    object oEntering = GetEnteringObject();

    // Only fire if it's a PC or a DM
    if (!GetIsPC(oEntering) && !GetIsDM(oEntering))
        return;

    object oArea = GetArea(oEntering);

    // Cycle through all the waypoints in the area
    object oObject = GetFirstObjectInArea();
    while (GetIsObjectValid(oObject))
    {
        if (GetObjectType(oObject) == OBJECT_TYPE_WAYPOINT)
        {
            string sBlueprint = GetLocalString(oObject, "SpawnBP");
            string sTag = GetLocalString(oObject, "SpawnTag");
            if ((sBlueprint != "") && (sTag != "") && (GetLocalInt(oObject, "RespawnDisabled") != 1))
            {
                object oExistingObject = GetLocalObject(oObject, "SpawnObject");
                if (!GetIsObjectValid(oExistingObject))
                {
                    location lLocation = GetLocation(oObject);
                    object oNewObject = CreateObject(OBJECT_TYPE_CREATURE, sBlueprint, lLocation, FALSE, sTag);
                    SetLocalInt(oNewObject, "WaypointSpawnedCreature", 1);
                    SetLocalObject(oNewObject, "CreatorWaypoint", oObject);
                    SetLocalObject(oObject, "SpawnObject", oNewObject);
                }
            }
        }
        oObject = GetNextObjectInArea();
    }
}

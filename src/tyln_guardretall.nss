#include "NW_I0_GENERIC"

void main()
{
    object oObject = GetFirstObjectInArea();
    while (GetIsObjectValid(oObject))
    {
        if (FindSubString(GetTag(oObject), "_TCG") != -1)
        {
            AssignCommand(oObject, ClearAllActions(TRUE));
            AssignCommand(oObject, WalkWayPoints());
        }
        oObject = GetNextObjectInArea();
    }
}

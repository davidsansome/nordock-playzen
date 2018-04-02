#include "NW_I0_GENERIC"

void main()
{
    object oTarget = GetLocalObject(GetPCSpeaker(), "TylnTarget");

    AssignCommand(oTarget, ClearAllActions(TRUE));
    AssignCommand(oTarget, WalkWayPoints());
}


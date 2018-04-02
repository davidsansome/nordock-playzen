//::///////////////////////////////////////////////
//:: nw_all_feedbackg
//:://////////////////////////////////////////////
/*
    Transports you to the party leader unless
    the party leader is in an area with the local
    int GA_NO_PORT set to 1-3 on it.
*/
//:://////////////////////////////////////////////
//:: Created By:   Nakey
//:: Created On:   18-02-04
//:://////////////////////////////////////////////

#include "0_ntfm_inc"

void main()
{
    object oLeader = GetFactionLeader(GetPCSpeaker());
    location lLeader = GetLocation(oLeader);
    object oArea = GetArea(oLeader);

    int nCase=GetLocalInt(oArea, "NCP_NO_PORT");
    if ((GetArea(oLeader)==OBJECT_INVALID) || (GetAllowTeleport(oArea)==FALSE)) nCase=1;

    switch (nCase)
    {
        case 0:
            AssignCommand(GetPCSpeaker(), JumpToObject(oLeader));
            break;
        case 1:
            FloatingTextStringOnCreature("Your party leader is in an area protected by strong magic that prevents you from teleporting at this time.", GetPCSpeaker());
            break;
        case 2:
            FloatingTextStringOnCreature("Your party leader is with a God that does not wish to be disturbed.", GetPCSpeaker());
            break;
        case 3:
            FloatingTextStringOnCreature("Your party leader has died, the portal cannot find a destination.", GetPCSpeaker());
            break;
    }
}

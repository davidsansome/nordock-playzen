#include "nw_i0_tool"
#include "rr_persist"

void main()
{
    if (GPI(GetEnteringObject(),"nMainQuest") == 1)
    {
        AssignCommand(GetEnteringObject(), JumpToLocation(GetLocation(GetObjectByTag ("misty_port_in"))));
        SendMessageToPC(GetEnteringObject(), "Hero, you may not enter this cave again.");
    }
}

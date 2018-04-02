#include "nw_i0_henchman"

void main()
{
if (GetIsObjectValid(GetHenchman(GetPCSpeaker())) == TRUE)
    {
    //Record master's old henchman...he shall now be mine
    object oHench = GetHenchman(GetPCSpeaker());
    RemoveHenchman(GetPCSpeaker(), GetHenchman(GetPCSpeaker()));
    AssignCommand(oHench, ClearAllActions());
    SetLocalObject(GetModule(),"000_NEW_MASTER",OBJECT_SELF);
    SignalEvent(oHench, EventUserDefined(1201));
    }
//Set me as new lieutenant
AddHenchman(GetPCSpeaker(),OBJECT_SELF);
}


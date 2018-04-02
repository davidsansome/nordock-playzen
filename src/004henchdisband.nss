#include "NW_I0_GENERIC"
#include "nw_i0_henchman"

void main()
{
if (GetIsObjectValid(GetHenchman(OBJECT_SELF)) == TRUE)
    {
    object oHench = GetHenchman(OBJECT_SELF);
    ResetHenchmenState();
    RemoveHenchman(OBJECT_SELF, oHench);
    SignalEvent(oHench, EventUserDefined(1202));
    }
ResetHenchmenState();
RemoveHenchman(GetPCSpeaker(),OBJECT_SELF);
}


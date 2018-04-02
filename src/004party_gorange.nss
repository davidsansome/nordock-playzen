#include "nw_i0_generic"
void main()
{
    SetAssociateState(NW_ASC_USE_RANGED_WEAPON);
    ClearAllActions();
    EquipAppropriateWeapons(GetMaster());
    //Signal Henchmen to Go to Melee
    if (GetIsObjectValid(GetHenchman(OBJECT_SELF)) == TRUE)
        {
        object oHench = GetHenchman(OBJECT_SELF);
        SignalEvent(oHench, EventUserDefined(1204));
        }
}


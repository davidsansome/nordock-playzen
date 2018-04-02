#include "ats_inc_common"
#include "ats_const_common"

void main()
{
    object oPlayer = GetLastUsedBy();
    object oThisOreVein = OBJECT_SELF;

    // Gets the weapon in the right hand slot of the player
    object oWeaponOnPlayer = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPlayer);

    if(ATS_GetTagBaseType(oWeaponOnPlayer) == CSTR_TAILORTOOL )
    {
        //AssignCommand(oPlayer, ActionAttack(oThisOreVein, TRUE));
       AssignCommand(oPlayer, DoPlaceableObjectAction(oThisOreVein,PLACEABLE_ACTION_BASH));
    }
    else
        FloatingTextStringOnCreature(CSTR_ERROR1_MINING, oPlayer, FALSE);
}

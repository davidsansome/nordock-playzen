/****************************************************
  Orevein OnUsed Script
  ats_orevein_use

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is placed on an Orevein's
  OnUsed trigger.  It makes sure the player has
  the proper mining tool equipped and then causes
  the player to attack the orevein.
****************************************************/
#include "ats_inc_common"
#include "ats_const_common"

void main()
{
    object oPlayer = GetLastUsedBy();
    object oThisOreVein = OBJECT_SELF;

    // Gets the weapon in the right hand slot of the player
    object oWeaponOnPlayer = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPlayer);

    if(ATS_GetTagBaseType(oWeaponOnPlayer) == CSTR_MINETOOL1 || ATS_GetTagBaseType(oWeaponOnPlayer) == CSTR_MINETOOL2 || ATS_GetTagBaseType(oWeaponOnPlayer) == CSTR_MINETOOL3 )
    {
        //AssignCommand(oPlayer, ActionAttack(oThisOreVein, TRUE));
       AssignCommand(oPlayer, DoPlaceableObjectAction(oThisOreVein,PLACEABLE_ACTION_BASH));
    }
    else
        FloatingTextStringOnCreature(CSTR_ERROR1_MINING, oPlayer, FALSE);
}

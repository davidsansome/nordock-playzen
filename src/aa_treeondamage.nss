//::///////////////////////////////////////////////
//:: aa_treedamage
//::
//:: This is the on_damaged script for custom tree's
//:: that will produce 2 messages depending on results. 
//:://////////////////////////////////////////////
/*
  
  This is an extra script that you can place on your
  tree's to add alittle more flavor when players are
  chopping on a tree.
  
  This script will go on the 'on_damaged' area of the
  tree's scripts.
    
*/
//:://////////////////////////////////////////////
//:: Created By: Raasta
//:: Created On: November 6, 2002
//:://////////////////////////////////////////////

object oTarget = OBJECT_SELF;

void main()
{

object oPlayer = GetLastDamager();
object oWeaponOnPlayer = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPlayer);

// This checks to see if the player is using the woodsman's axe
// if not, then send them a message stating that they need to 
// switch weapons.   
//
// If they do have the correct item needed to chop wood.. them 
// give them a *chop* !!

if (GetTag(oWeaponOnPlayer) ==  "ITEM_WOODAXE")
        {
        FloatingTextStringOnCreature("*chop*", oPlayer, TRUE);
        }
        else
        {
        FloatingTextStringOnCreature("You must equip your WoodCutters Axe to get wood from trees.", oPlayer, FALSE);
        }
}

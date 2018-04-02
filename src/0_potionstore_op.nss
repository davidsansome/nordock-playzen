//::///////////////////////////////////////////////
//:: Name      Potion Store Open Script
//:: FileName  0_potionstore_op
//:: Copyright (c) 2005 Eagware Corp.
//:://////////////////////////////////////////////
/*
     checks players heal potions and makes sure
     store doesn't stock too many
*/
//:://////////////////////////////////////////////
//:: Created By:      EagleC
//:: Created On:      07 Jan 2005
//:://////////////////////////////////////////////

void main()
{
object oPC, oStore, oItem;
string sItemTag, sHealPotionTag, sPotionResRef;
int nStack, i;

oStore = OBJECT_SELF;
oItem = GetFirstItemInInventory(OBJECT_SELF);
i = 0;
sHealPotionTag = "NW_IT_MPOTION012";
sPotionResRef = "nw_it_mpotion012";

// loop through the shops inventory and destroy the heal potions
while (oItem!=OBJECT_INVALID)
  {
  sItemTag=GetTag(oItem);
  if (sItemTag==sHealPotionTag)
    {
    DestroyObject(oItem);
    }
  // get the next item from the shop
  oItem = GetNextItemInInventory(OBJECT_SELF);
  }

// loop through the players inventory and
// count the number of heal potions they have.
oPC=GetLastOpenedBy();
oItem = GetFirstItemInInventory(oPC);

while (oItem!=OBJECT_INVALID)
    {
    sItemTag=GetTag(oItem);
    if (sItemTag == "NW_IT_MPOTION012")
        {
        nStack = GetItemStackSize(oItem);
        i = i + nStack;
        }
    // get the next item from the PC
    oItem = GetNextItemInInventory(oPC);
    }

// now create a heal potions on the store to allow the player to get 10 maximum.

for (i; i<10;i++)
    {
    oItem = CreateItemOnObject(sPotionResRef, oStore);
    }

}

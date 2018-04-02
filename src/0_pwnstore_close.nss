void main()
{

object oItem = GetFirstItemInInventory(OBJECT_SELF);
int nPlanes, nGold, nValue;

// loops while there are items in the shop
while (oItem!=OBJECT_INVALID)
  {
  nPlanes=FindSubString(GetTag(oItem), "_PLANES");
  nValue = GetGoldPieceValue(oItem);

  // if its a planes item
  if (nPlanes>1 ||nValue<10||nValue>10000)
    {
    nGold = GetStoreGold(OBJECT_SELF) + nValue;
    SetStoreGold(OBJECT_SELF, nGold);
    DestroyObject(oItem);
    }
  // get the next item from the shop
  oItem = GetNextItemInInventory(OBJECT_SELF);
  }

}

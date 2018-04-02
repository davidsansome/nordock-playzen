void main()
{

object oItem = GetFirstItemInInventory(OBJECT_SELF);
int nPlanes, nGold;

// loops while there are items in the shop
while (oItem!=OBJECT_INVALID)
  {
  nPlanes=FindSubString(GetTag(oItem), "_PLANES");
  // if its a planes item
  if (nPlanes>1 ||GetGoldPieceValue(oItem)<10)
    {
    nGold = GetStoreGold(OBJECT_SELF) + GetGoldPieceValue(oItem);
    SetStoreGold(OBJECT_SELF, nGold);
    DestroyObject(oItem);
    }
  // get the next item from the shop
  oItem = GetNextItemInInventory(OBJECT_SELF);
  }

}

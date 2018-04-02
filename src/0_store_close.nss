void main()
{

object oItem = GetFirstItemInInventory(OBJECT_SELF);
int nPlanes;

// loops while there are items in the shop
while (oItem!=OBJECT_INVALID)
  {
  nPlanes=FindSubString(GetTag(oItem), "_PLANES");
  // if its a planes item
  if (nPlanes>1)
    {
    SendMessageToAllDMs("nPlanes = " + IntToString(nPlanes) +
                        ". Destroying" + GetTag(oItem)+".");
    DestroyObject(oItem);
    }
  // get the next item from the shop
  oItem = GetNextItemInInventory(OBJECT_SELF);
  }

}

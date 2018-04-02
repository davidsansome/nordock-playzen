/*
    v1.0.6  Changed GetTag(oItem) to GetResRef(oItem) on Line 13.
*/
//#include "cohort_inc"

void main()
{
    object oNew;

    object oHench = GetLocalObject(OBJECT_SELF,"TransferTo");
    object oItem = GetFirstItemInInventory();

    while (GetIsObjectValid(oItem)) {
          oNew = CreateItemOnObject(GetResRef(oItem),oHench,
                                    GetNumStackedItems(oItem));
          //SendMessageToPC(GetRealMaster(), "(henchmanxfer) Created " + GetName(oNew)); //DEBUG.
          if (GetIdentified(oItem)) SetIdentified(oNew,TRUE);
          DestroyObject(oItem,0.2);
          oItem = GetNextItemInInventory();
    }
}

#include "aps_include"

void main()
{
    object oChest = GetNearestObjectByTag("ARTIFACT_CHEST");
    object oItem = GetFirstItemInInventory(oChest);
    while (GetIsObjectValid(oItem))
    {
        string sResRef = GetResRef(oItem);
        SQLExecDirect("SELECT `resref` FROM `nordock_artifacts` WHERE `resref` = '" + SQLEncodeSpecialChars(sResRef) + "'");
        if (SQLFetch() == SQL_SUCCESS)
        {
            SQLExecDirect("DELETE FROM `nordock_artifacts` WHERE `resref` = '" + SQLEncodeSpecialChars(sResRef) + "' LIMIT 1");
            SendMessageToAllDMs("Removed from artifacts list: " + GetName(oItem));
            DestroyObject(oItem);
        }
        else
            SendMessageToAllDMs(GetName(oItem) + " not found in artifacts list");
        oItem = GetNextItemInInventory(oItem);
    }
}

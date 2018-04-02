#include "aps_include"

void main()
{
    object oChest = GetNearestObjectByTag("ARTIFACT_CHEST");
    object oItem = GetFirstItemInInventory(oChest);
    while (GetIsObjectValid(oItem))
    {
        string sResRef = GetResRef(oItem);
        SQLExecDirect("SELECT `resref` FROM `nordock_artifacts` WHERE `resref` = '" + SQLEncodeSpecialChars(sResRef) + "'");
        if (SQLFetch() == SQL_ERROR)
        {
            SQLExecDirect("INSERT INTO `nordock_artifacts` (`resref`,`found`) VALUES ('" + SQLEncodeSpecialChars(sResRef) + "',0)");
            SendMessageToAllDMs("Added to artifacts list: " + GetName(oItem));
            DestroyObject(oItem);
        }
        else
            SendMessageToAllDMs(GetName(oItem) + " already exists in the artifacts list");
        oItem = GetNextItemInInventory(oItem);
    }
}

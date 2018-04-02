#include "aps_include"

void main()
{
    object oChest = GetNearestObjectByTag("ARTIFACT_CHEST");
    SQLExecDirect("SELECT `resref`, `found` FROM `nordock_artifacts`");
    while (SQLFetch() == SQL_SUCCESS)
    {
        string sResRef = SQLGetData(1);
        int iFound = StringToInt(SQLGetData(2));

        object oArtifact = CreateItemOnObject(sResRef, oChest);

        if (iFound == 1)
            SendMessageToAllDMs("Artifact: " + GetName(oArtifact) + " (already found)");
        else
            SendMessageToAllDMs("Artifact: " + GetName(oArtifact));
    }
}

#include "tha_furniture"

void HousingEnter();
void DespawnObjects();
void MakeFurniSparks();
void SpawnHouseObjects(string sTag);

object oPC = GetLocalObject(OBJECT_SELF,"Owner");

void main()
{
    int nUser = GetUserDefinedEventNumber();

    if(nUser == 500)
    {
        DespawnObjects();
        HousingEnter();
    }

    else if(nUser == 502)
        MakeFurniSparks();

    return;
}

void HousingEnter()
{
    PrintString("Entered House");

    //Find the house deed
    object oItem = GetFirstItemInInventory(oPC);
    while((oItem!= OBJECT_INVALID))
    {
        if(GetResRef(oItem) == "ahousedeed")
            break;

        oItem = GetNextItemInInventory(oPC);
    }

    //Create house deed if the player does not have one.
    if(oItem == OBJECT_INVALID)
        oItem = CreateItemOnObject("ahousedeed",oPC);

    //See if they have placeable objects yet
    string sTag = GetTag(oItem);

    //Spawn sparks to show where objects can be placed
    if(sTag == "empty")
        MakeFurniSparks();

    //Else spawn the players objects
    else if(sTag != "empty")
        SpawnHouseObjects(sTag);


    return;
}

void SpawnHouseObjects(string sTag)
{
    int sLength = GetStringLength(sTag);
    int i;

    object oWP, oPLC;

    string iStr,fRef,fLookUp,iPos;

    for(i=1; i<=sLength; i++)
    {
        iStr = GetSubString(sTag,i-1,1);
        iPos = IntToString(i);

        if(i <= 9)
            iPos = "0"+iPos;

        if(iStr != "_")
        {
            fLookUp = LookUpFurniture(iStr);

            if(fLookUp == "")
            {
                FloatingTextStringOnCreature("Error Looking Up Furniture. ID: '"+iStr+"'",oPC,FALSE);
            }

            fRef = "furn_"+fLookUp;

            oWP = GetNearestObjectByTag("HPLACE_"+iPos,oPC);

            SetLocalInt(oWP,"furniplace",TRUE);
            oPLC = CreateObject(OBJECT_TYPE_PLACEABLE,fRef,GetLocation(oWP));

            // an ats forge requires special initialisation
            if (GetTag(oPLC) == "ATS_FORGE_BASIC") AssignCommand(oPLC, ExecuteScript("qel_initforge", oPLC));

            AssignCommand(oPLC,SetFacing(GetFurnitureFacing(fRef,oWP)));
        }
    }

    return;
}

void DespawnObjects()
{
    object oObj = GetFirstObjectInArea(OBJECT_SELF);
    int oType;
    int i = 0;

    while ((oObj != OBJECT_INVALID))
    {
        oType = GetObjectType(oObj);

        if(oType == OBJECT_TYPE_WAYPOINT)
            DeleteLocalInt(oObj,"furniplace");
        else if((oType != OBJECT_TYPE_DOOR) && (GetResRef(oObj) != "house_size"))
            DestroyObject(oObj);

        oObj = GetNextObjectInArea(OBJECT_SELF);
    }

    DeleteLocalInt(OBJECT_SELF,"pNum");
    DeleteLocalObject(OBJECT_SELF,"owner");

    return;
}

void MakeFurniSparks()
{
    int i = 1;
    object oWP = GetNearestObjectByTag("HPLACE_0"+IntToString(i),oPC);
    object oSpark;

    string iNum;

    while(oWP != OBJECT_INVALID)
    {
        if(i <= 9)
            iNum = "0"+IntToString(i);
        else
            iNum = IntToString(i);

        oWP = GetNearestObjectByTag("HPLACE_"+iNum,oPC);

        if(!GetLocalInt(oWP,"furniplace"))
            CreateObject(OBJECT_TYPE_PLACEABLE,"furnisparks",GetLocation(oWP));

        i=i+1;
    }
}

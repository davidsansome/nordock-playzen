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

void SpawnHouseObjects(string sTag)
{
    object oWP,oPLC;

    string sTestString = sTag;
    string sChar;
    string sCharNext;

    string sRef;
    string wNum;

    int iLength = GetStringLength(sTestString);
    int i;
    int iNum;
    int iLastOccurence=0;
    int gotOne = 0;

    for (i=0; i<=iLength-1; i++)
    {
        sChar = GetSubString(sTestString, i,1);
        sCharNext = GetSubString(sTestString, i+1,1);

        if (sChar == "_" && sCharNext == "_" || sCharNext == "")
        {

            if (sCharNext != "")
            {
                if(!gotOne)
                {
                    sRef = GetSubString(sTestString, iLastOccurence, i-iLastOccurence);
                    gotOne = 1;
                }
                else
                {
                    wNum = GetSubString(sTestString, iLastOccurence, i-iLastOccurence);
                    oWP = GetNearestObjectByTag("HPLACE_"+wNum,oPC);

                    SetLocalInt(oWP,"furniplace",TRUE);

                    oPLC = CreateObject(OBJECT_TYPE_PLACEABLE,sRef,GetLocation(oWP));

                    AssignCommand(oPLC,SetFacing(GetFurnitureFacing(sRef,oWP)));

                    sRef = "";
                    wNum = "";
                    gotOne = 0;

                }

                iLastOccurence = i+2;
            }

        }

    }
}



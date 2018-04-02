#include "tha_furniture"

void THA_PlaceableDeed(object oPC, object oItem, string sTag);
void THA_KeyUse(object oPC, object oItem, string sTag, object oTarget);
void THA_DeletePlaceable(object oPC, object oItem, string sTag, object oTarget);

void main()
{
    object oItem = GetItemActivated();
    object oPC = GetItemActivator();
    object oTarget = GetItemActivatedTarget();

    string sTag = GetTag(oItem);
    string sResRef = GetResRef(oItem);

    if(FindSubString(sResRef,"pdeed") != -1)
        THA_PlaceableDeed(oPC,oItem,sTag);

    else if(FindSubString(sResRef,"house_key") != -1)
        THA_KeyUse(oPC,oItem,sTag,oTarget);

    //Targetted placeable for destruction
    else if((sResRef == "ahousedeed") && (GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE))
        THA_DeletePlaceable(oPC,oItem,sTag,oTarget);

    //Targetted a location
    else if(sResRef == "ahousedeed")
        SignalEvent(GetArea(oPC),EventUserDefined(502));

    return;
}

void THA_DeletePlaceable(object oPC, object oItem, string sTag, object oTarget)
{
    object oWP = GetNearestObject(OBJECT_TYPE_WAYPOINT,oTarget);
    string fNum = GetStringRight(GetTag(oWP),2);

    string sTestString = sTag;
    string sChar;
    string sCharNext;

    string sRef;
    string wNum;

    string nTag;

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

                    if(fNum != wNum)
                        nTag += sRef+"__"+wNum+"__";

                    sRef = "";
                    wNum = "";
                    gotOne = 0;

                }

                iLastOccurence = i+2;
            }
        }
    }

    SetLocalInt(oWP,"furniplace",FALSE);
    DestroyObject(oTarget);

    CopyObject(oItem,GetLocation(oPC),oPC,nTag);
    DestroyObject(oItem);

    return;
}

void THA_KeyUse(object oPC, object oItem, string sTag, object oTarget)
{
    PrintString("Key Used");
    AssignCommand(oPC,SpeakString("Leave and never return "+GetName(oTarget)+"!!"));
    AssignCommand(oTarget,ActionJumpToObject(GetLocalObject(GetArea(OBJECT_SELF),"FrontDoor")));

    return;
}

void THA_PlaceableDeed(object oPC, object oItem, string sTag)
{
        object oDeed = GetFirstItemInInventory(oPC);

        object oWP = GetNearestObject(OBJECT_TYPE_WAYPOINT,oPC);
        string nWP = GetStringRight(GetTag(oWP),2);
        location pLoc = GetLocation(oWP);

        while((oDeed!= OBJECT_INVALID))
        {
            if(GetResRef(oDeed) == "ahousedeed")
                break;

            oDeed = GetNextItemInInventory(oPC);
        }

        string dTag = GetTag(oDeed);
        string newTag;


        if(dTag == "empty")
            newTag = sTag+"__"+nWP+"__";

        else
            newTag = dTag+sTag+"__"+nWP+"__";

        //Update the House Deed for new furniture
        CopyObject(oDeed,GetLocation(oPC),oPC,newTag);
        DestroyObject(oDeed);

        //Create the furniture, destroy the deed.
        object oPLC = CreateObject(OBJECT_TYPE_PLACEABLE,sTag,pLoc);
        AssignCommand(oPLC,SetFacing(GetFurnitureFacing(sTag,oWP)));

}


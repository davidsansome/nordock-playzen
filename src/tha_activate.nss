#include "tha_furniture"

void THA_PlaceableDeed(object oPC, object oItem, string sTag);
void THA_KeyUse(object oPC, object oItem, string sTag, object oTarget);
void THA_DeletePlaceable(object oPC, object oItem, string sTag, object oTarget);

string eTag = "________________________________";



void main()
{
    object oItem = GetItemActivated();
    object oPC = GetItemActivator();
    object oTarget = GetItemActivatedTarget();

    string sTag = GetTag(oItem);
    string sResRef = GetResRef(oItem);

    if(FindSubString(sTag,"furn") != -1)
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

void THA_PlaceableDeed(object oPC, object oItem, string sTag)
{
    object oOwner = GetLocalObject(GetArea(oPC),"Owner");

    if(oOwner == oPC)
    {
        object oDeed = GetFirstItemInInventory(oPC);

        object oWP = GetNearestObject(OBJECT_TYPE_WAYPOINT,oPC);
        int nWP = StringToInt(GetStringRight(GetTag(oWP),2));
        location pLoc = GetLocation(oWP);

        while((oDeed!= OBJECT_INVALID))
        {
            if(GetResRef(oDeed) == "ahousedeed")
                break;

            oDeed = GetNextItemInInventory(oPC);
        }

        string dTag = GetTag(oDeed);
        string nTag, sFurnID;

        sFurnID = GetFurnitureID(sTag);

        if(sFurnID == "_")
        {
            FloatingTextStringOnCreature("Furniture ID error: "+sTag,oPC,FALSE);
            CopyObject(oItem,GetLocation(oPC),oPC,sTag);
            return;
        }

        if(dTag == "empty")
            nTag = GetSubString(eTag,0,(nWP-1))+sFurnID+GetSubString(eTag,nWP,(32-nWP));

        else
            nTag = GetSubString(dTag,0,(nWP-1))+sFurnID+GetSubString(dTag,nWP,(32-nWP));

        if(GetStringLength(nTag) != 32)
        {
            FloatingTextStringOnCreature("Fatal Housing Error, nTag not 32 - unknown reason.",oPC,FALSE);
            return;
        }

        //Update the House Deed for new furniture
        CopyObject(oDeed,GetLocation(oPC),oPC,nTag);
        DestroyObject(oDeed);

        //Create the furniture, destroy the deed.
        object oPLC = CreateObject(OBJECT_TYPE_PLACEABLE,sTag,pLoc);
        AssignCommand(oPLC,SetFacing(GetFurnitureFacing(sTag,oWP)));

        //Debug Strings
        //AssignCommand(oPC,SpeakString((nTag)+" len: "+IntToString(GetStringLength(nTag))));));
    }
}

void THA_DeletePlaceable(object oPC, object oItem, string sTag, object oTarget)
{
    object oOwner = GetLocalObject(GetArea(oPC),"Owner");

    if(oOwner == oPC)
    {
        object oWP = GetNearestObject(OBJECT_TYPE_WAYPOINT,oTarget);
        int wNum = StringToInt(GetStringRight(GetTag(oWP),2));

        string nTag = GetSubString(sTag,0,(wNum-1))+"_"+GetSubString(sTag,(wNum),(32-wNum));

        if(nTag == eTag)
            nTag = "empty";

        if(GetStringLength(nTag) != 32)
        {
            FloatingTextStringOnCreature("Fatal Housing Error, nTag not 32 - unknown reason.",oPC,FALSE);
            return;
        }

        else
        {
            //Set int for furnisparks
            SetLocalInt(oWP,"furniplace",FALSE);
            //Destroy the furniture
            DestroyObject(oTarget);

            //Update the house deed
            CopyObject(oItem,GetLocation(oPC),oPC,nTag);
            DestroyObject(oItem);

            //Debug Strings
            //AssignCommand(oPC,SpeakString((nTag)+" len: "+IntToString(GetStringLength(nTag))));
        }
    }

    return;
}

void THA_KeyUse(object oPC, object oItem, string sTag, object oTarget)
{
    object oOwner = GetLocalObject(GetArea(oPC),"Owner");

    if(oOwner == oPC)
    {
        AssignCommand(oPC,SpeakString(GetName(oTarget)+"!! I cast you out!!"));
        AssignCommand(oTarget,ActionJumpToObject(GetLocalObject(GetArea(OBJECT_SELF),"FrontDoor")));
    }

    return;
}

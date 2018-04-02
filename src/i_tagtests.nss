//::///////////////////////////////////////////////
//:: i_tagtests - "No Drop" items (from EQ)
//::///////////////////////////////////////////////
/*
This script is used by other scripts that prevent a PC from
attempting to drop, barter, sell or place items designated as "No Drop".
*/
//:://////////////////////////////////////////////
//:: Author: Scott Thorne
//:: E-mail: Thornex2@wans.net
//:: Updated: Aug 13, 2002
//:://////////////////////////////////////////////
/*

To use:

1) Update the list of Tags to include the items you designate as NoDrop
   in the GetIsNoDrop() function.

2) Note that Tags MUST match the blueprint's ResRef, except for case, or
   item will be destroyed on dropping and not recreated in inventory.

//////////////////////////////////////////////////

    Implemented into Hardcore Ruleset v2.0 for
    the Subrace Spell-Like Ability Items.
    -- Panduh
    This script was updated to check all the standard
    HCR no drop items
    -- Diabolique
//////////////////////////////////////////////////
*/
// This function returns TRUE if the item is flagged no drop
// Do not call this function, instead, use GetIsNoDrop()
// Add your own items that should be flagged no drop, here
// Or make your object's tag end in '_NDP' and it will
// Be seen as no drop, by the script.
int GetIsItemNoDrop(object oItem)
{
    int iNoDrop;
    string sItemTag = GetTag(oItem);

    if ((sItemTag =="TrackerTool") ||
        (sItemTag =="hc_paladinsymb") ||
        (sItemTag == "hc_palbadgecour" ) ||
        (sItemTag == "searchtool") ||
        (FindSubString(GetStringUpperCase(sItemTag), "_NDP")>0) ||
        (FindSubString(sItemTag, "sei_sla")>0) ||
        (sItemTag=="ControlShapeTool") ||
        (sItemTag=="fugue_NOD") ||
        (sItemTag=="EmoteWand"))
        {
            iNoDrop = TRUE;
        }
    else
        iNoDrop = FALSE;
    return iNoDrop;
}


int CheckInsideContainer(object oContainer)
{
    object oItem = GetFirstItemInInventory(oContainer);
    int iNoDrop = FALSE;

    while(GetIsObjectValid(oItem))
    {
        if (GetIsItemNoDrop(oItem))
            {
            iNoDrop = TRUE;
            break;
            }
            oItem = GetNextItemInInventory(oContainer);
    }
    return iNoDrop;
}

// This function returns TRUE if the Item is Flagged as NoDrop
// If the Item is a container, all its contents will be checked
// and if even one item inside the container is a NoDrop, the whole
// container will be flagged as nodrop.
// -- diabolique
int GetIsNoDrop(object oItem)
{
int iNoDrop;
string sItemTag = GetTag(oItem);

if (GetBaseItemType(oItem) == BASE_ITEM_LARGEBOX)
    if (FindSubString(GetStringUpperCase(sItemTag), "_NDP")>0)
        return TRUE; //if the container itself is a nodrop object, return true
    else    // Else it will check the contents...
        iNoDrop = CheckInsideContainer(oItem);
else
    iNoDrop = GetIsItemNoDrop (oItem);

return iNoDrop;
}



void Debug(string sMessage)
{
    WriteTimestampedLogEntry(sMessage);
    object oPC = GetFirstPC();
    while (GetIsPC(oPC))
    {
        SendMessageToPC(oPC, sMessage);
        oPC = GetNextPC();
    }
}

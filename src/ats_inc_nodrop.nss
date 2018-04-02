/****************************************************
  No Drop #include Script
  ats_inc_nodrop

  Last Updated: September 22, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script contains the core no-drop code that
  destroys an object and recreates it if it is dropped
  or traded.  There are a few workarounds in place
  for some Bioware bugs.

****************************************************/
/*
#include "ats_inc_common"
#include "ats_const_common"

void ATS_CheckForRemovedNoDropItems(object oPlayer, object oItemLost)
{

    string sItemTag = GetTag(oItemLost);
    int bDropDestroy = FALSE;

    SetLocalObject(oItemLost, "ats_prev_possessor", oPlayer);
    if(GetLocalObject(oItemLost, "ats_obj_possessor") == OBJECT_INVALID)
        SetLocalObject(oItemLost, "ats_obj_possessor", oPlayer);
    object oItemInContainer = OBJECT_INVALID;

    // Check to see if a droppable container contains no-drop items
    if(!ATS_IsItemNoDrop(oItemLost) && GetHasInventory(oItemLost) == TRUE)
    {
        oItemInContainer = GetFirstItemInInventory(oItemLost);
        while(GetIsObjectValid(oItemInContainer) == TRUE)
        {
            if(ATS_IsItemNoDrop(oItemInContainer) == TRUE || GetStringLeft(GetTag(oItemInContainer), GetStringLength(CSTR_TOKEN_TAG)) == CSTR_TOKEN_TAG)
            {
                FloatingTextStringOnCreature("There are items in this container you cannot remove.", oPlayer, FALSE);
                // Mark the bag as temprorarily no-drop
                SetLocalInt(oItemLost, "ats_nodrop", TRUE);
                break;
            }
            oItemInContainer = GetNextItemInInventory(oItemLost);
        }
    }
    // Item lost was a token or no drop item
    if(ATS_IsItemNoDrop(oItemLost)  || FindSubString(sItemTag, CSTR_TOKEN_TAG) == 0 )
    {
        object oItemPossessor = GetItemPossessor(oItemLost);
        if(oItemPossessor == oPlayer)
            return;

        vector vItemPos = GetPositionFromLocation(GetLocation(oItemLost));

        if(GetIsObjectValid(oItemPossessor) == TRUE && GetObjectType(oItemPossessor) == OBJECT_TYPE_CREATURE)
        {
            // Item was stolen
            SetLocalInt(oItemLost, "ats_item_stolen", TRUE);
            return;
        }
        // Item is in a trade window so do nothing to avoid crash bug
        else if( vItemPos == Vector() && GetIsObjectValid(oItemPossessor) == FALSE)
        {
            return;
        }

        string sDisplayMessage = "You cannot remove this.";

        if(GetObjectType(oItemPossessor) == OBJECT_TYPE_STORE)
        {
            int iGoldValue = GetGoldPieceValue(oItemLost);
            if(iGoldValue > 0)
            {
                sDisplayMessage = "You cannot sell this item.";
                AssignCommand(oPlayer, TakeGoldFromCreature(iGoldValue, oPlayer, TRUE));
            }
        }
        if(FindSubString(GetStringUpperCase(GetTag(oItemLost)), "_NODD") > 0)
        {
            bDropDestroy = TRUE;
            sDisplayMessage = "Your " + GetName(oItemLost) + " has mysteriously" +
                              " disappeared!";
        }
        int iQuantity = GetNumStackedItems(oItemLost);
        object oNewItem;

        if(!bDropDestroy)
        {
            ATS_CreateItemOnPlayer(ATS_GetResRefFromTag(sItemTag), oPlayer, iQuantity, FALSE);
            oNewItem =  GetLocalObject(oPlayer, "ats_returnvalue_created_item");
        }
        else
            oNewItem = OBJECT_INVALID;

        // Must recreate contents if item has any
        if(GetHasInventory(oItemLost) == TRUE)
        {
            object oCreatedItem;
            oItemInContainer = GetFirstItemInInventory(oItemLost);
            // Container is a no-drop and destroy object
            if(bDropDestroy)
            {
                if(oItemInContainer == OBJECT_INVALID)
                {
                    DestroyObject(oItemLost);
                    sDisplayMessage = "This container has mysteriously vanished!";
                    FloatingTextStringOnCreature(sDisplayMessage, oPlayer, FALSE);
                    return;
                }
                else
                {
                    ATS_CreateItemOnPlayer(ATS_GetResRefFromTag(sItemTag), oPlayer, iQuantity, FALSE);
                    oNewItem =  GetLocalObject(oPlayer, "ats_returnvalue_created_item");
                    sDisplayMessage = "You cannot remove this.";
               }
            }
            while(GetIsObjectValid(oItemInContainer) == TRUE)
            {
                ATS_CreateItemInContainer(ATS_GetResRefFromTag(GetTag(oItemInContainer)), oNewItem, GetNumStackedItems(oItemInContainer));
                oCreatedItem = GetLocalObject(oNewItem, "ats_returnvalue_created_item");
                // Item did not fit back in box and is not no-drop so create on the player
                if(GetItemPossessor(oCreatedItem) == OBJECT_INVALID && !ATS_IsItemNoDrop(oItemInContainer))
                {
                    DestroyObject(oCreatedItem);
                    ATS_CreateItemOnPlayer(ATS_GetResRefFromTag(GetTag(oItemInContainer)), oPlayer, GetNumStackedItems(oItemInContainer));
                    oCreatedItem = GetLocalObject(oPlayer, "ats_returnvalue_created_item");
                }
                // Sets the plot flag back to original
                SetPlotFlag(oCreatedItem, GetPlotFlag(oItemInContainer));
                SetIdentified(oCreatedItem, GetIdentified(oItemInContainer));
                SetLocalObject(oCreatedItem, "ats_obj_possessor", oPlayer);

                DestroyObject(oItemInContainer);
                oItemInContainer = GetNextItemInInventory(oItemLost);
            }
        }


        // Sets the plot flag back to original
        SetPlotFlag(oNewItem, GetPlotFlag(oItemLost));
        SetIdentified(oNewItem, GetIdentified(oItemLost));
        SetLocalObject(oNewItem, "ats_obj_possessor", oPlayer);
        DestroyObject(oItemLost);

        FloatingTextStringOnCreature(sDisplayMessage, oPlayer, FALSE);
    }
}

void ATS_AssignPossessorToNoDropItems(object oPlayer, object oItemAcquired)
{
    string sItemTag = GetTag(oItemAcquired);
    object oAcquiredFrom = GetLocalObject(oItemAcquired, "ats_prev_possessor");
    object oNewItem = OBJECT_INVALID;
    string sDisplayMessage1 = "";
    string sDisplayMessage2 = "";

    int bDropDestroy = FALSE;

    if(ATS_IsItemNoDrop(oItemAcquired) || FindSubString(sItemTag, CSTR_TOKEN_TAG) == 0)
    {
        // Check to see if nodrop item was traded
        if(GetIsObjectValid(oAcquiredFrom) == TRUE
           && oAcquiredFrom !=oPlayer)
        {
            if(FindSubString(GetStringUpperCase(GetTag(oItemAcquired)), "_NODD") > 0)
            {
                bDropDestroy = TRUE;
                sDisplayMessage2 = "Your " + GetName(oItemAcquired) + " has mysteriously" +
                                " disappeared!";
            }
            else
            {
                ATS_CreateItemOnPlayer(ATS_GetResRefFromTag(sItemTag), oAcquiredFrom,
                                   GetNumStackedItems(oItemAcquired), FALSE);
                oNewItem =  GetLocalObject(oAcquiredFrom, "ats_returnvalue_created_item");
            }
            if(GetHasInventory(oItemAcquired) == TRUE)
            {
                object oItemInContainer = GetFirstItemInInventory(oItemAcquired);
                            // Container is a no-drop and destroy object
                if(bDropDestroy && oItemInContainer == OBJECT_INVALID)
                {
                    DestroyObject(oItemAcquired);
                    sDisplayMessage2 = "This container has mysteriously vanished!";
                    FloatingTextStringOnCreature(sDisplayMessage2, oPlayer, FALSE);
                    return;
                }
                object oCreatedItem;
                while(GetIsObjectValid(oItemInContainer) == TRUE)
                {
                    ATS_CreateItemInContainer(ATS_GetResRefFromTag(GetTag(oItemInContainer)), oNewItem, GetNumStackedItems(oItemInContainer));
                    oCreatedItem = GetLocalObject(oNewItem, "ats_returnvalue_created_item");
                    // Item did not fit back in box and is not no-drop so create on the player
                    if(GetItemPossessor(oCreatedItem) == OBJECT_INVALID && !ATS_IsItemNoDrop(oItemInContainer))
                    {
                        DestroyObject(oCreatedItem);
                        ATS_CreateItemOnPlayer(ATS_GetResRefFromTag(GetTag(oItemInContainer)), oAcquiredFrom, GetNumStackedItems(oItemInContainer));
                        oCreatedItem = GetLocalObject(oPlayer, "ats_returnvalue_created_item");
                    }
                    // Sets the plot flag back to original
                    SetPlotFlag(oCreatedItem, GetPlotFlag(oItemInContainer));
                    SetIdentified(oCreatedItem, GetIdentified(oItemInContainer));
                    SetLocalObject(oNewItem, "ats_obj_possessor", oPlayer);

                    DestroyObject(oItemInContainer);

                    oItemInContainer = GetNextItemInInventory(oItemAcquired);
                }
            }
            // Sets the plot flag back to original
            SetPlotFlag(oNewItem, GetPlotFlag(oItemAcquired));
            SetIdentified(oNewItem, GetIdentified(oItemAcquired));
            SetLocalObject(oNewItem, "ats_obj_possessor", oPlayer);

            DestroyObject(oItemAcquired);

            if(GetLocalInt(oItemAcquired, "ats_item_stolen") == TRUE)
                sDisplayMessage2 = "You cannot steal that item.";
            else
                sDisplayMessage1 = "You cannot trade this.";

            FloatingTextStringOnCreature(sDisplayMessage2, oPlayer, FALSE);
            FloatingTextStringOnCreature(sDisplayMessage1, oAcquiredFrom, FALSE);

        }
        else
        {
            //Move tokens into skill box
            if( GetStringLeft(sItemTag, GetStringLength(CSTR_TOKEN_TAG)) == CSTR_TOKEN_TAG)
            {
                object oSkillBox = GetItemPossessedBy(oPlayer, CSTR_PERSISTENT_SKILLS_BOXTAG);
                AssignCommand(oPlayer, ActionGiveItem(oItemAcquired, oSkillBox) );
            }
            // Assign possessor to object to get around bioware bug
            SetLocalObject(oItemAcquired, "ats_obj_possessor", oPlayer);
        }
    }
    else
       // Assign possessor to object to get around bioware bug
       SetLocalObject(oItemAcquired, "ats_obj_possessor", oPlayer);

}
*/

//Dependencies: ats_inc_common, ats_const_mat, ats_const_common, ats_inc_material, ats_inc_cr_get

/*  ATS_FindComponents function written to combine the redundant
    ATS_CheckCraftComponentsOnPlayer and ATS_RemoveCraftMaterials
    functions simply adding a flag to indicate whether or not to
    remove the components when they're found.  Later improved it to
    also allow it to handle removing components based on risk instead
    of all or nothing, for use in ats_at_cr_fail.

    Remove = 0 find them, report them as found, but don't remove.
    Remove = 1 find them, remove them all, report them as removed.
    Remove = 2 compute losses based on consumption risk, find and
               remove them.

    Also added functionality to speed the inventory search, making
    non-matching items fail much more quickly, reducing TMIs further
    by reducing the failing iterations to 2 instructions each.  The
    first pass through, a master search string is built (AllTags)
    which includes all the tags for needed items, concatenated into
    one huge string.  At the end of that pass, it cycles through the
    inventory in a quick search for the next matching tag, once it
    finds one it sends it through the main loop for another pass,
    figuring out which it was, and whether or not all the needed items
    of that type have been found or not.  To increase efficiency
    further, each time an item is found, and no more of that item
    type are needed, we rebuild the search string to hone the search
    for the remaining items needed.  Once the search string is blank,
    all items have been found, and we drop out of the loop completely.
    This functionality adds a half dozen or so instructions to the
    passes where an item matches, but it reduces the hundreds of
    passes where an item doesn't match to 2 instructions each.  The
    more cluttered the PC's inventory, the more efficient it becomes.

    Written by: Keith Westrate <helimar@earthlink.net> using Mojo's
    original code for the redundant functions.
*/
#include "ats_inc_common"
#include "ats_const_mat"
#include "ats_const_common"
#include "ats_inc_material"
#include "ats_inc_cr_get"

int ATS_FindComponents(object oPlayer, string sCraftTag, int iMaterialType, int Remove)
{
    string sDyeTagNeeded = ATS_GetComponentTagFromRecipe(sCraftTag, CINT_COMPONENT_ID_DYES, iMaterialType);
    int iDyeAmountNeeded = ATS_GetComponentAmountFromRecipe(sCraftTag, CINT_COMPONENT_ID_DYES, iMaterialType);

    string sFlowerTagNeeded = ATS_GetComponentTagFromRecipe(sCraftTag, CINT_COMPONENT_ID_FLOWERS, iMaterialType);
    int iFlowerAmountNeeded = ATS_GetComponentAmountFromRecipe(sCraftTag, CINT_COMPONENT_ID_FLOWERS, iMaterialType);

    string sClothSTagNeeded = ATS_GetComponentTagFromRecipe(sCraftTag, CINT_COMPONENT_ID_CLOTHSS, iMaterialType);
    int iClothSAmountNeeded = ATS_GetComponentAmountFromRecipe(sCraftTag, CINT_COMPONENT_ID_CLOTHSS, iMaterialType);

    string sClothMTagNeeded = ATS_GetComponentTagFromRecipe(sCraftTag, CINT_COMPONENT_ID_CLOTHSM, iMaterialType);
    int iClothMAmountNeeded = ATS_GetComponentAmountFromRecipe(sCraftTag, CINT_COMPONENT_ID_CLOTHSM, iMaterialType);

    string sClothLTagNeeded = ATS_GetComponentTagFromRecipe(sCraftTag, CINT_COMPONENT_ID_CLOTHSL, iMaterialType);
    int iClothLAmountNeeded = ATS_GetComponentAmountFromRecipe(sCraftTag, CINT_COMPONENT_ID_CLOTHSL, iMaterialType);

    string sIngotTagNeeded = ATS_GetComponentTagFromRecipe(sCraftTag, CINT_COMPONENT_ID_INGOTS, iMaterialType);
    int iIngotAmountNeeded = ATS_GetComponentAmountFromRecipe(sCraftTag, CINT_COMPONENT_ID_INGOTS, iMaterialType);

    string sGemTagNeeded = ATS_GetComponentTagFromRecipe(sCraftTag, CINT_COMPONENT_ID_GEMS, iMaterialType);
    int iGemAmountNeeded = ATS_GetComponentAmountFromRecipe(sCraftTag, CINT_COMPONENT_ID_GEMS, iMaterialType);

    string sIdealGemTagNeeded = ATS_GetComponentTagFromRecipe(sCraftTag, CINT_COMPONENT_ID_IDEALGEMS, iMaterialType);
    int iIdealGemAmountNeeded = ATS_GetComponentAmountFromRecipe(sCraftTag, CINT_COMPONENT_ID_IDEALGEMS, iMaterialType);

    int bFoundAllNeeded = TRUE;
    int iConsumptionCount = 0;
    int iConsumptionRisk;

    string sItemTag;
    string sCustomTagNeeded;
    string sCustomBundleTagNeeded;
    int iBundleAmount = 0;
    int iRemainingQuantity = 0;
    int iStackedQuantity = 0;

    int BuildTags = TRUE;
    int RebuildTags = FALSE;
    string AllTags = "";

    int iCustomAmountNeeded;
    int iCustomMaterialCount = GetLocalInt(GetModule(), sCraftTag + "_custom_material");

    string sMessage;

    int i, count;

    if(Remove == 2)
    { // if remove is 2, only remove components based on consumption risk
        iConsumptionRisk = ATS_GetConsumptionRiskFromRecipe(sCraftTag, CINT_COMPONENT_ID_DYES, iMaterialType);
        for(i = 1; i <= iDyeAmountNeeded; ++i)
        {
            if(d100(1) <= iConsumptionRisk)
                ++iConsumptionCount;
        }
        iDyeAmountNeeded = iConsumptionCount;
        if(iConsumptionCount > 0)
        { // since we knew the PC had enough components to attempt the
          // craft, assume we'll find them and remove them
            sMessage = "You have lost " + IntToString(iConsumptionCount)
                    + " " + ATS_GetMaterialName(iMaterialType) + " dye";
            if(iConsumptionCount > 1) sMessage += "s";
            sMessage += ".";

            SendMessageToPC(oPlayer, sMessage);
        }
        iConsumptionCount = 0;
        iConsumptionRisk = ATS_GetConsumptionRiskFromRecipe(sCraftTag, CINT_COMPONENT_ID_FLOWERS, iMaterialType);
        for(i = 1; i <= iFlowerAmountNeeded; ++i)
        {
            if(d100(1) <= iConsumptionRisk)
                ++iConsumptionCount;
        }
        iFlowerAmountNeeded = iConsumptionCount;
        if(iConsumptionCount > 0)
        { // since we knew the PC had enough components to attempt the
          // craft, assume we'll find them and remove them
            sMessage = "You have lost " + IntToString(iConsumptionCount)
                    + " " + ATS_GetMaterialName(iMaterialType) + " flower";
            if(iConsumptionCount > 1) sMessage += "s";
            sMessage += ".";

            SendMessageToPC(oPlayer, sMessage);
        }
        iConsumptionCount = 0;
        iConsumptionRisk = ATS_GetConsumptionRiskFromRecipe(sCraftTag, CINT_COMPONENT_ID_CLOTHSS, iMaterialType);
        for(i = 1; i <= iClothSAmountNeeded; ++i)
        {
            if(d100(1) <= iConsumptionRisk)
                ++iConsumptionCount;
        }
        iClothSAmountNeeded = iConsumptionCount;
        if(iConsumptionCount > 0)
        { // since we knew the PC had enough components to attempt the
          // craft, assume we'll find them and remove them
            sMessage = "You have lost " + IntToString(iConsumptionCount)
                    + " " + ATS_GetMaterialName(iMaterialType) + " small cloth";
            if(iConsumptionCount > 1) sMessage += "s";
            sMessage += ".";

            SendMessageToPC(oPlayer, sMessage);
        }
        iConsumptionCount = 0;
        iConsumptionRisk = ATS_GetConsumptionRiskFromRecipe(sCraftTag, CINT_COMPONENT_ID_CLOTHSM, iMaterialType);
        for(i = 1; i <= iClothMAmountNeeded; ++i)
        {
            if(d100(1) <= iConsumptionRisk)
                ++iConsumptionCount;
        }
        iClothMAmountNeeded = iConsumptionCount;
        if(iConsumptionCount > 0)
        { // since we knew the PC had enough components to attempt the
          // craft, assume we'll find them and remove them
            sMessage = "You have lost " + IntToString(iConsumptionCount)
                    + " " + ATS_GetMaterialName(iMaterialType) + " medium cloth";
            if(iConsumptionCount > 1) sMessage += "s";
            sMessage += ".";

            SendMessageToPC(oPlayer, sMessage);
        }
        iConsumptionCount = 0;
        iConsumptionRisk = ATS_GetConsumptionRiskFromRecipe(sCraftTag, CINT_COMPONENT_ID_CLOTHSL, iMaterialType);
        for(i = 1; i <= iClothLAmountNeeded; ++i)
        {
            if(d100(1) <= iConsumptionRisk)
                ++iConsumptionCount;
        }
        iClothLAmountNeeded = iConsumptionCount;
        if(iConsumptionCount > 0)
        { // since we knew the PC had enough components to attempt the
          // craft, assume we'll find them and remove them
            sMessage = "You have lost " + IntToString(iConsumptionCount)
                    + " " + ATS_GetMaterialName(iMaterialType) + " large cloth";
            if(iConsumptionCount > 1) sMessage += "s";
            sMessage += ".";

            SendMessageToPC(oPlayer, sMessage);
        }
        iConsumptionCount = 0;
        iConsumptionRisk = ATS_GetConsumptionRiskFromRecipe(sCraftTag, CINT_COMPONENT_ID_INGOTS, iMaterialType);
        for(i = 1; i <= iIngotAmountNeeded; ++i)
        {
            if(d100(1) <= iConsumptionRisk)
                ++iConsumptionCount;
        }
        iIngotAmountNeeded = iConsumptionCount;
        if(iConsumptionCount > 0)
        { // since we knew the PC had enough components to attempt the
          // craft, assume we'll find them and remove them
            sMessage = "You have lost " + IntToString(iConsumptionCount)
                    + " " + ATS_GetMaterialName(iMaterialType) + " ingot";
            if(iConsumptionCount > 1) sMessage += "s";
            sMessage += ".";

            SendMessageToPC(oPlayer, sMessage);
        }
        iConsumptionCount = 0;
        iConsumptionRisk = ATS_GetConsumptionRiskFromRecipe(sCraftTag, CINT_COMPONENT_ID_GEMS, iMaterialType);
        for(i = 1; i <= iGemAmountNeeded; ++i)
        {
            if(d100(1) <= iConsumptionRisk)
                ++iConsumptionCount;
        }
        iGemAmountNeeded = iConsumptionCount;
        if(iConsumptionCount > 0)
        { // since we knew the PC had enough components to attempt the
          // craft, assume we'll find them and remove them
            sMessage = "You have lost " + IntToString(iConsumptionCount)
                    + " " + GetName(GetObjectByTag(sGemTagNeeded));
            if(iConsumptionCount > 1) sMessage += "s";
            sMessage += ".";

            SendMessageToPC(oPlayer, sMessage);
        }
        iConsumptionCount = 0;
        iConsumptionRisk = ATS_GetConsumptionRiskFromRecipe(sCraftTag, CINT_COMPONENT_ID_IDEALGEMS, iMaterialType);
        for(i = 1; i <= iIdealGemAmountNeeded; ++i)
        {
            if(d100(1) <= iConsumptionRisk)
                ++iConsumptionCount;
        }
        iIdealGemAmountNeeded = iConsumptionCount;
        if(iConsumptionCount > 0)
        { // since we knew the PC had enough components to attempt the
          // craft, assume we'll find them and remove them
            sMessage = "You have lost " + IntToString(iConsumptionCount)
                    + " " + GetName(GetObjectByTag(sIdealGemTagNeeded));
            if(iConsumptionCount > 1) sMessage += "s";
            sMessage += ".";

            SendMessageToPC(oPlayer, sMessage);
        }
    }

    for(i = 1; i <= iCustomMaterialCount; ++i)
    {
        sCustomTagNeeded = ATS_GetComponentTagFromRecipe(sCraftTag, CINT_COMPONENT_ID_CUSTOM, i);
        iCustomAmountNeeded = ATS_GetComponentAmountFromRecipe(sCraftTag, CINT_COMPONENT_ID_CUSTOM, i);
        if(Remove == 2)
        { // remove only percentage of components based on risk%
            iConsumptionRisk = ATS_GetConsumptionRiskFromRecipe(sCraftTag, CINT_COMPONENT_ID_CUSTOM, i);
            iConsumptionCount = 0;
            for(count = 1; count <= iCustomAmountNeeded; ++count)
            {
                if(d100(1) <= iConsumptionRisk)
                    ++iConsumptionCount;
            }
            iCustomAmountNeeded = iConsumptionCount;
            if(iConsumptionCount > 0)
            { // since we knew the PC had enough components to attempt
              // the craft, assume we'll find them and remove them
                sMessage = "You have lost " + IntToString(iConsumptionCount)
                        + " " + GetName(GetObjectByTag(sCustomTagNeeded));
                if(iConsumptionCount > 1) sMessage += "s";
                sMessage += ".";

                SendMessageToPC(oPlayer, sMessage);
            }
        }

        SetLocalString(oPlayer, "ats_customneeded_" + IntToString(i) + "_tag", sCustomTagNeeded);
        SetLocalInt(oPlayer, "ats_customneeded_" + IntToString(i) + "_amount", iCustomAmountNeeded);
    }


    // Iterate through the specified player's
    // item repository
    object oItemOnPlayer = GetFirstItemInInventory(oPlayer);
    while ( oItemOnPlayer != OBJECT_INVALID )
    {
        // Check Dyes
        if(iDyeAmountNeeded > 0)
        {
            // At least one is needed, add tag to search string
            if ( BuildTags ) AllTags += sDyeTagNeeded;
            if ( GetTag(oItemOnPlayer) == sDyeTagNeeded )
            {

                iStackedQuantity = GetNumStackedItems(oItemOnPlayer);
                iRemainingQuantity = 0;
                if(iIngotAmountNeeded < iStackedQuantity)
                    iRemainingQuantity = iStackedQuantity - iDyeAmountNeeded;

                iDyeAmountNeeded -= iStackedQuantity;
                if(Remove)
                {
                    DestroyObject(oItemOnPlayer);
                    if(iRemainingQuantity > 0)
                        DelayCommand(0.5, ATS_CreateItemOnPlayer(sDyeTagNeeded, oPlayer, iRemainingQuantity));
                }
                if(iDyeAmountNeeded <= 0) RebuildTags = TRUE;
            }
        }

        // Check Flowers
        if(iFlowerAmountNeeded > 0)
        {
            // At least one is needed, add tag to search string
            if ( BuildTags ) AllTags += sFlowerTagNeeded;
            if ( GetTag(oItemOnPlayer) == sFlowerTagNeeded )
            {

                iStackedQuantity = GetNumStackedItems(oItemOnPlayer);
                iRemainingQuantity = 0;
                if(iIngotAmountNeeded < iStackedQuantity)
                    iRemainingQuantity = iStackedQuantity - iFlowerAmountNeeded;

                iFlowerAmountNeeded -= iStackedQuantity;
                if(Remove)
                {
                    DestroyObject(oItemOnPlayer);
                    if(iRemainingQuantity > 0)
                        DelayCommand(0.5, ATS_CreateItemOnPlayer(sFlowerTagNeeded, oPlayer, iRemainingQuantity));
                }
                if(iFlowerAmountNeeded <= 0) RebuildTags = TRUE;
            }
        }

        // Check Small Cloths
        if(iClothSAmountNeeded > 0)
        {
            // At least one is needed, add tag to search string
            if ( BuildTags ) AllTags += sClothSTagNeeded;
            if ( GetTag(oItemOnPlayer) == sClothSTagNeeded )
            {

                iStackedQuantity = GetNumStackedItems(oItemOnPlayer);
                iRemainingQuantity = 0;
                if(iClothSAmountNeeded < iStackedQuantity)
                    iRemainingQuantity = iStackedQuantity - iClothSAmountNeeded;

                iClothSAmountNeeded -= iStackedQuantity;
                if(Remove)
                {
                    DestroyObject(oItemOnPlayer);
                    if(iRemainingQuantity > 0)
                        DelayCommand(0.5, ATS_CreateItemOnPlayer(sClothSTagNeeded, oPlayer, iRemainingQuantity));
                }
                if(iClothSAmountNeeded <= 0) RebuildTags = TRUE;
            }
        }

        // Check Medium Cloths
        if(iClothMAmountNeeded > 0)
        {
            // At least one is needed, add tag to search string
            if ( BuildTags ) AllTags += sClothMTagNeeded;
            if ( GetTag(oItemOnPlayer) == sClothMTagNeeded )
            {

                iStackedQuantity = GetNumStackedItems(oItemOnPlayer);
                iRemainingQuantity = 0;
                if(iClothMAmountNeeded < iStackedQuantity)
                    iRemainingQuantity = iStackedQuantity - iClothMAmountNeeded;

                iClothMAmountNeeded -= iStackedQuantity;
                if(Remove)
                {
                    DestroyObject(oItemOnPlayer);
                    if(iRemainingQuantity > 0)
                        DelayCommand(0.5, ATS_CreateItemOnPlayer(sClothMTagNeeded, oPlayer, iRemainingQuantity));
                }
                if(iClothMAmountNeeded <= 0) RebuildTags = TRUE;
            }
        }

        // Check Large Cloths
        if(iClothLAmountNeeded > 0)
        {
            // At least one is needed, add tag to search string
            if ( BuildTags ) AllTags += sClothLTagNeeded;
            if ( GetTag(oItemOnPlayer) == sClothLTagNeeded )
            {

                iStackedQuantity = GetNumStackedItems(oItemOnPlayer);
                iRemainingQuantity = 0;
                if(iClothLAmountNeeded < iStackedQuantity)
                    iRemainingQuantity = iStackedQuantity - iClothLAmountNeeded;

                iClothLAmountNeeded -= iStackedQuantity;
                if(Remove)
                {
                    DestroyObject(oItemOnPlayer);
                    if(iRemainingQuantity > 0)
                        DelayCommand(0.5, ATS_CreateItemOnPlayer(sClothLTagNeeded, oPlayer, iRemainingQuantity));
                }
                if(iClothLAmountNeeded <= 0) RebuildTags = TRUE;
            }
        }

        // Check Ingots
        if(iIngotAmountNeeded > 0)
        {
            // At least one is needed, add tag to search string
            if ( BuildTags ) AllTags += sIngotTagNeeded;
            if ( GetTag(oItemOnPlayer) == sIngotTagNeeded )
            {

                iStackedQuantity = GetNumStackedItems(oItemOnPlayer);
                iRemainingQuantity = 0;
                if(iIngotAmountNeeded < iStackedQuantity)
                    iRemainingQuantity = iStackedQuantity - iIngotAmountNeeded;

                iIngotAmountNeeded -= iStackedQuantity;
                if(Remove)
                {
                    DestroyObject(oItemOnPlayer);
                    if(iRemainingQuantity > 0)
                        DelayCommand(0.5, ATS_CreateItemOnPlayer(sIngotTagNeeded, oPlayer, iRemainingQuantity));
                }
                if(iIngotAmountNeeded <= 0) RebuildTags = TRUE;
            }
        }

        //Check gems
        if(iGemAmountNeeded > 0)
        {
            // At least one is needed, add tag to search string
            if ( BuildTags ) AllTags += sGemTagNeeded;
            if ( GetTag(oItemOnPlayer) == sGemTagNeeded )
            {

                iStackedQuantity = GetNumStackedItems(oItemOnPlayer);
                iRemainingQuantity = 0;
                if(iGemAmountNeeded < iStackedQuantity)
                    iRemainingQuantity = iStackedQuantity - iGemAmountNeeded;

                iGemAmountNeeded -= iStackedQuantity;
                if(Remove)
                {
                    DestroyObject(oItemOnPlayer);
                    if(iRemainingQuantity > 0)
                        DelayCommand(0.5, ATS_CreateItemOnPlayer(sGemTagNeeded, oPlayer, iRemainingQuantity));
                }
                if(iGemAmountNeeded <= 0) RebuildTags = TRUE;
            }
        }

        //Check ideal gems
        if(iIdealGemAmountNeeded > 0)
        {
            // At least one is needed, add tag to search string
            if ( BuildTags ) AllTags += sIdealGemTagNeeded;
            if ( GetTag(oItemOnPlayer) == sIdealGemTagNeeded )
            {
                iStackedQuantity = GetNumStackedItems(oItemOnPlayer);
                iRemainingQuantity = 0;
                if(iIdealGemAmountNeeded < iStackedQuantity)
                    iRemainingQuantity = iStackedQuantity - iIdealGemAmountNeeded;

                iIdealGemAmountNeeded -= iStackedQuantity;
                if(Remove)
                {
                    DestroyObject(oItemOnPlayer);
                    if(iRemainingQuantity > 0)
                        DelayCommand(0.5, ATS_CreateItemOnPlayer(sIdealGemTagNeeded, oPlayer, iRemainingQuantity));
                }
                if(iIdealGemAmountNeeded <= 0) RebuildTags = TRUE;
            }
        }
        // Check custom materials
        for(i = 1; i <= iCustomMaterialCount; ++i)
        {
            iCustomAmountNeeded = GetLocalInt(oPlayer, "ats_customneeded_" + IntToString(i) + "_amount");

            if(iCustomAmountNeeded > 0)
            {
                sCustomTagNeeded = GetLocalString(oPlayer, "ats_customneeded_" + IntToString(i) + "_tag");
                sCustomBundleTagNeeded = GetStringLeft(sCustomTagNeeded, 11) + "B" +
                                       GetStringRight(sCustomTagNeeded, GetStringLength(sCustomTagNeeded) - 12);
                // At least one item of this type still needed, add
                // both bundle tag and item tag to search string
                if ( BuildTags ) AllTags += ( sCustomTagNeeded + sCustomBundleTagNeeded );
                sItemTag = GetTag(oItemOnPlayer);

                if(GetStringLeft(sItemTag, 16) == sCustomBundleTagNeeded)
                {
                    iBundleAmount = StringToInt(GetStringRight(sItemTag, GetStringLength(sItemTag) - 17));
                    iRemainingQuantity = 0;
                    if(iCustomAmountNeeded < iBundleAmount)
                        iRemainingQuantity = iBundleAmount - iCustomAmountNeeded;

                    iCustomAmountNeeded -= iBundleAmount;
                    if(iCustomAmountNeeded < 0)
                        iCustomAmountNeeded = 0;
                    SetLocalInt(oPlayer, "ats_customneeded_" + IntToString(i) + "_amount", iCustomAmountNeeded);

                    if(Remove)
                    {
                        DestroyObject(oItemOnPlayer);
                        for( i = 0; i < iRemainingQuantity; ++i)
                        {
                            ATS_CreateItemOnPlayer(ATS_GetResRefFromTag(sCustomTagNeeded), oPlayer);
                        }
                    }
                }
                else if (  sItemTag == sCustomTagNeeded )
                {
                    iStackedQuantity = GetNumStackedItems(oItemOnPlayer);
                    iRemainingQuantity = 0;

                    if(iCustomAmountNeeded < iStackedQuantity)
                        iRemainingQuantity = iStackedQuantity - iCustomAmountNeeded;

                    iCustomAmountNeeded -= iStackedQuantity;
                    if(iCustomAmountNeeded < 0)
                        iCustomAmountNeeded = 0;
                    SetLocalInt(oPlayer, "ats_customneeded_" + IntToString(i) + "_amount", iCustomAmountNeeded);

                    if(Remove)
                    {
                        DestroyObject(oItemOnPlayer);
                        if(iRemainingQuantity > 0)
                            DelayCommand(0.5, ATS_CreateItemOnPlayer(sCustomTagNeeded, oPlayer, iRemainingQuantity));
                    }
                }
                if(iCustomAmountNeeded <= 0) RebuildTags = TRUE; // found enough of this item
            }
        }
        BuildTags = FALSE; // Make sure it's only built once, unless an item is no longer needed
        if(AllTags == "") break; // No more items needed, so skip the rest of the inventory search
        do { // fast search inventory for next item that has a tag that matches one of the needed items
            oItemOnPlayer = GetNextItemInInventory(oPlayer);
        } while(GetIsObjectValid(oItemOnPlayer) &&
                FindSubString(AllTags,GetStringLeft(GetTag(oItemOnPlayer),16)) == -1);

        if(RebuildTags)
        { // an item is no longer needed, so rebuild the search string during the next pass
            BuildTags = TRUE;
            RebuildTags = FALSE;
            AllTags = "";
        }
    }

    if(iDyeAmountNeeded > 0)
        bFoundAllNeeded = FALSE;
    else if(iFlowerAmountNeeded > 0)
        bFoundAllNeeded = FALSE;
    else if(iClothSAmountNeeded > 0)
        bFoundAllNeeded = FALSE;
    else if(iClothMAmountNeeded > 0)
        bFoundAllNeeded = FALSE;
    else if(iClothLAmountNeeded > 0)
        bFoundAllNeeded = FALSE;
    else if(iIngotAmountNeeded > 0)
        bFoundAllNeeded = FALSE;
    else if(iGemAmountNeeded > 0)
        bFoundAllNeeded = FALSE;
    else if(iIdealGemAmountNeeded > 0)
        bFoundAllNeeded = FALSE;
    else
    {
        for(i = 1; i <= iCustomMaterialCount; ++i)
        {
            iCustomAmountNeeded = GetLocalInt(oPlayer, "ats_customneeded_" + IntToString(i) + "_amount");
            if(iCustomAmountNeeded > 0)
            {
                bFoundAllNeeded = FALSE;
                break;
            }
        }
    }
    return bFoundAllNeeded;
}

// wrapper for the function to only find the components, not remove them
int ATS_CheckCraftComponentsOnPlayer(object oPlayer, string sCraftTag, int iMaterialType)
{
    return ATS_FindComponents(oPlayer, sCraftTag, iMaterialType, FALSE);
}

// wrapper for the function to find AND remove the components
int ATS_RemoveCraftMaterials(object oPlayer, string sCraftTag, int iMaterialType)
{
    return ATS_FindComponents(oPlayer, sCraftTag, iMaterialType, TRUE);
}


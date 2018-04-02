//Dependencies: ats_inc_common, ats_inc_skill, ats_inc_material, ats_inc_cr_get,
//              ats_inc_menu, ats_inc_menu_mat

#include "ats_const_menu"

#include "ats_inc_common"
#include "ats_inc_skill"
#include "ats_inc_material"
#include "ats_inc_cr_get"
#include "ats_inc_menu"
#include "ats_inc_menu_mat"

/////////////////////////////////////////////////////
// ATS_CheckCraftMakeable                          //
//     Checks to see if a crafted item is craftable//
//     a player.  It returns the difficuly range   //
//     of the item or CINT_CRAFTLEVEL_NONE         //
//     if the player cannot make the item          //
// Returns: int  - difficuly range of the item     //
/////////////////////////////////////////////////////

int ATS_CheckCraftMakeable
(
object oPlayer,         // player to check against
string sCraftTag,       // craft tag of the item
string sCraftType,      // craft type of the item
int iMaterialType,      // material type of the item
)
{
    int iSkillLevel = 0;

    string sTradeskillName = ATS_GetTradeSkillFromCraftTag(sCraftTag);

    // gets the appropriate trade skill value of the player
    iSkillLevel = ATS_GetTradeskill(oPlayer, sTradeskillName);

    int iMinSkill = ATS_GetCraftMinSkill(sCraftTag) + ATS_GetMaterialMinBonus(iMaterialType);
    int iMaxSkill = ATS_GetCraftMaxSkill(sCraftTag) + ATS_GetMaterialMaxBonus(iMaterialType);


    int iThirdRange = (iMaxSkill - iMinSkill)/3;

    if( (iSkillLevel < (iMinSkill + iThirdRange)) &&
         (iSkillLevel >= iMinSkill) )
            return CINT_CRAFTLEVEL_HARD;
    else if( (iSkillLevel < (iMaxSkill - iThirdRange)) &&
            (iSkillLevel >= (iMinSkill + iThirdRange)) )
            return CINT_CRAFTLEVEL_MEDIUM;

    else if( (iSkillLevel >= (iMaxSkill - iThirdRange)) &&
            (iSkillLevel < iMaxSkill) )
            return CINT_CRAFTLEVEL_EASY;

    else if( iSkillLevel >= iMaxSkill )
            return CINT_CRAFTLEVEL_TRIVIAL;

    else
        return CINT_CRAFTLEVEL_NONE;

}
/////////////////////////////////////////////////////
// ATS_CheckCraftItemExistence                     //
//     Checks to see if a crafted item exists by   //
//     checking it's tag with items in the game    //
//     If none are found, then it uses             //
//     CreateItemOnObject to see if the item is    //
//     valid                                       //
// Returns: int(boolean) - TRUE if the item exists //
//                         FALSE if not            //
/////////////////////////////////////////////////////
int ATS_CheckCraftItemExistence
(
string sCraftTag,   // Craft tag of the item being crafted
int iQuality,       // The quality of the item
int iMaterialType,   // The material type of the item
int bIsSingleType = FALSE
)
{
    string sItemTag;

    if(bIsSingleType == TRUE)
        sItemTag = ATS_GetCraftSingleTypeTag(sCraftTag);
    else
    {
        sItemTag = GetStringLeft(sCraftTag, 10);

        // Adds the quality to the tag
        if(iQuality == CINT_QUALITY_NORMAL)
            sItemTag += "_N_";
        else if(iQuality == CINT_QUALITY_EXCEPTIONAL)
            sItemTag += "_E_";
        else
            return FALSE;

        // Adds the material type to the tag
        sItemTag += ATS_GetMaterialTag(iMaterialType);
    }
    sItemTag = GetStringUpperCase(sItemTag);
    // Finds an item with the same tag
    if(GetIsObjectValid(GetObjectByTag(sItemTag)) == TRUE)
        return TRUE;

    if(GetLocalString(GetModule(), sItemTag) != "")
    {
        sItemTag = GetLocalString(GetModule(), sItemTag);
        if(GetIsObjectValid(GetObjectByTag(sItemTag)) == TRUE)
            return TRUE;
    }
    string sItemResRef = ATS_GetResRefFromTag(sItemTag);
    // If none is found, create an item in the reserved chest for future
    // reference and to check it the item exists to make
    object oCreatedItem = CreateItemOnObject(sItemResRef, GetObjectByTag("ATS_CHEST_RESERVED"));
    if(oCreatedItem != OBJECT_INVALID)
    {
        if(GetTag(oCreatedItem) != sItemTag)
            SetLocalString(GetModule(), sItemTag, GetTag(oCreatedItem));
        return TRUE;
    }
    else
        return FALSE;
}
int ATS_CheckIsCraftableByDifficulty(object oPlayer, string sCraftTag)
{
   int iIsCraftableDifficulty = FALSE;
   int iDifficultyResult;
   string sCraftType = ATS_GetCurrentCraftType(oPlayer);
   int iCraftPart = ATS_GetCurrentCraftPart(oPlayer);

   if(ATS_IsCraftSingleType(sCraftTag) == TRUE)
    {
        if( ATS_CheckCraftItemExistence(sCraftTag, CINT_QUALITY_NORMAL, 0, TRUE) == TRUE)
                iIsCraftableDifficulty = ATS_CheckCraftMakeable(oPlayer, sCraftTag, sCraftType, 0);
    }

    else if(sCraftType == ATS_CRAFT_TYPE_ARMOR || sCraftType == ATS_CRAFT_TYPE_WEAPON)
    {
        int i;
        for(i = CINT_MATERIAL_COPPER; i <= CINT_MATERIAL_MYRKANDITE; ++i)
        {
            if( ATS_CheckCraftItemExistence(sCraftTag, CINT_QUALITY_NORMAL, i) == TRUE)
            {
                iDifficultyResult = ATS_CheckCraftMakeable(oPlayer, sCraftTag, sCraftType, i);
                if(iDifficultyResult > iIsCraftableDifficulty)
                    iIsCraftableDifficulty = iDifficultyResult;
            }
        }
    }
    else if(sCraftType == ATS_CRAFT_TYPE_JEWELCRAFT)
    {
        int i;
        for(i = CINT_MATERIAL_MALACHITE; i <= CINT_MATERIAL_DIAMOND; ++i)
        {
            if( ATS_CheckCraftItemExistence(sCraftTag, CINT_QUALITY_NORMAL, i) == TRUE)
            {
                iDifficultyResult = ATS_CheckCraftMakeable(oPlayer, sCraftTag, sCraftType, i);
                if(iDifficultyResult > iIsCraftableDifficulty)
                    iIsCraftableDifficulty = iDifficultyResult;
            }
        }
    }
    else
    {
        int i;
        for(i = 1; i < CINT_MATERIAL_COUNT; ++i)
        {
            if( ATS_CheckCraftItemExistence(sCraftTag, CINT_QUALITY_NORMAL, i) == TRUE)
            {
                iDifficultyResult = ATS_CheckCraftMakeable(oPlayer, sCraftTag, sCraftType, i);
                if(iDifficultyResult > iIsCraftableDifficulty)
                    iIsCraftableDifficulty = iDifficultyResult;
            }
        }


    }
    return iIsCraftableDifficulty;
}


/////////////////////////////////////////////////////
// ATS_BuildNextCraftTag                           //
//      Fetches the next craft tag to display      //
//      from the array of possible tags.           //
// Returns: string - current craft tag             //
/////////////////////////////////////////////////////
string ATS_BuildNextCraftTag(object oPlayer)
{
    string sCurrentCraftType = ATS_GetCurrentCraftType(oPlayer);
    int iCurrentCraftPart = ATS_GetCurrentCraftPart(oPlayer);
    int iArrayIndex = ATS_GetCraftArrayIndex(oPlayer) + 1;

    // Get the size of the craft tag array
    int iArraySize = ATS_GetCraftArraySize(sCurrentCraftType, iCurrentCraftPart);
    if(iArrayIndex > iArraySize)
        return "";

    ATS_SetCraftArrayIndex(oPlayer, iArrayIndex);
    string sCurrentCraftTag = ATS_GetCraftTagFromArray(sCurrentCraftType, iCurrentCraftPart, iArrayIndex);

    return sCurrentCraftTag;
}

/////////////////////////////////////////////////////
// ATS_BuildCurrentCraftTag                        //
//      Fetches the current craft tag to display   //
//      from the array of possible tags.           //
// Returns: string - current craft tag             //
/////////////////////////////////////////////////////
string ATS_BuildCurrentCraftTag(object oPlayer)
{
    string sCurrentCraftType = ATS_GetCurrentCraftType(oPlayer);
    int iCurrentCraftPart = ATS_GetCurrentCraftPart(oPlayer);
    int iArrayIndex = ATS_GetCraftArrayIndex(oPlayer);

    // Get the size of the craft tag array
    int iArraySize = ATS_GetCraftArraySize(sCurrentCraftType, iCurrentCraftPart);
    if(iArrayIndex > iArraySize)
        return "";

    string sCurrentCraftTag = ATS_GetCraftTagFromArray(sCurrentCraftType, iCurrentCraftPart, iArrayIndex);
    return sCurrentCraftTag;
}

int ATS_CheckNextItemToDisplay(object oPlayer)
{
    int iDisplayCount = ATS_GetDisplayCount(oPlayer);
    string sCraftType = ATS_GetCurrentCraftType(oPlayer);
    int iCraftPart = ATS_GetCurrentCraftPart(oPlayer);
    int iRacialCount;
    int iClassCount;
    int iAlignmentGoodEvil;
    int iAlignmentLawChaos;
    int i;
    string sCraftTag;
    int bRestrictRace = FALSE;
    int bRestrictClass = FALSE;
    int bRestrictAlignment1 = FALSE;
    int bRestrictAlignment2 = FALSE;

    int iCraftDifficulty;
    int iCurrentDifficulty = 4 - (iDisplayCount % 4);
    if(iCurrentDifficulty == 4)
    {
        SetLocalInt(oPlayer, "ats_current_craftlevel", CINT_CRAFTLEVEL_NONE);
    }

    int iTokenIndex = CINT_CUSTOM_TOKEN_CRAFT_START + (iDisplayCount / 4) + 1;

    int iFoundItem = FALSE;

    if(GetLocalInt(oPlayer, "ats_current_craftlevel") == CINT_CRAFTLEVEL_NONE)
    {
        sCraftTag = ATS_BuildNextCraftTag(oPlayer);
        while(sCraftTag != CSTR_INVALD_CRAFT_TAG)
        {
            //Check alignment
            iAlignmentGoodEvil = GetAlignmentGoodEvil(oPlayer);
            if(iAlignmentGoodEvil == ALIGNMENT_GOOD)
                bRestrictAlignment1 = !(ATS_GetAlignmentGood(sCraftTag));
            else if(iAlignmentGoodEvil == ALIGNMENT_EVIL)
                bRestrictAlignment1 = !(ATS_GetAlignmentEvil(sCraftTag));

            iAlignmentLawChaos = GetAlignmentLawChaos(oPlayer);
            if(iAlignmentLawChaos == ALIGNMENT_LAWFUL)
                bRestrictAlignment2 = !(ATS_GetAlignmentLawful(sCraftTag));
            else if(iAlignmentLawChaos == ALIGNMENT_NEUTRAL)
                bRestrictAlignment2 = !(ATS_GetAlignmentNeutral(sCraftTag));
            else if(iAlignmentLawChaos == ALIGNMENT_CHAOTIC)
                bRestrictAlignment2 = !(ATS_GetAlignmentChaotic(sCraftTag));

            //Check racial restriction of player
            iRacialCount = ATS_GetRacialRestrictionCount(sCraftTag);
            if(iRacialCount == 0)
                bRestrictRace = FALSE;
            else
                bRestrictRace = TRUE;
            for(i = 0; i < iRacialCount; ++i)
            {
                if(GetRacialType(oPlayer) == ATS_GetRacialRestriction(sCraftTag, i))
                    bRestrictRace = FALSE;
            }
            // Check class restrictions
            iClassCount = ATS_GetClassRestrictionCount(sCraftTag);
            if(iClassCount == 0)
                bRestrictClass = FALSE;
            else
                bRestrictClass = TRUE;
            for(i = 0; i < iClassCount; ++i)
            {
                if(GetClassByPosition(1, oPlayer) == ATS_GetClassRestriction(sCraftTag, i))
                {
                    bRestrictClass = FALSE;
                    break;
                }
                else if(GetClassByPosition(2, oPlayer) == ATS_GetClassRestriction(sCraftTag, i))
                {
                    bRestrictClass = FALSE;
                    break;
                }
                else if(GetClassByPosition(3, oPlayer) == ATS_GetClassRestriction(sCraftTag, i))
                {
                    bRestrictClass = FALSE;
                    break;
                }
            }

            if( bRestrictRace == FALSE && bRestrictClass == FALSE && bRestrictAlignment1 == FALSE
                && bRestrictAlignment2 == FALSE)
            {
                iCraftDifficulty = ATS_CheckIsCraftableByDifficulty(oPlayer, sCraftTag);
                if(iCraftDifficulty != CINT_CRAFTLEVEL_NONE)
                {
                    SetLocalInt(oPlayer, "ats_current_craftlevel", iCraftDifficulty);
                    iFoundItem == TRUE;
                    ATS_IncrementMakeableCount(oPlayer);
                    break;
                }

            }
            sCraftTag = ATS_BuildNextCraftTag(oPlayer);
        }
    }

    ATS_IncrementDisplayCount(oPlayer);
    if(GetLocalInt(oPlayer, "ats_current_craftlevel") == iCurrentDifficulty)
    {
        sCraftTag = ATS_BuildCurrentCraftTag(oPlayer);
        ATS_AddToCraftItemDisplayList(oPlayer, sCraftTag);
        SetCustomToken(iTokenIndex, ATS_GetCraftName(sCraftTag));
        return TRUE;
    }
    return FALSE;
}
/////////////////////////////////////////////////////
// ATS_GetNextMaterialIndex                        //
//      Fetches the next material index to display //
//      from the list of possible materials.       //
// Returns: int - current material index           //
/////////////////////////////////////////////////////
int ATS_GetNextMaterialIndex(object oPlayer)
{
    int iArrayIndex = ATS_GetMaterialArrayIndex(oPlayer) + 1;

    // Get the total amount of material types
    int iArraySize = ATS_GetMaterialArraySize(oPlayer);
    if(iArrayIndex > iArraySize)
        return 0;

    ATS_SetMaterialArrayIndex(oPlayer, iArrayIndex);

    return iArrayIndex;
}

/////////////////////////////////////////////////////
// ATS_GetCurrentMaterialIndex                    //
//      Fetches the current material index to      //
//      display from the list of possible materials//
// Returns: int - current material index           //
/////////////////////////////////////////////////////
int ATS_GetCurrentMaterialIndex(object oPlayer)
{
    int iArrayIndex = ATS_GetMaterialArrayIndex(oPlayer);

    // Get the total amount of material types
    int iArraySize = ATS_GetMaterialArraySize(oPlayer);
    if(iArrayIndex > iArraySize)
        return 0;

    return iArrayIndex;
}

int ATS_CheckNextMaterialToDisplay(object oPlayer)
{
    int iDisplayCount = ATS_GetDisplayCount(oPlayer);
    string sCraftType = ATS_GetCurrentCraftType(oPlayer);
    int iCraftPart = ATS_GetCurrentCraftPart(oPlayer);
    string  sCraftTag = ATS_GetCurrentCraftTag(oPlayer);
    int iMaterialType;

    int iCraftDifficulty;
    int iCurrentDifficulty = 4 - (iDisplayCount % 4);
    if(iCurrentDifficulty == 4)
    {
        SetLocalInt(oPlayer, "ats_current_craftlevel", CINT_CRAFTLEVEL_NONE);
    }

    int iTokenIndex = CINT_CUSTOM_TOKEN_MATERIAL_START + (iDisplayCount / 4) + 1;

    int iFoundItem = FALSE;

    if(GetLocalInt(oPlayer, "ats_current_craftlevel") == CINT_CRAFTLEVEL_NONE)
    {
        iMaterialType = ATS_GetMaterialArray(oPlayer, ATS_GetNextMaterialIndex(oPlayer));
        while(iMaterialType != 0)
        {
            iCraftDifficulty = ATS_CheckCraftMakeable(oPlayer, sCraftTag, sCraftType, iMaterialType);
            if(iCraftDifficulty != CINT_CRAFTLEVEL_NONE)
            {
                SetLocalInt(oPlayer, "ats_current_craftlevel", iCraftDifficulty);
                iFoundItem == TRUE;
                ATS_IncrementMaterialMakeableCount(oPlayer);
                break;
            }

            iMaterialType = ATS_GetMaterialArray(oPlayer, ATS_GetNextMaterialIndex(oPlayer));
        }
    }

    ATS_IncrementDisplayCount(oPlayer);
    if(GetLocalInt(oPlayer, "ats_current_craftlevel") == iCurrentDifficulty)
    {
        iMaterialType = ATS_GetMaterialArray(oPlayer, ATS_GetCurrentMaterialIndex(oPlayer));
        ATS_AddToMaterialDisplayList(oPlayer, iMaterialType);
        SetCustomToken(iTokenIndex, ATS_CapitalizeString(ATS_GetMaterialName(iMaterialType)));
        return TRUE;
    }
    return FALSE;
}
/////////////////////////////////////////////////////
// ATS_BuildMaterialList                           //
//      Cycles through all the material types      //
//      and creates a list of materials that an    //
//      item is made of.                           //
// Returns: none                                   //
/////////////////////////////////////////////////////
void ATS_BuildMaterialList(object oPlayer)  // player doing the crafting
{
    string sCraftTag = ATS_GetCurrentCraftTag(oPlayer);

    int i;

    ATS_ResetMaterialArray(oPlayer);

    // cycle through all materials
    for(i = 1; i <= CINT_MATERIAL_COUNT; ++i)
    {
        // if the item blueprint exists for the normal quality
        if(ATS_CheckCraftItemExistence(sCraftTag, CINT_QUALITY_NORMAL, i) == TRUE)
            {
                // add the material type to the array
                ATS_AddMaterialToArray(oPlayer, i);
            }
    }

}


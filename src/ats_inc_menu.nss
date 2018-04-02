/****************************************************
  Crafting Menu Script
  ats_inc_menu

  Last Updated: August 5, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script contains all accesssor functions related
  to setting up the crafting menus.
**************************************************/

/////////////////////////////////////////////////////
// ATS_SetCurrentCraftType                         //
//      Sets a variable on a player which holds the//
//      current craft item's type for use in the   //
//      crafting conversation files                //
// Returns: none                                   //
/////////////////////////////////////////////////////
void ATS_SetCurrentCraftType
(
object oPlayer,     // player doing the crafting
string sCraftType   // craft type constant
)
{
    SetLocalString(oPlayer, "ats_current_craft_type", sCraftType);
}
/////////////////////////////////////////////////////
// ATS_SetTokenOffset                              //
//      Sets a variable on the player that holds   //
//      a token offset for use with custom tokens  //
//      to minimize collisions.                    //
// Returns: none                                   //
/////////////////////////////////////////////////////
void ATS_SetTokenOffset
(
object oPlayer,       // player doing crafting
int iTokenOffset      // custom token offset value
)
{
    SetLocalInt(oPlayer, "ats_token_offset", iTokenOffset);
}

/////////////////////////////////////////////////////
// ATS_GetTokenOffset                              //
//      Gets a variable on the player that holds   //
//      a token offset for use with custom tokens  //
//      to minimize collisions.                    //
// Returns: int - token offset value               //
/////////////////////////////////////////////////////
int ATS_GetTokenOffset(object oPlayer)
{
    return GetLocalInt(oPlayer, "ats_token_offset");
}

/////////////////////////////////////////////////////
// ATS_GetCurrentCraftType                         //
//      Returns the current craft type of the item //
//      the player is crafting                     //
// Returns: string - craft type constant           //
/////////////////////////////////////////////////////
string ATS_GetCurrentCraftType(object oPlayer)
{
    return GetLocalString(oPlayer, "ats_current_craft_type");
}

/////////////////////////////////////////////////////
// ATS_SetCurrentCraftPart                         //
//      Sets a variable on a player which holds the//
//      current craft item's part for use in the   //
//      crafting conversation files                //
// Returns: none                                   //
/////////////////////////////////////////////////////
void ATS_SetCurrentCraftPart
(
object oPlayer, // player doing the crafting
int iCraftPart  // craft part constant
)
{
    SetLocalInt(oPlayer, "ats_current_craft_part", iCraftPart);
}

/////////////////////////////////////////////////////
// ATS_GetCurrentCraftPart                         //
//      Returns the current craft part of the item //
//      the player is crafting                     //
// Returns: int - craft part constant              //
/////////////////////////////////////////////////////
int ATS_GetCurrentCraftPart(object oPlayer)
{
    return GetLocalInt(oPlayer, "ats_current_craft_part");
}

/////////////////////////////////////////////////////
// ATS_SetCurrentCraftTag                          //
//      Sets a variable on a player which holds the//
//      current craft item's tag for use in the    //
//      crafting conversation files                //
// Returns: none                                   //
/////////////////////////////////////////////////////
void ATS_SetCurrentCraftTag
(
object oPlayer,     // player doing the crafting
string sCraftTag    // craft tag string
)
{
    SetLocalString(oPlayer, "ats_current_craft_tag", sCraftTag);
}

/////////////////////////////////////////////////////
// ATS_GetCurrentCraftTag                          //
//      Returns the current craft tag of the item  //
//      the player is crafting                     //
// Returns: string - craft tag                     //
/////////////////////////////////////////////////////
string ATS_GetCurrentCraftTag(object oPlayer)
{
    return GetLocalString(oPlayer, "ats_current_craft_tag");
}

/////////////////////////////////////////////////////
// ATS_SetCurrentCraftMaterial                     //
//      Sets a variable on a player which holds the//
//      current craft item's material type for use //
//      in the crafting conversation files         //
// Returns: none                                   //
/////////////////////////////////////////////////////
void ATS_SetCurrentCraftMaterial
(
object oPlayer,         // player doing the crafting
int iCraftMaterial      // material type constant
)
{
    SetLocalInt(oPlayer, "ats_current_craft_material", iCraftMaterial);
}

/////////////////////////////////////////////////////
// ATS_GetCurrentCraftMaterial                     //
//      Returns the current craft material type of //
//      the item that the player is crafting       //
// Returns: int - craft matertial type constant    //
/////////////////////////////////////////////////////
int ATS_GetCurrentCraftMaterial(object oPlayer)
{
    return GetLocalInt(oPlayer, "ats_current_craft_material");
}

/////////////////////////////////////////////////////
// ATS_InitDisplayCount                            //
//      Sets the display count for the crafting    //
//      conversation file to zero                  //
// Returns: none                                   //
/////////////////////////////////////////////////////
void ATS_InitDisplayCount(object oPlayer)   // player doing the crafting
{
    SetLocalInt(oPlayer, "ats_current_craft_displaycount", 0);
}

/////////////////////////////////////////////////////
// ATS_GetDisplayCount                             //
//      Gets the current display count for use in  //
//      the crafting conversation file             //
// Returns: int - display count                    //
/////////////////////////////////////////////////////
int ATS_GetDisplayCount(object oPlayer)     // player doing the crafting
{

    return GetLocalInt(oPlayer, "ats_current_craft_displaycount");
}


/////////////////////////////////////////////////////
// ATS_IncrementDisplayCount                       //
//      Increments the display count for use in the//
//      crafting conversation file                 //
// Returns: none                                   //
/////////////////////////////////////////////////////
void ATS_IncrementDisplayCount(object oPlayer)  // player doing the crafting
{
    SetLocalInt(oPlayer, "ats_current_craft_displaycount", ATS_GetDisplayCount(oPlayer) + 1);
}

/////////////////////////////////////////////////////
// ATS_InitMakeableCount                           //
//      Sets the makeable count for the crafting   //
//      conversation file to zero                  //
// Returns: none                                   //
/////////////////////////////////////////////////////
void ATS_InitMakeableCount(object oPlayer)   // player doing the crafting
{
    SetLocalInt(oPlayer, "ats_current_craft_makeablecount", 0);
}

/////////////////////////////////////////////////////
// ATS_GetMakeableCount                            //
//      Gets the current makeable count for use in//
//      the crafting conversation file             //
// Returns: int - display count                    //
/////////////////////////////////////////////////////
int ATS_GetMakeableCount(object oPlayer)     // player doing the crafting
{

    return GetLocalInt(oPlayer, "ats_current_craft_makeablecount");
}
/////////////////////////////////////////////////////
// ATS_SetMakeableCount                            //
//      Sets the current makeable count for use in//
//      the crafting conversation file             //
// Returns: none                                   //
/////////////////////////////////////////////////////
void  ATS_SetMakeableCount
(
object oPlayer,     // player doing the crafting
int iMakeableCount  // number of items that can be made
)
{
    SetLocalInt(oPlayer, "ats_current_craft_makeablecount", iMakeableCount);
}
/////////////////////////////////////////////////////
// ATS_IncrementMakeableCount                      //
//      Increments the makeable count for use in   //
//      the crafting conversation file             //
// Returns: none                                   //
/////////////////////////////////////////////////////
void ATS_IncrementMakeableCount(object oPlayer)  // player doing the crafting
{
    SetLocalInt(oPlayer, "ats_current_craft_makeablecount", ATS_GetMakeableCount(oPlayer) + 1);
}

/////////////////////////////////////////////////////
// ATS_InitCraftArrayIndex                         //
//      Sets the array index for the recipe lookup //
//      table to zero                              //
// Returns: none                                   //
/////////////////////////////////////////////////////
void ATS_InitCraftArrayIndex(object oPlayer)   // player doing the crafting
{
    SetLocalInt(oPlayer, "ats_current_craft_arrayindex", 0);
}

/////////////////////////////////////////////////////
// ATS_GetCraftArrayIndex                          //
//      Gets the array index for the recipe lookup //
//      table                                      //
// Returns: int - display count                    //
/////////////////////////////////////////////////////
int ATS_GetCraftArrayIndex(object oPlayer)     // player doing the crafting
{

    return GetLocalInt(oPlayer, "ats_current_craft_arrayindex");
}


/////////////////////////////////////////////////////
// ATS_SetCraftArrayIndex                          //
//      Sets the array index for the recipe lookup //
//      table                                      //
// Returns: none                                   //
/////////////////////////////////////////////////////
void ATS_SetCraftArrayIndex(object oPlayer, int iValue)  // player doing the crafting
{
    SetLocalInt(oPlayer, "ats_current_craft_arrayindex", iValue);
}

/////////////////////////////////////////////////////
// ATS_GetCraftItemDisplayListSize                 //
//      Returns the size of the display list of    //
//      craftable items for a player                //
// Returns: int - size of display list             //
/////////////////////////////////////////////////////
int ATS_GetCraftItemDisplayListSize(object oPlayer)
{
    return GetLocalInt(oPlayer, "ats_craftdisplaylist_size");
}

/////////////////////////////////////////////////////
// ATS_GetCraftItemFromDisplayList                 //
//     Returns the craft item's base tag from the  //
//     list of items to display                    //
// Returns: string - base tag of item selected     //
/////////////////////////////////////////////////////
string ATS_GetCraftItemFromDisplayList
(
object oPlayer,   // player that is crafting
int iIndex        // index into the list
)
{
    return GetLocalString(oPlayer, "ats_craftdisplaylist_" + IntToString(iIndex));
}

/////////////////////////////////////////////////////
// ATS_ResetCraftItemDisplayList                   //
//     Clears the craft item display list and sets //
//     its size to zero                            //
// Returns: void                                   //
/////////////////////////////////////////////////////
void ATS_ResetCraftItemDisplayList(object oPlayer)
{
    int iListSize = ATS_GetCraftItemDisplayListSize(oPlayer);
    int i;

    for(i = 1; i <= iListSize; ++i)
    {
        DeleteLocalString(oPlayer, "ats_craftdisplaylist_" + IntToString(iListSize));
    }

    SetLocalInt(oPlayer, "ats_craftdisplaylist_size", 0);
}

/////////////////////////////////////////////////////
// ATS_AddToCraftItemDisplayList                   //
//     Adds an item's base craft tag to the display//
//     list of craft items for a player            //
// Returns: void                                   //
/////////////////////////////////////////////////////
void ATS_AddToCraftItemDisplayList
(
object oPlayer,     // player doing the crafting
string sCraftTag   // craft tag constant to add
)
{
    int iListSize =  ATS_GetCraftItemDisplayListSize(oPlayer);
    ++iListSize;
    SetLocalInt(oPlayer, "ats_craftdisplaylist_size", iListSize);

    SetLocalString(oPlayer, "ats_craftdisplaylist_" + IntToString(iListSize), sCraftTag);
}


/////////////////////////////////////////////////////
// ATS_GetCraftTagFromArray                        //
//      Returns the craft tag from an array of tags//
// Returns: string - craft tag                     //
/////////////////////////////////////////////////////
string ATS_GetCraftTagFromArray
(
string sCraftType, // craft type
int iCraftPart,    // craft part
int iArrayIndex    // index to get
)
{

    string sCraftArrayName = "ATS_RA_" + sCraftType + IntToString(iCraftPart) + "_";
    return GetLocalString(GetModule(), sCraftArrayName + IntToString(iArrayIndex));
}

/////////////////////////////////////////////////////
// ATS_GetCraftArraySize                           //
//      Returns the size of the craft tag array    //
// Returns: int - array size                       //
///////////////////////////////////////////////////
int ATS_GetCraftArraySize
(
string sCraftType,  // the craft type
int iCraftPart      // the craft part
)
{
    string sCraftArrayName = "ATS_RA_" + sCraftType + IntToString(iCraftPart) + "_";
    return GetLocalInt(GetModule(), sCraftArrayName + "Count");
}






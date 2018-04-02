/////////////////////////////////////////////////////
// ATS_InitMaterialMakeableCount                   //
//      Sets the makeable count for the crafting   //
//      conversation file to zero                  //
// Returns: none                                   //
/////////////////////////////////////////////////////
void ATS_InitMaterialMakeableCount(object oPlayer)   // player doing the crafting
{
    SetLocalInt(oPlayer, "ats_current_craftmat_makeablecount", 0);
}

/////////////////////////////////////////////////////
// ATS_GetMaterialMakeableCount                    //
//      Gets the current makeable count for use in //
//      the crafting conversation file             //
// Returns: int - display count                    //
/////////////////////////////////////////////////////
int ATS_GetMaterialMakeableCount(object oPlayer)     // player doing the crafting
{

    return GetLocalInt(oPlayer, "ats_current_craftmat_makeablecount");
}
/////////////////////////////////////////////////////
// ATS_SetMaterialMakeableCount                    //
//      Sets the current makeable count for use in//
//      the crafting conversation file             //
// Returns: none                                   //
/////////////////////////////////////////////////////
void  ATS_SetMaterialMakeableCount
(
object oPlayer,     // player doing the crafting
int iMakeableCount  // number of items that can be made
)
{
    SetLocalInt(oPlayer, "ats_current_craftmat_makeablecount", iMakeableCount);
}
/////////////////////////////////////////////////////
// ATS_IncrementMaterialMakeableCount              //
//      Increments the makeable count for use in   //
//      the crafting conversation file             //
// Returns: none                                   //
/////////////////////////////////////////////////////
void ATS_IncrementMaterialMakeableCount(object oPlayer)  // player doing the crafting
{
    SetLocalInt(oPlayer, "ats_current_craftmat_makeablecount", ATS_GetMaterialMakeableCount(oPlayer) + 1);
}

/////////////////////////////////////////////////////
// ATS_InitMaterialArrayIndex                      //
//      Sets the array index for the material list //
//      to zero                                    //
// Returns: none                                   //
/////////////////////////////////////////////////////
void ATS_InitMaterialArrayIndex(object oPlayer)   // player doing the crafting
{
    SetLocalInt(oPlayer, "ats_current_craftmat_arrayindex", 0);
}

/////////////////////////////////////////////////////
// ATS_GetCraftArrayIndex                          //
//      Gets the array index for the material list //
// Returns: int - display count                    //
/////////////////////////////////////////////////////
int ATS_GetMaterialArrayIndex(object oPlayer)     // player doing the crafting
{

    return GetLocalInt(oPlayer, "ats_current_craftmat_arrayindex");
}


/////////////////////////////////////////////////////
// ATS_SetMaterialArrayIndex                       //
//      Sets the array index for the material list //
// Returns: none                                   //
/////////////////////////////////////////////////////
void ATS_SetMaterialArrayIndex(object oPlayer, int iValue)  // player doing the crafting
{
    SetLocalInt(oPlayer, "ats_current_craftmat_arrayindex", iValue);
}

/////////////////////////////////////////////////////
// ATS_GetMaterialArraySize                        //
//      Gets a material from the material array    //
// Returns: int - material type                    //
/////////////////////////////////////////////////////
int ATS_GetMaterialArraySize(object oPlayer)
{
    return GetLocalInt(oPlayer, "ats_current_craftmat_arraysize");
}

/////////////////////////////////////////////////////
// ATS_SetMaterialArray                            //
//      Sets the material in the material array    //
// Returns: none                                   //
/////////////////////////////////////////////////////
void ATS_SetMaterialArray(object oPlayer, int iArrayIndex, int iMaterialType)
{
    SetLocalInt(oPlayer, "ats_current_craftmat_array_" + IntToString(iArrayIndex), iMaterialType);
}

/////////////////////////////////////////////////////
// ATS_GetMaterialArray                            //
//      Gets a material from the material array    //
// Returns: int - material type                    //
/////////////////////////////////////////////////////
int ATS_GetMaterialArray(object oPlayer, int iArrayIndex)
{
    return GetLocalInt(oPlayer, "ats_current_craftmat_array_" + IntToString(iArrayIndex));
}
/////////////////////////////////////////////////////
// ATS_AddMaterialToArray                          //
//      Adds a material to the material array     //
// Returns: none                                   //
/////////////////////////////////////////////////////
void ATS_AddMaterialToArray(object oPlayer, int iMaterialType)
{
    int iArraySize =  ATS_GetMaterialArraySize(oPlayer);
    ++iArraySize;
    SetLocalInt(oPlayer, "ats_current_craftmat_arraysize", iArraySize);
    ATS_SetMaterialArray(oPlayer, iArraySize, iMaterialType);
}
/////////////////////////////////////////////////////
// ATS_ResetMaterialArray                          //
//     Clears the material array and sets          //
//     its size to zero                            //
// Returns: void                                   //
/////////////////////////////////////////////////////
void ATS_ResetMaterialArray(object oPlayer)
{
    int iArraySize = ATS_GetMaterialArraySize(oPlayer);
    int i;

    for(i = 1; i <= iArraySize; ++i)
    {
        DeleteLocalInt(oPlayer, "ats_current_craftmat_array_" + IntToString(iArraySize));
    }

    SetLocalInt(oPlayer, "ats_current_craftmat_arraysize", 0);
}
/////////////////////////////////////////////////////
// ATS_GetMaterialDisplayListSize                  //
//      Returns the size of the display list of    //
//      material types for a player                //
// Returns: int - size of display list             //
/////////////////////////////////////////////////////
int ATS_GetMaterialDisplayListSize(object oPlayer)
{
    return GetLocalInt(oPlayer, "ats_matdisplaylist_size");
}

/////////////////////////////////////////////////////
// ATS_GetMaterialFromDisplayList                  //
//     Returns the material constant from the list //
//     of materials to display                     //
// Returns: int - material type constant           //
/////////////////////////////////////////////////////
int ATS_GetMaterialFromDisplayList
(
object oPlayer,   // player that is crafting
int iIndex        // index into the list
)
{
    return GetLocalInt(oPlayer, "ats_matdisplaylist_" + IntToString(iIndex));
}

/////////////////////////////////////////////////////
// ATS_ResetMaterialDisplayList                    //
//     Clears the material display list and sets   //
//     its size to zero                            //
// Returns: void                                   //
/////////////////////////////////////////////////////
void ATS_ResetMaterialDisplayList(object oPlayer)
{
    int iListSize = ATS_GetMaterialDisplayListSize(oPlayer);
    int i;

    for(i = 1; i <= iListSize; ++i)
    {
        DeleteLocalInt(oPlayer, "ats_matdisplaylist_" + IntToString(iListSize));
    }

    SetLocalInt(oPlayer, "ats_matdisplaylist_size", 0);
}

/////////////////////////////////////////////////////
// ATS_AddToMaterialDisplayList                    //
//     Adds a material type constant to the display//
//     list of materials                           //
// Returns: void                                   //
/////////////////////////////////////////////////////
void ATS_AddToMaterialDisplayList
(
object oPlayer,     // player doing the crafting
int iMaterialType   // material type constant to add
)
{
    int iListSize =  ATS_GetMaterialDisplayListSize(oPlayer);
    ++iListSize;
    SetLocalInt(oPlayer, "ats_matdisplaylist_size", iListSize);

    SetLocalInt(oPlayer, "ats_matdisplaylist_" + IntToString(iListSize), iMaterialType);
}


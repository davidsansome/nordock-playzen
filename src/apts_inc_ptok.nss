/****************************************************
  Persistent Token Main Include Script
  apts_inc_ptok
  Last Updated: September 26, 2002
  ***Ambrosia Persistent Token System***
    Created by Mojo(Allen Sun)
  This script is the main include script and is
  needed to declare, set, and get token data.
  Include this script in any other script where you
  need access persistent token data.
****************************************************/
#include "apts_const_ptok"
#include "apts_inc_toksys"
#include "aps_include"
/* Function Declarations */
// Call this to declare an integer token, the size is the number of token range
// to reserve and determines the max size of the integer.
// (Sizes are APTS_LARGE_INT, APTS_MEDIUM_INT and APTS_SMALL_INT)
// Large integers take up 3 slots, medium take up 2, and small take up 1
void DeclareTokenInt(string sVarName, int iSlotNum, int bSigned = TRUE, int iSize = 3);
// Call this to declare a boolean token. In addition to declaring a slot number,
// you must also declare a bit position between 0-10.  You can declare up to
// 11 booleans in one slot.
void DeclareTokenBool(string sVarName, int iSlotNum, int iBitNum);
// Call this to declare a float token. You need to declare a unique slot.
// Floats take up 3 slots.
void DeclareTokenFloat(string sVarName, int iSlotNum, int b22Bit = FALSE);
// Call this to declare a string token. You must declare the max string
// length you want.  2 slots are reserved for up to every 3 characters so
// a 16 letter tag requires 12 slots reserved.  To calculate the number
// of slots that get reserved, simply take the max string length, divide by 3,
// round up, and multiply by 2.
void DeclareTokenString(string sVarName, int iSlotNum, int iMaxStrLength);
// Call this to declare a location token. You need to declare a unique slot.
// There are two methods to save the area info in a location. One is by use
// of strings which requires more space.  The other is by use of special
// waypoints which must be added to each area.  Pass in TRUE for bCompressedMode
// if you wish to use the waypoint method in order to save slot space.
// You can also choose not to save the facing to save more space. Simply pass in
// FALSE for the bSaveFacing parameter.
// Finally, you can choose to not save the Z position of the location.
// For players, you do not need to save the Z location.
// To quickly calculate the number of slots needed for locations, simply start
// with 6 slots.
//      Add 20 slots if you are not using the compressed modes and waypoints.
//      Add 2 slots if you want to save the facing.
//      Add 2 slots if you want to save the Z Position.
void DeclareTokenLocation(string sVarName, int iSlotNum, int bCompressedMode = FALSE, int bSaveFacing = TRUE, int bSaveZPos = TRUE);
// Sets a token integer to a certain value
void SetTokenInt(object oPlayer, string sVarName, int iValue);
// Sets a token boolean to a certain value
void SetTokenBool(object oPlayer, string sVarName, int bValue);
// Sets a token float to a certain value
void SetTokenFloat(object oPlayer, string sVarName, float fValue);
// Sets a token string to a certain value
void SetTokenString(object oPlayer, string sVarName, string sValue);
// Sets a token location to a certain value
void SetTokenLocation(object oPlayer, string sVarName, location lValue);
// Gets the value from a token integer variable.  You can also
// force the value to be loaded directly from the token by setting the
// last parameter to TRUE.
int GetTokenInt(object oPlayer, string sVarName, int bLoadToken = FALSE);
// Gets the value from a token boolean variable.  You can also
// force the value to be loaded directly from the token by setting the
// last parameter to TRUE.
int GetTokenBool(object oPlayer, string sVarName, int bLoadToken = FALSE);
// Gets the value from a token float variable.  You can also
// force the value to be loaded directly from the token by setting the
// last parameter to TRUE.
float GetTokenFloat(object oPlayer, string sVarName, int bLoadToken = FALSE);
// Gets the value from a token string variable.  You can also
// force the value to be loaded directly from the token by setting the
// last parameter to TRUE.
string GetTokenString(object oPlayer, string sVarName, int bLoadToken = FALSE);
// Gets the value from a token location variable.  You can also
// force the value to be loaded directly from the token by setting the
// last parameter to TRUE.
location GetTokenLocation(object oPlayer, string sVarName, int bLoadToken = FALSE);
// Deletes a token integer variable
void DeleteTokenInt(object oPlayer, string sVarName);
// Deletes a token boolean variable
void DeleteTokenBool(object oPlayer, string sVarName);
// Deletes a token float variable
void DeleteTokenFloat(object oPlayer, string sVarName);
// Deletes a token string variable
void DeleteTokenString(object oPlayer, string sVarName);
// Deletes a token location variable
void DeleteTokenLocation(object oPlayer, string sVarName);
/////////////////////////////////////////////////////
// DeclareTokenInt                                 //
//      Call this to declare an integer token,     //
//      the size is the number of token range      //
//      to reserve and determines the max size of  //
//      the integer.                               //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void DeclareTokenInt(string sVarName, int iSlotNum, int bSigned = TRUE, int iSize = 3)
{
    // Check to make sure the slot number is within bounds
}
/////////////////////////////////////////////////////
// DeclareTokenBool                                //
//      Call this to declare a boolean token.      //
//      In addition to declaring a slot number,    //
//      you must also declare a bit position       //
//      between 0-9.                               //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void DeclareTokenBool(string sVarName, int iSlotNum, int iBitNum)
{
}
/////////////////////////////////////////////////////
// DeclareTokenFloat                               //
//      Call this to declare a float token.        //
//      Floats take up 3 slots.                    //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void DeclareTokenFloat(string sVarName, int iSlotNum, int b22Bit = FALSE)
{
}
/////////////////////////////////////////////////////
// DeclareTokenString                              //
//      Call this to declare a string token.       //
//      2 slots are reserved for up to every 3     //
//      characters.                                //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void DeclareTokenString(string sVarName, int iSlotNum, int iMaxStrLength)
{
}
/////////////////////////////////////////////////////
// DeclareTokenLocation                            //
//      Call this to declare a location token.     //
//      Pass in TRUE for bCompressedMode if you  //
//      wish to use the waypoint method in order   //
//      to save slot space. You can also choose not//
//      to save the facing to save more space.     //
//      Simply pass in FALSE for the bSaveFacing   //
//      parameter. Also, pass FALSE for the        //
//      bSaveZPos parameter if you don't want to   //
//      save the Z-position.  For player locations //
//      you do not really have to.                 //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void DeclareTokenLocation(string sVarName, int iSlotNum, int bCompressedMode = FALSE, int bSaveFacing = TRUE, int bSaveZPos = TRUE)
{
}
/////////////////////////////////////////////////////
// SetTokenInt                                     //
//      Sets a token integer to a certain value.   //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void SetTokenInt(object oPlayer, string sVarName, int iValue)
{
    //SetCampaignInt("QUESTS", sVarName+"_int", iValue, oPlayer);
    SSetPersistentInt(oPlayer, sVarName+"_int", iValue, 0, "nordock_quests");
    SetLocalInt(oPlayer, sVarName, iValue);
}
/////////////////////////////////////////////////////
// SetTokenBool                                    //
//      Sets a token boolean to a certain value.   //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void SetTokenBool(object oPlayer, string sVarName, int bValue)
{
    //SetCampaignInt("QUESTS", sVarName+"_bool", bValue, oPlayer);
    SSetPersistentInt(oPlayer, sVarName+"_bool", bValue, 0, "nordock_quests");
    SetLocalInt(oPlayer, sVarName, bValue);
}
/////////////////////////////////////////////////////
//  SetTokenFloat                                  //
//      Sets a token float to a certain value.     //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void SetTokenFloat(object oPlayer, string sVarName, float fValue)
{
    //SetCampaignFloat("QUESTS", sVarName+"_flt", fValue, oPlayer);
    SSetPersistentFloat(oPlayer, sVarName+"_flt", fValue, 0, "nordock_quests");
    SetLocalFloat(oPlayer, sVarName, fValue);
}
/////////////////////////////////////////////////////
//  SetTokenString                                 //
//      Sets a token string to a certain value.    //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void SetTokenString(object oPlayer, string sVarName, string sValue)
{
    //SetCampaignString("QUESTS", sVarName+"_str", sValue, oPlayer);
    SSetPersistentString(oPlayer, sVarName+"_str", sValue, 0, "nordock_quests");
    SetLocalString(oPlayer, sVarName, sValue);
}
/////////////////////////////////////////////////////
//  SetTokenLocation                               //
//      Sets a token location to a certain value.  //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void SetTokenLocation(object oPlayer, string sVarName, location lValue)
{
    //SetCampaignLocation("QUESTS", sVarName+"_loc", lValue, oPlayer);
    SSetPersistentLocation(oPlayer, sVarName+"_loc", lValue, 0, "nordock_quests");
    SetLocalLocation(oPlayer, sVarName, lValue);
}
/////////////////////////////////////////////////////
// GetTokenInt                                     //
//      Gets the value from a token integer        //
//      variable.                                  //
// Returns: int - Value of the token integer       //
/////////////////////////////////////////////////////
int GetTokenInt(object oPlayer, string sVarName, int bLoadToken = FALSE)
{
    int iReturnVal = GetLocalInt(oPlayer, sVarName);
    if(bLoadToken || iReturnVal == 0)
    {
        //return GetCampaignInt("QUESTS", sVarName+"_int", oPlayer);
        return GGetPersistentInt(oPlayer, sVarName+"_int", "nordock_quests");
    }
    else
        return iReturnVal;
}
/////////////////////////////////////////////////////
// GetTokenBool                                    //
//      Gets the value from a token boolean        //
//      variable.                                  //
// Returns: int - Value of the token boolean       //
/////////////////////////////////////////////////////
int GetTokenBool(object oPlayer, string sVarName, int bLoadToken = FALSE)
{
    int iReturnVal = GetLocalInt(oPlayer, sVarName);
    if(bLoadToken || iReturnVal == 0)
    {
        //return GetCampaignInt("QUESTS", sVarName+"_bool", oPlayer);
        return GGetPersistentInt(oPlayer, sVarName+"_bool", "nordock_quests");
    }
    else
        return iReturnVal;
}
/////////////////////////////////////////////////////
// GetTokenFloat                                   //
//      Gets the value from a token float          //
//      variable.                                  //
// Returns: float - Value of the token float       //
/////////////////////////////////////////////////////
float GetTokenFloat(object oPlayer, string sVarName, int bLoadToken = FALSE)
{
    float fReturnVal = GetLocalFloat(oPlayer, sVarName);
    if(bLoadToken || fReturnVal == 0.0)
    {
        //return GetCampaignFloat("QUESTS", sVarName+"_flt", oPlayer);
        return GGetPersistentFloat(oPlayer, sVarName+"_flt", "nordock_quests");
    }
    else
        return fReturnVal;
}
/////////////////////////////////////////////////////
// GetTokenString                                  //
//      Gets the value from a token string         //
//      variable.                                  //
// Returns: string - Value of the token string     //
/////////////////////////////////////////////////////
string GetTokenString(object oPlayer, string sVarName, int bLoadToken = FALSE)
{
    string sReturnVal = GetLocalString(oPlayer, sVarName);
    if(bLoadToken || sReturnVal == "")
    {
        //return GetCampaignString("QUESTS", sVarName+"_str", oPlayer);
        return GGetPersistentString(oPlayer, sVarName+"_str", "nordock_quests");
    }
    return sReturnVal;
}
/////////////////////////////////////////////////////
// GetTokenLocation                                //
//      Gets the value from a token location       //
//      variable.                                  //
// Returns: location - Value of the token location //
/////////////////////////////////////////////////////
location GetTokenLocation(object oPlayer, string sVarName, int bLoadToken = FALSE)
{
    location lReturnVal = GetLocalLocation(oPlayer, sVarName);
    if(bLoadToken || GetPositionFromLocation(lReturnVal) == Vector())
    {
        //return GetCampaignLocation("QUESTS", sVarName+"_loc", oPlayer);
        return GGetPersistentLocation(oPlayer, sVarName+"_loc", "nordock_quests");
    }
    return lReturnVal;
}
/////////////////////////////////////////////////////
//  DeleteTokenInt                                 //
//      Deletes a token integer variable.          //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void DeleteTokenInt(object oPlayer, string sVarName)
{
    //DeleteCampaignVariable("QUESTS", sVarName+"_int", oPlayer);
    DeletePersistentVariable(oPlayer, sVarName+"_int", "nordock_quests");
    DeleteLocalInt(oPlayer, sVarName);
}
/////////////////////////////////////////////////////
//  DeleteTokenBool                                //
//      Deletes a token boolean variable.          //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void DeleteTokenBool(object oPlayer, string sVarName)
{
    //DeleteCampaignVariable("QUESTS", sVarName+"_bool", oPlayer);
    DeletePersistentVariable(oPlayer, sVarName+"_bool", "nordock_quests");
    DeleteLocalInt(oPlayer, sVarName);
}
/////////////////////////////////////////////////////
//  DeleteTokenFloat                               //
//      Deletes a token float variable.            //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void DeleteTokenFloat(object oPlayer, string sVarName)
{
    //DeleteCampaignVariable("QUESTS", sVarName+"_flt", oPlayer);
    DeletePersistentVariable(oPlayer, sVarName+"_flt", "nordock_quests");
    DeleteLocalFloat(oPlayer, sVarName);
}
/////////////////////////////////////////////////////
//  DeleteTokenString                              //
//      Deletes a token string variable.           //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void DeleteTokenString(object oPlayer, string sVarName)
{
    //DeleteCampaignVariable("QUESTS", sVarName+"_str", oPlayer);
    DeletePersistentVariable(oPlayer, sVarName+"_str", "nordock_quests");
    DeleteLocalString(oPlayer, sVarName);
}
/////////////////////////////////////////////////////
//  DeleteTokenLocation                            //
//      Deletes a token location variable.         //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void DeleteTokenLocation(object oPlayer, string sVarName)
{
    //DeleteCampaignVariable("QUESTS", sVarName+"_loc", oPlayer);
    DeletePersistentVariable(oPlayer, sVarName+"_loc", "nordock_quests");
    DeleteLocalLocation(oPlayer, sVarName);
}



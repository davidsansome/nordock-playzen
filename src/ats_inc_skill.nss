// Dependencies: ats_inc_common, ats_config, ats_const_common, ats_const_skill,
//               ats_const_recipe

#include "ats_text_skill"

#include "ats_inc_common"
#include "ats_config"
#include "ats_const_common"
#include "ats_const_skill"
#include "ats_const_recipe"

////////////////////////////////////////////////
// ATS_GetMaxSkill                                 //
//      Returns the max skill value for a          //
//      particular tradeskill                      //
// Returns: int - the max skill of a tradeskill    //
////////////////////////////////////////////////////
int ATS_GetMaxSkill
(
string sTradeSkillType     // tradeskill name
)
{
    int iMaxValue = 0;

    if(sTradeSkillType == CSTR_SKILLNAME_MINING)
        iMaxValue = CINT_MAXSKILL_MINING;
    else if(sTradeSkillType == CSTR_SKILLNAME_BLACKSMITHING)
        iMaxValue = CINT_MAXSKILL_BLACKSMITHING;
    else if(sTradeSkillType == CSTR_SKILLNAME_ARMORCRAFTING)
        iMaxValue = CINT_MAXSKILL_ARMORCRAFTING;
    else if(sTradeSkillType == CSTR_SKILLNAME_WEAPONCRAFTING)
        iMaxValue = CINT_MAXSKILL_WEAPONCRAFTING;
    else if(sTradeSkillType == CSTR_SKILLNAME_TANNING)
        iMaxValue = CINT_MAXSKILL_TANNING;
    else if(sTradeSkillType == CSTR_SKILLNAME_GEMCUTTING)
        iMaxValue = CINT_MAXSKILL_GEMCUTTING;
    else if(sTradeSkillType == CSTR_SKILLNAME_JEWELCRAFTING)
        iMaxValue = CINT_MAXSKILL_JEWELCRAFTING;
    else if(sTradeSkillType == CSTR_SKILLNAME_BOWYERING)
        iMaxValue = CINT_MAXSKILL_BOWYERING;
    else if(sTradeSkillType == CSTR_SKILLNAME_FLETCHING)
        iMaxValue = CINT_MAXSKILL_FLETCHING;
    else if(sTradeSkillType == CSTR_SKILLNAME_TAILOR)
        iMaxValue = CINT_MAXSKILL_TAILOR;
    else if(sTradeSkillType == CSTR_SKILLNAME_TINKER)
        iMaxValue = CINT_MAXSKILL_TINKER;
    return iMaxValue;


}
/////////////////////////////////////////////////////
// ATS_CheckMaxSkill                               //
//      Checks to see if a passed in skill value   //
//      is greater than the max skill level defined//
//      for a particular tradeskill                //
// Returns: int(Boolean) - TRUE if skill is beyond //
//                         the max skill           //
//                         FALSE otherwise         //
/////////////////////////////////////////////////////
int ATS_CheckMaxSkill
(
string sTradeSkillType,     // tradeskill name
int iSkillValue             // skill value to check against
)
{
    if(iSkillValue > ATS_GetMaxSkill(sTradeSkillType))
        return TRUE;
    else
        return FALSE;


}

string ATS_GetSkillTokenTag(string sTradeSkillType, int iTokenType)
{
    string sTokenTag = "";

    if(sTradeSkillType == CSTR_SKILLNAME_MINING)
        sTokenTag = CSTR_TOKEN_TAG_MINING;
    else if(sTradeSkillType == CSTR_SKILLNAME_BLACKSMITHING)
        sTokenTag = CSTR_TOKEN_TAG_BLACKSMITHING;
    else if(sTradeSkillType == CSTR_SKILLNAME_ARMORCRAFTING)
        sTokenTag = CSTR_TOKEN_TAG_ARMORCRAFTING;
    else if(sTradeSkillType == CSTR_SKILLNAME_WEAPONCRAFTING)
        sTokenTag = CSTR_TOKEN_TAG_WEAPONCRAFTING;
    else if(sTradeSkillType == CSTR_SKILLNAME_TANNING)
        sTokenTag = CSTR_TOKEN_TAG_TANNING;
    else if(sTradeSkillType == CSTR_SKILLNAME_GEMCUTTING)
        sTokenTag = CSTR_TOKEN_TAG_GEMCUTTING;
    else if(sTradeSkillType == CSTR_SKILLNAME_JEWELCRAFTING)
        sTokenTag = CSTR_TOKEN_TAG_JEWELCRAFTING;
    else if(sTradeSkillType == CSTR_SKILLNAME_BOWYERING)
        sTokenTag = CSTR_TOKEN_TAG_BOWYERING;
    else if(sTradeSkillType == CSTR_SKILLNAME_FLETCHING)
        sTokenTag = CSTR_TOKEN_TAG_FLETCHING;
    else if(sTradeSkillType == CSTR_SKILLNAME_TAILOR)
        sTokenTag = CSTR_TOKEN_TAG_TAILOR;
    else if(sTradeSkillType == CSTR_SKILLNAME_TINKER)
        sTokenTag = CSTR_TOKEN_TAG_TINKER;
    else
        return sTokenTag;

    sTokenTag += IntToString(iTokenType);

    return sTokenTag;

}
string ATS_GetTradeskillName(int iTradeskillConstant)
{
    if(iTradeskillConstant == CINT_SKILL_MINING)
        return CSTR_SKILLNAME_MINING;
    else if(iTradeskillConstant == CINT_SKILL_BLACKSMITHING)
        return CSTR_SKILLNAME_BLACKSMITHING;
    else if(iTradeskillConstant == CINT_SKILL_ARMORCRAFTING)
        return CSTR_SKILLNAME_ARMORCRAFTING;
    else if(iTradeskillConstant == CINT_SKILL_WEAPONCRAFTING)
        return CSTR_SKILLNAME_WEAPONCRAFTING;
    else if(iTradeskillConstant == CINT_SKILL_TANNING)
        return CSTR_SKILLNAME_TANNING;
    else if(iTradeskillConstant == CINT_SKILL_GEMCUTTING)
        return CSTR_SKILLNAME_GEMCUTTING;
    else if(iTradeskillConstant == CINT_SKILL_JEWELCRAFTING)
        return CSTR_SKILLNAME_JEWELCRAFTING;
    else if(iTradeskillConstant == CINT_SKILL_BOWYERING)
        return CSTR_SKILLNAME_BOWYERING;
    else if(iTradeskillConstant == CINT_SKILL_FLETCHING)
        return CSTR_SKILLNAME_FLETCHING;
    else if(iTradeskillConstant == CINT_SKILL_TAILOR)
        return CSTR_SKILLNAME_TAILOR;
    else if(iTradeskillConstant == CINT_SKILL_TINKER)
        return CSTR_SKILLNAME_TINKER;
    else
        return "";
}
int ATS_GetTradeskillConstant(string sTradeskillName)
{
    if(sTradeskillName == CSTR_SKILLNAME_MINING)
        return CINT_SKILL_MINING;
    else if(sTradeskillName == CSTR_SKILLNAME_BLACKSMITHING)
        return CINT_SKILL_BLACKSMITHING;
    else if(sTradeskillName == CSTR_SKILLNAME_ARMORCRAFTING)
        return CINT_SKILL_ARMORCRAFTING;
    else if(sTradeskillName == CSTR_SKILLNAME_WEAPONCRAFTING)
        return CINT_SKILL_WEAPONCRAFTING;
    else if(sTradeskillName == CSTR_SKILLNAME_TANNING)
        return CINT_SKILL_TANNING;
    else if(sTradeskillName == CSTR_SKILLNAME_GEMCUTTING)
        return CINT_SKILL_GEMCUTTING;
    else if(sTradeskillName == CSTR_SKILLNAME_JEWELCRAFTING)
        return CINT_SKILL_JEWELCRAFTING;
    else if(sTradeskillName == CSTR_SKILLNAME_BOWYERING)
        return CINT_SKILL_BOWYERING;
    else if(sTradeskillName == CSTR_SKILLNAME_FLETCHING)
        return CINT_SKILL_FLETCHING;
    else if(sTradeskillName == CSTR_SKILLNAME_TAILOR)
        return CINT_SKILL_TAILOR;
    else if(sTradeskillName == CSTR_SKILLNAME_TINKER)
        return CINT_SKILL_TINKER;
    else
        return 0;
}
void ATS_DestroyTokens(object oPlayer, string sTokenTag)
{
    object oItem = GetFirstItemInInventory(oPlayer);
    while(GetIsObjectValid(oItem) == TRUE)
    {
        if(GetTag(oItem) == sTokenTag)
            DestroyObject(oItem);
        oItem = GetNextItemInInventory(oPlayer);
    }

}

void ATS_CreateSkillTokenInBox(object oPlayer, object oBox, string sResRef, int iAmount)
{
    object oNewToken = CreateItemOnObject(sResRef, oPlayer, iAmount);
    AssignCommand(oPlayer, ActionGiveItem(oNewToken, oBox) );
}
void ATS_CreateSkillToken(object oPlayer, string sResRef, int iAmount)
{
    if(iAmount == 0)
        return; ///
    ATS_CreateItemOnPlayer(sResRef, oPlayer, iAmount, FALSE);
}
int ATS_GetAttributeBonus(object oPlayer, string sTradeskillName)
{
    if(sTradeskillName == CSTR_SKILLNAME_WEAPONCRAFTING ||
       sTradeskillName == CSTR_SKILLNAME_ARMORCRAFTING)
       return GetAbilityModifier(ABILITY_STRENGTH, oPlayer);
    else if(sTradeskillName == CSTR_SKILLNAME_JEWELCRAFTING)
       return GetAbilityModifier(ABILITY_CHARISMA, oPlayer);
    if(sTradeskillName == CSTR_SKILLNAME_BOWYERING ||
       sTradeskillName == CSTR_SKILLNAME_FLETCHING)
       return GetAbilityModifier(ABILITY_INTELLIGENCE, oPlayer);
    return 0;


}

string ATS_GetRelatedQualitySkill(string sTradeskillName)
{
if(sTradeskillName == CSTR_SKILLNAME_WEAPONCRAFTING ||
sTradeskillName == CSTR_SKILLNAME_ARMORCRAFTING)
return CSTR_SKILLNAME_BLACKSMITHING;
else if(sTradeskillName == CSTR_SKILLNAME_TANNING)
return CSTR_SKILLNAME_TANNING;
else if(sTradeskillName == CSTR_SKILLNAME_JEWELCRAFTING)
return CSTR_SKILLNAME_JEWELCRAFTING;
else if(sTradeskillName == CSTR_SKILLNAME_GEMCUTTING)
return CSTR_SKILLNAME_GEMCUTTING;
else if(sTradeskillName == CSTR_SKILLNAME_BOWYERING)
return CSTR_SKILLNAME_BOWYERING;
return "";
}

int ATS_IsValidSkill(string sTradeskillName)
{
    return(ATS_GetTradeskillConstant(sTradeskillName) != 0);
}
int ATS_IsPrimarySkill(string sTradeskillName)
{

    int iSkillConstant = ATS_GetTradeskillConstant(sTradeskillName);
    if(iSkillConstant == 0)
        return FALSE;

    if(iSkillConstant == CINT_SKILL_PRIMARY_1 ||
       iSkillConstant == CINT_SKILL_PRIMARY_2 ||
       iSkillConstant == CINT_SKILL_PRIMARY_3 ||
       iSkillConstant == CINT_SKILL_PRIMARY_4 ||
       iSkillConstant == CINT_SKILL_PRIMARY_5 ||
       iSkillConstant == CINT_SKILL_PRIMARY_6 ||
       iSkillConstant == CINT_SKILL_PRIMARY_7 ||
       iSkillConstant == CINT_SKILL_PRIMARY_8 ||
       iSkillConstant == CINT_SKILL_PRIMARY_9 ||
       iSkillConstant == CINT_SKILL_PRIMARY_10 )
        return TRUE;

    else return FALSE;
}
string ATS_GetTradeSkillFromCraftTag(string sCraftTag)
{
    string sCraftType = GetSubString(sCraftTag, 6, 1);
    string sTradeskillName = "";

    if(sCraftType == ATS_CRAFT_TYPE_ARMOR)
        sTradeskillName = CSTR_SKILLNAME_ARMORCRAFTING;
    else if(sCraftType == ATS_CRAFT_TYPE_WEAPON)
        sTradeskillName = CSTR_SKILLNAME_WEAPONCRAFTING;
    else if(sCraftType == ATS_CRAFT_TYPE_LEATHER)
        sTradeskillName = CSTR_SKILLNAME_TANNING;
    else if(sCraftType == ATS_CRAFT_TYPE_GEMCUTTING)
        sTradeskillName = CSTR_SKILLNAME_GEMCUTTING;
    else if(sCraftType == ATS_CRAFT_TYPE_JEWELCRAFT)
        sTradeskillName = CSTR_SKILLNAME_JEWELCRAFTING;
    else if(sCraftType == ATS_CRAFT_TYPE_BOWYERING)
        sTradeskillName = CSTR_SKILLNAME_BOWYERING;
    else if(sCraftType == ATS_CRAFT_TYPE_FLETCHING)
        sTradeskillName = CSTR_SKILLNAME_FLETCHING;
    else if(sCraftType == ATS_CRAFT_TYPE_TAILOR)
        sTradeskillName = CSTR_SKILLNAME_TAILOR;
    else if(sCraftType == ATS_CRAFT_TYPE_TINKER)
        sTradeskillName = CSTR_SKILLNAME_TINKER;

    return sTradeskillName;

}

int ATS_GetFlatFailure(string sTradeSkillType)
{
    if(sTradeSkillType == CSTR_SKILLNAME_MINING)
        return CINT_FLATFAILURE_MINING;
    else if(sTradeSkillType == CSTR_SKILLNAME_BLACKSMITHING)
        return CINT_FLATFAILURE_BLACKSMITHING;
    else if(sTradeSkillType == CSTR_SKILLNAME_ARMORCRAFTING)
        return CINT_FLATFAILURE_ARMORCRAFTING;
    else if(sTradeSkillType == CSTR_SKILLNAME_WEAPONCRAFTING)
        return CINT_FLATFAILURE_WEAPONCRAFTING;
    else if(sTradeSkillType == CSTR_SKILLNAME_TANNING)
        return CINT_FLATFAILURE_TANNING;
    else if(sTradeSkillType == CSTR_SKILLNAME_GEMCUTTING)
        return CINT_FLATFAILURE_GEMCUTTING;
    else if(sTradeSkillType == CSTR_SKILLNAME_JEWELCRAFTING)
        return CINT_FLATFAILURE_JEWELCRAFTING;
    else if(sTradeSkillType == CSTR_SKILLNAME_BOWYERING)
        return CINT_FLATFAILURE_BOWYERING;
    else if(sTradeSkillType == CSTR_SKILLNAME_FLETCHING)
        return CINT_FLATFAILURE_FLETCHING;
    else if(sTradeSkillType == CSTR_SKILLNAME_TAILOR)
        return CINT_FLATFAILURE_TAILOR;
    else if(sTradeSkillType == CSTR_SKILLNAME_TINKER)
        return CINT_FLATFAILURE_TINKER;

    else
        return 0;
}

float ATS_GetSkillGainAdjustment(string sTradeSkillType)
{
    if(sTradeSkillType == CSTR_SKILLNAME_MINING)
        return CFLOAT_SKILLGAIN_ADJUST_MINING;
    else if(sTradeSkillType == CSTR_SKILLNAME_BLACKSMITHING)
        return CFLOAT_SKILLGAIN_ADJUST_BLACKSMITHING;
    else if(sTradeSkillType == CSTR_SKILLNAME_ARMORCRAFTING)
        return CFLOAT_SKILLGAIN_ADJUST_ARMORCRAFTING;
    else if(sTradeSkillType == CSTR_SKILLNAME_WEAPONCRAFTING)
        return CFLOAT_SKILLGAIN_ADJUST_WEAPONCRAFTING;
    else if(sTradeSkillType == CSTR_SKILLNAME_TANNING)
        return CFLOAT_SKILLGAIN_ADJUST_TANNING;
    else if(sTradeSkillType == CSTR_SKILLNAME_GEMCUTTING)
        return CFLOAT_SKILLGAIN_ADJUST_GEMCUTTING;
    else if(sTradeSkillType == CSTR_SKILLNAME_JEWELCRAFTING)
        return CFLOAT_SKILLGAIN_ADJUST_JEWELCRAFTING;
    else if(sTradeSkillType == CSTR_SKILLNAME_BOWYERING)
        return CFLOAT_SKILLGAIN_ADJUST_BOWYERING;
    else if(sTradeSkillType == CSTR_SKILLNAME_FLETCHING)
        return CFLOAT_SKILLGAIN_ADJUST_FLETCHING;
    else if(sTradeSkillType == CSTR_SKILLNAME_TAILOR)
        return CFLOAT_SKILLGAIN_ADJUST_TAILOR;
    else if(sTradeSkillType == CSTR_SKILLNAME_TINKER)
        return CFLOAT_SKILLGAIN_ADJUST_TINKER;
    else
        return 0.0f;
}


/////////////////////////////////////////////////////
// ATS_SetTradeskill                               //
//      Sets the skill value of a particular       //
//      tradeskill of a player                     //
// Returns: none                                   //
/////////////////////////////////////////////////////
void ATS_SetTradeskill
(
object oPlayer,         // player to set tradeskill value of
string sTradeSkillType, // name of the tradeskill
int iSkillValue,         // the skill value to set
int bRemoveJournal  = TRUE,    // Removes the journal and remakes it to make room
int bSuppressLog = FALSE
)
{
    if(CBOOL_PERSISTENT_SKILLS_ACTIVE == TRUE)
    {
        object oSkillBox = GetItemPossessedBy(oPlayer, CSTR_PERSISTENT_SKILLS_BOXTAG);
        if(GetIsObjectValid(oSkillBox)== FALSE)
        {
            string sBoxResRef = ATS_GetResRefFromTag(CSTR_PERSISTENT_SKILLS_BOXTAG);
            // Create skill box
            object oCreatedItem = CreateItemOnObject(sBoxResRef, oPlayer);
        }
        string sToken1Tag = ATS_GetSkillTokenTag(sTradeSkillType, 1);
        string sToken100Tag = ATS_GetSkillTokenTag(sTradeSkillType, 100);

        object oNewToken1;
        object oNewToken100;

        int iValue100 = iSkillValue / 100;
        int iValue1 = iSkillValue - (iValue100 * 100);

        object oOldToken1 = GetItemPossessedBy(oPlayer, sToken1Tag);
        object oOldToken100 = GetItemPossessedBy(oPlayer, sToken100Tag);
        ATS_DestroyTokens(oPlayer, sToken1Tag);
        ATS_DestroyTokens(oPlayer, sToken100Tag);

//        object oTradeJournal = GetItemPossessedBy(oPlayer, CSTR_TRADESKILL_JOURNAL);
        if(bRemoveJournal == TRUE)
        {
            ATS_RemoveAllInstancesOnPlayer(oPlayer, CSTR_TRADESKILL_JOURNAL);
            DelayCommand(1.0, ATS_CreateItemOnPlayer(CSTR_TRADESKILL_JOURNAL, oPlayer, 1, FALSE));
        }
        DelayCommand(0.3, ATS_CreateSkillToken(oPlayer, ATS_GetResRefFromTag(sToken1Tag), iValue1));
        DelayCommand(0.3, ATS_CreateSkillToken(oPlayer, ATS_GetResRefFromTag(sToken100Tag), iValue100));

    }

    string sVarName = "ats_skillvalue_" + sTradeSkillType;
    ATS_SetPersistentInt(oPlayer, sVarName, iSkillValue);
    // Log Skill Gain
    if(CBOOL_LOG_SKILLGAIN == TRUE && bSuppressLog == FALSE)
    {

        WriteTimestampedLogEntry("<ATS> Skill Change: " + GetName(oPlayer) +
                                 "(" + GetPCPlayerName(oPlayer) + ") - " + sTradeSkillType +
                                 ": " + IntToString(iSkillValue));
    }
}

/////////////////////////////////////////////////////
// ATS_RaiseTradeskill                             //
//      Raises a player's trade skill by a certain //
//      amount and displays a message              //
// Returns: none                                   //
/////////////////////////////////////////////////////
void ATS_RaiseTradeskill
(
object oPlayer,         // player to raise tradeskill
string sTradeSkillType, // name of tradeskill
int iValue              // amount to raise by
)
{
    int iCurrentValue = ATS_GetTradeskill(oPlayer, sTradeSkillType);
    int iNewValue = iCurrentValue + iValue;
    // Check to make sure the skill isn't maxed out
    if(ATS_CheckMaxSkill(sTradeSkillType, iNewValue) == FALSE)
    {

        // Sets the skill to it's new value
        ATS_SetTradeskill(oPlayer, sTradeSkillType, iNewValue, TRUE, TRUE);
        string sDisplayMessage = "";
        if(CINT_SKILL_MESSAGE_SETTING == 2)
        {
            sDisplayMessage = "You have gained ";
            if(iValue == 1)
                sDisplayMessage = sDisplayMessage + "a skill point in ";
            else
                sDisplayMessage = sDisplayMessage + IntToString(iValue) + " skill points in ";
            // Display skill gain message
            sDisplayMessage = sDisplayMessage + sTradeSkillType + ". (" +
                              IntToString(ATS_GetTradeskill(oPlayer, sTradeSkillType)) + ")";
        }
        else if(CINT_SKILL_MESSAGE_SETTING == 1)
        {
            sDisplayMessage = "You have gained some knowledge in " +
                              sTradeSkillType + "!";
        }
        if(sDisplayMessage != "")
            DelayCommand(0.5, SendMessageToPC(oPlayer, sDisplayMessage));
        //AssignCommand(oPlayer, SpeakString(sDisplayMessage, TALKVOLUME_WHISPER));
        if(CBOOL_LOG_SKILLGAIN == TRUE)
        {

        WriteTimestampedLogEntry("<ATS> Skill Gain: " + GetPCPlayerName(oPlayer) +
                                 "(" + GetName(oPlayer) + ") - " + sTradeSkillType +
                                 ": " + IntToString(ATS_GetTradeskill(oPlayer, sTradeSkillType)));
        }
    }
}

int ATS_GetPrimarySkillConstant(int iPrimarySkillNum)
{
    switch(iPrimarySkillNum)
    {
        case 1:
            return CINT_SKILL_PRIMARY_1;
        case 2:
            return CINT_SKILL_PRIMARY_2;
        case 3:
            return CINT_SKILL_PRIMARY_3;
        case 4:
            return CINT_SKILL_PRIMARY_4;
        case 5:
            return CINT_SKILL_PRIMARY_5;
        case 6:
            return CINT_SKILL_PRIMARY_6;
        case 7:
            return CINT_SKILL_PRIMARY_7;
        case 8:
            return CINT_SKILL_PRIMARY_8;
        case 9:
            return CINT_SKILL_PRIMARY_9;
        case 10:
            return CINT_SKILL_PRIMARY_10;
        default:
            return 0;
    }
    return 0;
}

string ATS_GetPrimarySkillName(int iPrimarySkillNum)
{
    return ATS_GetTradeskillName(ATS_GetPrimarySkillConstant(iPrimarySkillNum));
}

int ATS_GetSecondarySkillConstant(int iSecondarySkillNum)
{
    switch(iSecondarySkillNum)
    {
        case 1:
            return CINT_SKILL_SECONDARY_1;
        case 2:
            return CINT_SKILL_SECONDARY_2;
        case 3:
            return CINT_SKILL_SECONDARY_3;
        case 4:
            return CINT_SKILL_SECONDARY_4;
        case 5:
            return CINT_SKILL_SECONDARY_5;
        case 6:
            return CINT_SKILL_SECONDARY_6;
        case 7:
            return CINT_SKILL_SECONDARY_7;
        case 8:
            return CINT_SKILL_SECONDARY_8;
        case 9:
            return CINT_SKILL_SECONDARY_9;
        case 10:
            return CINT_SKILL_SECONDARY_10;
        default:
            return 0;
    }
    return 0;
}

string ATS_GetSecondarySkillName(int iSecondarySkillNum)
{
    return ATS_GetTradeskillName(ATS_GetSecondarySkillConstant(iSecondarySkillNum));
}

int ATS_GetPrimarySkillTotal(object oPlayer)
{
    int iSkillTotal = 0;
    int i;
    for(i = 1; i < 11; ++i)
    {
        iSkillTotal += ATS_GetTradeskill(oPlayer, ATS_GetPrimarySkillName(i));
    }
    return iSkillTotal;
}

int ATS_GetSecondarySkillTotal(object oPlayer)
{
    int iSkillTotal = 0;
    int i;
    for(i = 1; i < 11; ++i)
    {
        iSkillTotal += ATS_GetTradeskill(oPlayer, ATS_GetSecondarySkillName(i));
    }
    return iSkillTotal;

}

int ATS_GetSkillRank(int iSkillValue)
{
    if(iSkillValue >= CINT_SKILL_LEVEL_RANK_10)
        return 10;
    else if(iSkillValue >= CINT_SKILL_LEVEL_RANK_9)
        return 9;
    else if(iSkillValue >= CINT_SKILL_LEVEL_RANK_8)
        return 8;
    else if(iSkillValue >= CINT_SKILL_LEVEL_RANK_7)
        return 7;
    else if(iSkillValue >= CINT_SKILL_LEVEL_RANK_6)
        return 6;
    else if(iSkillValue >= CINT_SKILL_LEVEL_RANK_5)
        return 5;
    else if(iSkillValue >= CINT_SKILL_LEVEL_RANK_4)
        return 4;
    else if(iSkillValue >= CINT_SKILL_LEVEL_RANK_3)
        return 3;
    else if(iSkillValue >= CINT_SKILL_LEVEL_RANK_2)
        return 2;
    else if(iSkillValue >= CINT_SKILL_LEVEL_RANK_1)
        return 1;
    else
        return 0;
}

string ATS_GetSkillRankName(int iSkillValue)
{
    if(iSkillValue >= CINT_SKILL_LEVEL_RANK_10)
        return CSTR_SKILLRANK_10;
    else if(iSkillValue >= CINT_SKILL_LEVEL_RANK_9)
        return CSTR_SKILLRANK_9;
    else if(iSkillValue >= CINT_SKILL_LEVEL_RANK_8)
        return CSTR_SKILLRANK_8;
    else if(iSkillValue >= CINT_SKILL_LEVEL_RANK_7)
        return CSTR_SKILLRANK_7;
    else if(iSkillValue >= CINT_SKILL_LEVEL_RANK_6)
        return CSTR_SKILLRANK_6;
    else if(iSkillValue >= CINT_SKILL_LEVEL_RANK_5)
        return CSTR_SKILLRANK_5;
    else if(iSkillValue >= CINT_SKILL_LEVEL_RANK_4)
        return CSTR_SKILLRANK_4;
    else if(iSkillValue >= CINT_SKILL_LEVEL_RANK_3)
        return CSTR_SKILLRANK_3;
    else if(iSkillValue >= CINT_SKILL_LEVEL_RANK_2)
        return CSTR_SKILLRANK_2;
    else if(iSkillValue >= CINT_SKILL_LEVEL_RANK_1)
        return CSTR_SKILLRANK_1;
    else
        return CSTR_SKILLRANK_0;
}

int ATS_IsSkillValueMasterLevel(int iSkillValue)
{
    return (ATS_GetSkillRank(iSkillValue) >= CINT_SKILLRANK_MASTERLEVEL);
}

string ATS_GetSkillDescription(string sSkillName)
{
    if(sSkillName == CSTR_SKILLNAME_MINING)
        return CSTR_DESCRIPTION_SKILL_MINING;
    else if(sSkillName == CSTR_SKILLNAME_BLACKSMITHING)
        return CSTR_DESCRIPTION_SKILL_BLACKSMITHING;
    else if(sSkillName == CSTR_SKILLNAME_ARMORCRAFTING)
        return CSTR_DESCRIPTION_SKILL_ARMORCRAFTING;
    else if(sSkillName == CSTR_SKILLNAME_WEAPONCRAFTING)
        return CSTR_DESCRIPTION_SKILL_WEAPONCRAFTING;
    else if(sSkillName == CSTR_SKILLNAME_TANNING)
        return CSTR_DESCRIPTION_SKILL_TANNING;
    else if(sSkillName == CSTR_SKILLNAME_GEMCUTTING)
        return CSTR_DESCRIPTION_SKILL_GEMCUTTING;
    else if(sSkillName == CSTR_SKILLNAME_JEWELCRAFTING)
        return CSTR_DESCRIPTION_SKILL_JEWELCRAFTING;
    else if(sSkillName == CSTR_SKILLNAME_BOWYERING)
        return CSTR_DESCRIPTION_SKILL_BOWYERING;
    else if(sSkillName == CSTR_SKILLNAME_FLETCHING)
        return CSTR_DESCRIPTION_SKILL_FLETCHING;
    else if(sSkillName == CSTR_SKILLNAME_TAILOR)
        return CSTR_DESCRIPTION_SKILL_TAILOR;
    else if(sSkillName == CSTR_SKILLNAME_TINKER)
        return CSTR_DESCRIPTION_SKILL_TINKER;
    else
        return "";


}


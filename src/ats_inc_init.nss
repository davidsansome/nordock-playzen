#include "ats_inc_common"
#include "ats_const_common"
#include "ats_const_skill"
#include "ats_const_recipe"
#include "ats_config"
#include "ats_inc_skill"
#include "ats_inc_update"
#include "ats_inc_textform"

void ATS_UpdatePlayerSkillTokens(object oPlayer)
{
    string sTradeSkillType;
    int iSkillValue;
    int i;
    int iMaxSkill;
    string sVarName;
    // Retrieve token information
    for(i = 1; i <= CINT_SKILL_COUNT; ++i)
    {
        iSkillValue = 0;
        sTradeSkillType = ATS_GetTradeskillName(i);
        string sToken1Tag = ATS_GetSkillTokenTag(sTradeSkillType, 1);
        string sToken100Tag = ATS_GetSkillTokenTag(sTradeSkillType, 100);

        object oSkillToken1 = GetItemPossessedBy(oPlayer, sToken1Tag);
        object oSkillToken100 = GetItemPossessedBy(oPlayer, sToken100Tag);

        if(GetIsObjectValid(oSkillToken100) == TRUE)
            iSkillValue = 100 * GetNumStackedItems(oSkillToken100);
        if(GetIsObjectValid(oSkillToken1) == TRUE)
            iSkillValue += GetNumStackedItems(oSkillToken1);

        ATS_RemoveAllInstancesOnPlayer(oPlayer, sToken1Tag);
        ATS_RemoveAllInstancesOnPlayer(oPlayer, sToken100Tag);

        if(ATS_GetTradeskill(oPlayer, sTradeSkillType) == 0 &&
           iSkillValue > 0)
           {
                sVarName = "ats_skillvalue_" + sTradeSkillType;
                ATS_SetPersistentInt(oPlayer, sVarName, iSkillValue);
           }
    }
    ATS_RemoveAllInstancesOnPlayer(oPlayer, CSTR_PERSISTENT_SKILLS_BOXTAG);
    // Create skill box
    DelayCommand(0.5, ATS_CreateItemOnPlayer(ATS_GetResRefFromTag(CSTR_PERSISTENT_SKILLS_BOXTAG), oPlayer));
    int iDelay = 1;
    for(i = 1; i <= CINT_SKILL_COUNT; ++i)
    {
        sTradeSkillType = ATS_GetTradeskillName(i);
        iMaxSkill = ATS_GetMaxSkill(sTradeSkillType);
        sVarName = "ats_skillvalue_" + sTradeSkillType;
        iSkillValue = ATS_GetPersistentInt(oPlayer, sVarName);
        if(iSkillValue > iMaxSkill)
        {
            DelayCommand(0.5 * iDelay, ATS_SetTradeskill(oPlayer, sTradeSkillType, iSkillValue, FALSE, TRUE));
            ++iDelay;
        }
        else if(iSkillValue > 0)
        {
            DelayCommand(0.5 * iDelay, ATS_SetTradeskill(oPlayer, sTradeSkillType, iSkillValue, FALSE, TRUE));
            ++iDelay;
        }
    }
    DelayCommand(0.5*iDelay + 0.5, ATS_CreateItemOnPlayer(ATS_GetResRefFromTag(CSTR_TRADESKILL_JOURNAL), oPlayer));
}

/////////////////////////////////////////////////////
// ATS_InitializePlayer                            //
//      Ensures a player has the tradeskill journal//
//      and sets up persistent box of holding      //
// Returns: None                                   //
/////////////////////////////////////////////////////
void ATS_InitializePlayer(object oPlayer)
{
    ATS_RemoveAllInstancesOnPlayer(oPlayer, CSTR_TRADESKILL_JOURNAL);

    //SetLocalInt(oPlayer, "ats_inventory_full", FALSE);

    if(CBOOL_PERSISTENT_SKILLS_ACTIVE == TRUE)
    {
        object oSkillBox = GetItemPossessedBy(oPlayer, CSTR_PERSISTENT_SKILLS_BOXTAG);
        if(GetIsObjectValid(oSkillBox)== FALSE)
        {
            string sBoxResRef = ATS_GetResRefFromTag(CSTR_PERSISTENT_SKILLS_BOXTAG);
            // Create skill box
            CreateItemOnObject(sBoxResRef, oPlayer);
            DelayCommand(1.0, ATS_CreateItemOnPlayer(ATS_GetResRefFromTag(CSTR_TRADESKILL_JOURNAL), oPlayer));
        }
        else
        {
            DelayCommand(1.0, ATS_UpdatePlayerSkillTokens( oPlayer));
        }
    }
    else
        DelayCommand(1.0, ATS_CreateItemOnPlayer(ATS_GetResRefFromTag(CSTR_TRADESKILL_JOURNAL), oPlayer));


    if(GetIsDM(oPlayer) == TRUE)
    {
        if(GetItemPossessedBy(oPlayer, "ATS_D_DMSW_N_NOD") == OBJECT_INVALID)
        {
            // Create skill wand
            CreateItemOnObject("ats_d_dmsw_n_nod", oPlayer);
        }
    }
    DelayCommand(2.0, ATS_UpdateOldItems(oPlayer));
    DelayCommand(2.0, SetLocalInt(GetModule(), "ats_refresh_useable_items_"
                                  + GetName(oPlayer), TRUE));

}

void ATS_CreateMerchantStores(string sMerchantTag)
{
    int iTagLength = GetStringLength(sMerchantTag);
    string sStoreTag = "ATS_STORE_" + GetStringRight(sMerchantTag, iTagLength - 8);
    object oStore;
    object oMerchantNPC = GetObjectByTag(sMerchantTag, 0);
    object oCurrentItem;

    int i = 0;
    while(oMerchantNPC != OBJECT_INVALID)
    {
        oStore = GetNearestObjectByTag(sStoreTag, oMerchantNPC);
        if(oStore == OBJECT_INVALID || GetDistanceBetween(oStore, oMerchantNPC) > 1.0f)
        {
            oStore = CreateObject(OBJECT_TYPE_STORE, ATS_GetResRefFromTag(sStoreTag), GetLocation(oMerchantNPC));
        }
        oCurrentItem = GetFirstItemInInventory(oStore);
        while(oCurrentItem != OBJECT_INVALID)
        {
            SetLocalInt(oCurrentItem, "ats_onstore_original", TRUE);
            oCurrentItem = GetNextItemInInventory(oStore);
        }
       oMerchantNPC = GetObjectByTag(sMerchantTag, ++i);

    }

}

void ATS_LoadRecipes()
{
    // Load default recipes
    ExecuteScript("ats_recipes", GetModule());
    // Load custom recipes
//    ExecuteScript("ats_recipes_cust", GetModule());
//  commented out by richterm when combining regular and custom recipe
//  scripts - troubleshooting on 01/11/03
}

void ATS_StoreSkillNameWidth()
{
    SetLocalInt(GetModule(), "ats_skillname_width_" + CSTR_SKILLNAME_MINING,
                ATS_GetStringPeriodWidth(CSTR_SKILLNAME_MINING));
    SetLocalInt(GetModule(), "ats_skillname_width_" + CSTR_SKILLNAME_BLACKSMITHING,
                ATS_GetStringPeriodWidth(CSTR_SKILLNAME_BLACKSMITHING));
    SetLocalInt(GetModule(), "ats_skillname_width_" + CSTR_SKILLNAME_ARMORCRAFTING,
                ATS_GetStringPeriodWidth(CSTR_SKILLNAME_ARMORCRAFTING));
    SetLocalInt(GetModule(), "ats_skillname_width_" + CSTR_SKILLNAME_WEAPONCRAFTING,
                ATS_GetStringPeriodWidth(CSTR_SKILLNAME_WEAPONCRAFTING));
    SetLocalInt(GetModule(), "ats_skillname_width_" + CSTR_SKILLNAME_TANNING,
                ATS_GetStringPeriodWidth(CSTR_SKILLNAME_TANNING));
    SetLocalInt(GetModule(), "ats_skillname_width_" + CSTR_SKILLNAME_GEMCUTTING,
                ATS_GetStringPeriodWidth(CSTR_SKILLNAME_GEMCUTTING));
    SetLocalInt(GetModule(), "ats_skillname_width_" + CSTR_SKILLNAME_JEWELCRAFTING,
                ATS_GetStringPeriodWidth(CSTR_SKILLNAME_JEWELCRAFTING));
    SetLocalInt(GetModule(), "ats_skillname_width_" + CSTR_SKILLNAME_BOWYERING,
                ATS_GetStringPeriodWidth(CSTR_SKILLNAME_BOWYERING));
    SetLocalInt(GetModule(), "ats_skillname_width_" + CSTR_SKILLNAME_FLETCHING,
                ATS_GetStringPeriodWidth(CSTR_SKILLNAME_FLETCHING));

}

// Called to initialize variables and create objects for the trade skill
// system
void ATS_Initialize()
{
    ExecuteScript("apts_declare_tok", GetModule());
    AssignCommand(GetModule(), ATS_StoreSkillNameWidth());
    DelayCommand(5.0, ExecuteScript("ats_init_forge", GetModule()));
    // Moved to hc_on_mod_load
    //DelayCommand(10.0, ExecuteScript("ats_init_msp", GetModule()));
    AssignCommand(GetModule(), DelayCommand(16.0, ATS_LoadRecipes()));
}

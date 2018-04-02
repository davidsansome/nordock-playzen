#include "ats_inc_common"
#include "ats_const_common"
#include "ats_config"
#include "ats_const_skill"
#include "ats_const_recipe"
#include "ats_inc_skill"
#include "ats_inc_update"
//#include "rr_persist"

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
//    DelayCommand(0.5, ATS_CreateItemOnPlayer(ATS_GetResRefFromTag(CSTR_PERSISTENT_SKILLS_BOXTAG), oPlayer));
//    int iDelay = 1;
//   for(i = 1; i <= CINT_SKILL_COUNT; ++i)
//    {
//        sTradeSkillType = ATS_GetTradeskillName(i);
//        iMaxSkill = ATS_GetMaxSkill(sTradeSkillType);
//        sVarName = "ats_skillvalue_" + sTradeSkillType;
//        iSkillValue = ATS_GetPersistentInt(oPlayer, sVarName);
//        if(iSkillValue > iMaxSkill)
//        {
//            DelayCommand(0.5 * iDelay, ATS_SetTradeskill(oPlayer, sTradeSkillType, iSkillValue, FALSE, TRUE));
//            ++iDelay;
//        }
//        else if(iSkillValue > 0)
//        {
//            DelayCommand(0.5 * iDelay, ATS_SetTradeskill(oPlayer, sTradeSkillType, iSkillValue, FALSE, TRUE));
//            ++iDelay;
//        }
//    }
    DelayCommand(1.0, ATS_CreateItemOnPlayer(ATS_GetResRefFromTag(CSTR_TRADESKILL_JOURNAL), oPlayer));
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

//    if((CBOOL_PERSISTENT_SKILLS_ACTIVE == TRUE) && (!ATS_GetPersistentInt(oPlayer,"ATS_updated")))
    if(!ATS_GetPersistentInt(oPlayer,"ATS_updated"))
    {
        object oSkillBox = GetItemPossessedBy(oPlayer, CSTR_PERSISTENT_SKILLS_BOXTAG);
        if(GetIsObjectValid(oSkillBox)== FALSE)
        {
//            string sBoxResRef = ATS_GetResRefFromTag(CSTR_PERSISTENT_SKILLS_BOXTAG);
            // Create skill box
//            CreateItemOnObject(sBoxResRef, oPlayer);
//            DelayCommand(1.0, ATS_CreateItemOnPlayer(ATS_GetResRefFromTag(CSTR_TRADESKILL_JOURNAL), oPlayer));
        }
        else
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
//            DelayCommand(1.0, ATS_UpdatePlayerSkillTokens( oPlayer));
        }
        ATS_SetPersistentInt(oPlayer,"ATS_updated",TRUE);
        DestroyObject(oSkillBox);
        DelayCommand(1.0, ATS_CreateItemOnPlayer(ATS_GetResRefFromTag(CSTR_TRADESKILL_JOURNAL), oPlayer));
    }
    else
        DelayCommand(1.0, ATS_CreateItemOnPlayer(ATS_GetResRefFromTag(CSTR_TRADESKILL_JOURNAL), oPlayer));


    if(ATS_GetIsAllowed(oPlayer) == TRUE)
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

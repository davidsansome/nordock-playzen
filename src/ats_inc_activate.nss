/****************************************************
  Activate Item #include Script
  ats_inc_activate
  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This include script is reponsible for checking
  that the tradeskill journal was used and starts
  the appropiate conversation menu.  #Include this
  script within a script on your module's OnActivateItem
  trigger.  Then add ATS_CheckJournalUse() at the
  very top of the script.
****************************************************/
#include "ats_const_common"
#include "ats_const_recipe"
#include "ats_const_skill"
#include "ats_config"
#include "ats_inc_common"
#include "ats_inc_menu"
#include "ats_inc_skill"

int ATS_CheckJournalUse(object oItemActivator, object oItemActivated)
{
    if(GetTag(oItemActivated) != CSTR_TRADESKILL_JOURNAL)
        return FALSE;
    AssignCommand(oItemActivator, ActionStartConversation(oItemActivator, "ats_c_skills", TRUE));
    return TRUE;
}

int ATS_CheckForBundle(object oItemActivator, object oItemActivated)
{
    string sBundleTag = GetTag(oItemActivated);
    if(GetSubString(sBundleTag, 11, 1) == "B")
    {
        string sItemTag = GetStringLeft(sBundleTag, 11);
        sItemTag += "N_";
        sItemTag += GetSubString(sBundleTag, 13, 3);
        int iBundleAmount = StringToInt(GetStringRight(sBundleTag, GetStringLength(sBundleTag) - 17));
        string sBundleName = GetName(oItemActivated);
        DestroyObject(oItemActivated);

        int i;
        for(i = 0; i < iBundleAmount; ++i)
        {
            ATS_CreateItemOnPlayer(ATS_GetResRefFromTag(sItemTag), oItemActivator);
        }
        string sMessage = "You have obtained " + IntToString(iBundleAmount) + " " +
                          GetName(GetLocalObject(oItemActivator, "ats_returnvalue_created_item")) +
                          "s from the " + sBundleName + ".";
        FloatingTextStringOnCreature(sMessage, oItemActivator, FALSE);
        return TRUE;

    }
    else
        return FALSE;


}
int ATS_CheckTradeSkillTool(object oItemActivator, object oItemActivated)
{
    if(ATS_GetTagBaseType(oItemActivated) == CSTR_TANNING_SEWKIT)
    {
        if(ATS_GetTradeskill(oItemActivator, CSTR_SKILLNAME_TANNING) > 0)
        {
            ATS_SetCurrentCraftType(oItemActivator, ATS_CRAFT_TYPE_LEATHER);
            SetLocalInt(oItemActivator, "ats_tanning_subskill", ATS_TANNING_SUBSKILL_SEWING);
            ATS_SetCurrentCraftPart(oItemActivator, 9);
            ATS_InitCraftArrayIndex(oItemActivator);
            ATS_InitMakeableCount(oItemActivator);
            object oConverser = CreateObject(OBJECT_TYPE_PLACEABLE, "ats_invis_tansew",
                                                GetLocation(oItemActivator));
            DelayCommand(1.0, AssignCommand(oConverser, ActionStartConversation(oItemActivator, "", TRUE)));
        }
        else
            FloatingTextStringOnCreature("You do not have enough skill to use this.", oItemActivator, FALSE);
        return TRUE;
    }
    else if(ATS_GetTagBaseType(oItemActivated) == CSTR_GEMCUTTINGTOOL)
    {
        if(ATS_GetTradeskill(oItemActivator, CSTR_SKILLNAME_GEMCUTTING) > 0)
        {
            ATS_SetCurrentCraftType(oItemActivator, ATS_CRAFT_TYPE_GEMCUTTING);
            ATS_SetCurrentCraftPart(oItemActivator, ATS_CRAFT_PART_GEM);
            ATS_InitCraftArrayIndex(oItemActivator);
            ATS_InitMakeableCount(oItemActivator);
            object oConverser = CreateObject(OBJECT_TYPE_PLACEABLE, "ats_invis_gemcut",
                                                GetLocation(oItemActivator));
            DelayCommand(1.0, AssignCommand(oConverser, ActionStartConversation(oItemActivator, "", TRUE)));
        }
        else
            FloatingTextStringOnCreature("You do not have enough skill to use this.", oItemActivator, FALSE);
        return TRUE;
    }
    else
        return FALSE;

}
void ATS_CheckDMTool(object oItemActivator, object oItemActivated, object oActivatedTarget, location oActivatedTargetLoc)
{
    // Skill Wand
    if(GetTag(oItemActivated) == "ATS_D_DMSW_N_NON")
    {
        if(GetIsDM(oItemActivator) == TRUE)
        {
            if(GetIsObjectValid(oActivatedTarget) && (GetIsPC(oActivatedTarget) ||
                                                       GetIsDM(oActivatedTarget)))
            {
                SetLocalObject(oItemActivator, "ats_item_target", oActivatedTarget);
                AssignCommand(oItemActivator, ActionStartConversation(oItemActivator, "ats_c_skillwand", TRUE));
            }
            else
                FloatingTextStringOnCreature("That is an invalid target.", oItemActivator);

        }
        else
            FloatingTextStringOnCreature("Only a DM can use this item!", oItemActivator);

    }

}

void ATS_CheckActivatedItem(object oItemActivator, object oItemActivated,
                           object oActivatedTarget, location oActivatedTargetLoc)
{
    SetLocalObject(oItemActivator, "ats_activated_item", oItemActivated);
    if(ATS_CheckJournalUse(oItemActivator, oItemActivated) == TRUE)
        return;
    if(ATS_CheckForBundle(oItemActivator, oItemActivated) == TRUE)
        return;
    if(ATS_CheckTradeSkillTool(oItemActivator, oItemActivated) == TRUE)
        return;
    if(GetIsDM(oItemActivator) == TRUE)
        ATS_CheckDMTool(oItemActivator, oItemActivated, oActivatedTarget, oActivatedTargetLoc);
}

/****************************************************
  Action Taken Script: Forge - Salvage Crafted
  ats_forge_salvag

  Last Updated: July 22, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is responsible for salvaging crafted
  armor and weapons back into useable ingots.
****************************************************/
#include "ats_inc_common"
#include "ats_inc_constant"
#include "ats_config"
#include "ats_inc_skill_bs"
#include "ats_inc_skill"
#include "ats_inc_material"
#include "ats_inc_cr_get"
#include "ats_inc_cr_comp"

int CINT_SALVAGE_UNSKILLED = -1;

int ATS_GetSalvageRate(string sCraftTag)
{
   return GetLocalInt(GetModule(), sCraftTag + "_ingots_salvageable");
}

int ATS_CalculateSalvagingSuccess(int iOreType, object oPlayer, int iMaxIngots)
{
    int iDiceRoll;
    int iMaterialDifficulty = ATS_GetSmeltingLevel(iOreType);
    int iIngotsSalvaged = 0;

    int iSuccessLevel = iMaterialDifficulty - ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_BLACKSMITHING);

    if(iSuccessLevel > 50)
        return CINT_SALVAGE_UNSKILLED;

    int i;
    for(i = 0; i < iMaxIngots; ++i)
    {
        iDiceRoll = d100(1) / 2;
        if( (iDiceRoll  > iSuccessLevel) && (iDiceRoll != 0) )
            ++iIngotsSalvaged;
    }
    return iIngotsSalvaged;

}

void ATS_SalvageCraftable(object oPlayer, object oCraftable)
{
    int iIngotType = ATS_GetMaterialType(oCraftable);
    string sCraftTag = ATS_GetCraftTag(oCraftable);
    int iSalvageRate = ATS_GetSalvageRate(sCraftTag);
    string sIngotTag = ATS_GetComponentTagFromRecipe(sCraftTag, CINT_COMPONENT_ID_INGOTS, iIngotType);
    int iIngotAmount = ATS_GetComponentAmountFromRecipe(sCraftTag, CINT_COMPONENT_ID_INGOTS, iIngotType);

    float fSalvageMultiplier = (iSalvageRate/100.0f);
    int iMaxIngots = FloatToInt(iIngotAmount * fSalvageMultiplier);
    if(iMaxIngots == 0)
        iMaxIngots = 1;

    int iIngotsSalvaged = ATS_CalculateSalvagingSuccess(iIngotType, oPlayer, iMaxIngots);
    if(iIngotsSalvaged > 0)
    {
        string sMaterialName = ATS_GetMaterialName(iIngotType);
        string sSuccessString = "You have successfully salvaged " +
                                IntToString(iIngotsSalvaged) + " " +
                                sMaterialName + " ingot";
        if(iIngotsSalvaged > 1)
            sSuccessString += "s";
        sSuccessString += (" from the " + GetName(oCraftable));

        FloatingTextStringOnCreature(sSuccessString, oPlayer, FALSE);
        while(iIngotsSalvaged > 10)
        {
            CreateItemOnObject(ATS_GetResRefFromTag(sIngotTag), oPlayer, 10);
            iIngotsSalvaged -= 10;
        }

        CreateItemOnObject(ATS_GetResRefFromTag(sIngotTag), oPlayer, iIngotsSalvaged);
        DestroyObject(oCraftable);
   }
    else if(iIngotsSalvaged == CINT_SALVAGE_UNSKILLED)
    {
        string sFailureString = "The " + GetName(oCraftable) +
                        " is beyond your ability to salvage.";
        FloatingTextStringOnCreature(sFailureString, oPlayer, FALSE);
    }
    else
    {
        DestroyObject(oCraftable);
        string sFailureString = "You have failed to salvage any ingots from the ";
        sFailureString += (GetName(oCraftable) + ".");

        FloatingTextStringOnCreature(sFailureString, oPlayer, FALSE);
    }

}
void main()
{
    string sCraftTag;
    string sMessage;
    object oPlayer = GetPCSpeaker();
    object oCurrentItem = GetFirstItemInInventory();
    if(oCurrentItem == OBJECT_INVALID)
        return;
    do
    {
        sCraftTag = ATS_GetCraftTag(oCurrentItem);
        if(ATS_GetSalvageRate(sCraftTag) == 0)
        {
            sMessage = "The " + GetName(oCurrentItem) + " is not salvageable.";
            AssignCommand(oPlayer, ActionDoCommand(FloatingTextStringOnCreature(sMessage, oPlayer, FALSE)));
            oCurrentItem = GetNextItemInInventory();
            continue;
        }
        AssignCommand(oPlayer, ActionDoCommand(ATS_SalvageCraftable(oPlayer, oCurrentItem)));
        AssignCommand(oPlayer, ActionWait(1.0));

        oCurrentItem = GetNextItemInInventory();
    }
    while(oCurrentItem != OBJECT_INVALID);

}

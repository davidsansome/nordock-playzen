// Dependencies: ats_const_common, ats_inc_material

#include "ats_const_common"
#include "ats_inc_material"
/////////////////////////////////////////////////////
// ATS_IsCraftSingleType                           //
//      Used to determine if a crafting recipe is  //
//      of a single type meaning there are no other//
//      material variations                        //
// Returns: int(boolean) - TRUE if the craft item  //
//                         is of a single type     //
//                         FALSE otherwise         //
/////////////////////////////////////////////////////
int ATS_IsCraftSingleType(string sCraftTag)
{
    return GetLocalInt(GetModule(), sCraftTag + "_singletype");
}

/////////////////////////////////////////////////////
// ATS_GetCraftName                                //
//      Returns the name of the crafted item       //
// Returns: string - craft item's name             //
/////////////////////////////////////////////////////
string ATS_GetCraftName(string sCraftTag)
{
    return GetLocalString(GetModule(), sCraftTag + "_name");
}

/////////////////////////////////////////////////////
// ATS_GetCraftMinSkill                            //
//      Returns the minimum skill value to make the//
//      crafted item                               //
// Returns: int - skill value                      //
/////////////////////////////////////////////////////
int ATS_GetCraftMinSkill(string sCraftTag) // craft tag of the item
{
    return GetLocalInt(GetModule(), sCraftTag + "_minskill");
}

/////////////////////////////////////////////////////
// ATS_GetCraftMaxSkill                            //
//      Returns the trivial skill value to make the//
//      crafted item                               //
// Returns: int - skill value                      //
/////////////////////////////////////////////////////
int ATS_GetCraftMaxSkill(string sCraftTag) // craft tag of the item
{
    return GetLocalInt(GetModule(), sCraftTag + "_maxskill");
}

/////////////////////////////////////////////////////
// ATS_GetCraftSingleTypeResRef                    //
//      Returns the single type craft item's full  //
//      resref                                     //
// Returns: string - item tag                      //
/////////////////////////////////////////////////////
string ATS_GetCraftSingleTypeTag(string sCraftTag)
{
    return GetLocalString(GetModule(), sCraftTag + "_singletype_itemresref");
}

string ATS_GetNextLinkedCraftTag(string sCraftTag)
{
    return GetLocalString(GetModule(), sCraftTag + "_next_recipetag");
}


int ATS_GetFailureProductCount(string sCraftTag)
{
    return GetLocalInt(GetModule(), sCraftTag + "_failureproduct_count");
}

string ATS_GetFailureProduct(string sCraftTag, int iNth)
{
    return GetLocalString(GetModule(), sCraftTag + "_failureproduct" + IntToString(iNth));
}

int ATS_GetFailureProductPercent(string sCraftTag, int iNth)
{
    return GetLocalInt(GetModule(), sCraftTag + "_failureproduct" + IntToString(iNth)
                        + "_chancepercent");
}

int ATS_GetRacialRestriction(string sCraftTag, int iNth = 0)
{
    return GetLocalInt(GetModule(), sCraftTag + "_race_restrict_" + IntToString(iNth));
}

int ATS_GetRacialRestrictionCount(string sCraftTag)
{
    return GetLocalInt(GetModule(), sCraftTag + "_race_restrict_count");
}

int ATS_GetClassRestriction(string sCraftTag, int iNth = 0)
{
    return GetLocalInt(GetModule(), sCraftTag + "_class_restrict_" + IntToString(iNth));
}

int ATS_GetClassRestrictionCount(string sCraftTag)
{
    return GetLocalInt(GetModule(), sCraftTag + "_class_restrict_count");
}

int ATS_GetAlignmentGood(string sCraftTag)
{
    return GetLocalInt(GetModule(), sCraftTag + "_alignment_good");
}

int ATS_GetAlignmentEvil(string sCraftTag)
{
    return GetLocalInt(GetModule(), sCraftTag + "_alignment_evil");
}

int ATS_GetAlignmentLawful(string sCraftTag)
{
    return GetLocalInt(GetModule(), sCraftTag + "_alignment_lawful");
}

int ATS_GetAlignmentNeutral(string sCraftTag)
{
    return GetLocalInt(GetModule(), sCraftTag + "_alignment_neutral");
}

int ATS_GetAlignmentChaotic(string sCraftTag)
{
    return GetLocalInt(GetModule(), sCraftTag + "_alignment_chaotic");
}


/////////////////////////////////////////////////////
// ATS_GetComponentTagFromRecipe                   //
//      Returns the tag of a component of a recipe //
//      for a craftable item                       //
// Returns: string - component tag                 //
/////////////////////////////////////////////////////
string ATS_GetComponentTagFromRecipe
(
string sCraftTag,
int iComponentID,
int iType
)
{
    string sMaterialTag = "";
    if(iComponentID == CINT_COMPONENT_ID_CUSTOM)
    {
        string sCustomMaterialTag = "_custom" + IntToString(iType);
        sMaterialTag = GetLocalString(GetModule(), sCraftTag + sCustomMaterialTag + "_tag");
    }
    else if(iComponentID == CINT_COMPONENT_ID_INGOTS)
        sMaterialTag = "ATS_C_" + CSTR_INGOT_BASETAG + "_N_" + ATS_GetMaterialTag(iType);
    else if(iComponentID == CINT_COMPONENT_ID_GEMS)
        sMaterialTag = "ATS_C_" + CSTR_CUTGEM_BASETAG + "_N_" + ATS_GetMaterialTag(iType);
    else if(iComponentID == CINT_COMPONENT_ID_IDEALGEMS)
        sMaterialTag = "ATS_C_" + CSTR_CUTGEM_BASETAG + "_E_" + ATS_GetMaterialTag(iType);
    else if(iComponentID == CINT_COMPONENT_ID_CLOTHSS)
        sMaterialTag = "ATS_C_" + CSTR_CLOTHSS_BASETAG + "_N_" + ATS_GetMaterialTag(iType);
    else if(iComponentID == CINT_COMPONENT_ID_CLOTHSM)
        sMaterialTag = "ATS_C_" + CSTR_CLOTHSM_BASETAG + "_N_" + ATS_GetMaterialTag(iType);
    else if(iComponentID == CINT_COMPONENT_ID_CLOTHSL)
        sMaterialTag = "ATS_C_" + CSTR_CLOTHSL_BASETAG + "_N_" + ATS_GetMaterialTag(iType);
    else if(iComponentID == CINT_COMPONENT_ID_FLOWERS)
        sMaterialTag = "ATS_FLOWER_" + ATS_GetMaterialTag(iType);
    else if(iComponentID == CINT_COMPONENT_ID_DYES)
        sMaterialTag = "ATS_C_" + CSTR_DYE_BASETAG + "_N_" + ATS_GetMaterialTag(iType);

    return sMaterialTag;

}

/////////////////////////////////////////////////////
// ATS_GetComponentAmountFromRecipe                //
//      Returns the amount of a component of a     //
//      recipe needed to make a craftable item     //
// Returns: int - component amount                 //
/////////////////////////////////////////////////////
int ATS_GetComponentAmountFromRecipe
(
string sCraftTag,
int iComponentID,
int iType
)
{
    int iMaterialAmount = 0;
    if(iComponentID == CINT_COMPONENT_ID_CUSTOM)
    {
        string sCustomMaterialTag = "_custom" + IntToString(iType);
        iMaterialAmount = GetLocalInt(GetModule(), sCraftTag + sCustomMaterialTag + "_amount");
    }
    else if(iComponentID == CINT_COMPONENT_ID_INGOTS)
        iMaterialAmount = GetLocalInt(GetModule(), sCraftTag + "_ingots");
    else if(iComponentID == CINT_COMPONENT_ID_GEMS)
        iMaterialAmount = GetLocalInt(GetModule(), sCraftTag + "_gems");
    else if(iComponentID == CINT_COMPONENT_ID_IDEALGEMS)
        iMaterialAmount = GetLocalInt(GetModule(), sCraftTag + "_idealgems");
    else if(iComponentID == CINT_COMPONENT_ID_CLOTHSS)
        iMaterialAmount = GetLocalInt(GetModule(), sCraftTag + "_clothss");
    else if(iComponentID == CINT_COMPONENT_ID_CLOTHSM)
        iMaterialAmount = GetLocalInt(GetModule(), sCraftTag + "_clothsm");
    else if(iComponentID == CINT_COMPONENT_ID_CLOTHSL)
        iMaterialAmount = GetLocalInt(GetModule(), sCraftTag + "_clothsl");
    else if(iComponentID == CINT_COMPONENT_ID_FLOWERS)
        iMaterialAmount = GetLocalInt(GetModule(), sCraftTag + "_flowers");
    else if(iComponentID == CINT_COMPONENT_ID_DYES)
        iMaterialAmount = GetLocalInt(GetModule(), sCraftTag + "_dyes");

    return iMaterialAmount;

}

/////////////////////////////////////////////////////
// ATS_GetConsumptionRiskFromRecipe                //
//      Returns the risk of component consumption  //
//      on a crafting failure                      //
// Returns: int - percentage of risk               //
/////////////////////////////////////////////////////
int ATS_GetConsumptionRiskFromRecipe
(
string sCraftTag,   // craft tag
int iComponentID,   // an ID constant that denotes type of component
int iType           // the material type or custom component number
)
{
    int iConsumptionRisk = 0;
    if(iComponentID == CINT_COMPONENT_ID_CUSTOM)
    {
        string sCustomMaterialTag = "_custom" + IntToString(iType);
        iConsumptionRisk = GetLocalInt(GetModule(), sCraftTag + sCustomMaterialTag + "_consumption");
    }
    else if(iComponentID == CINT_COMPONENT_ID_INGOTS)
        iConsumptionRisk = GetLocalInt(GetModule(), sCraftTag + "_ingots_consumption");
    else if(iComponentID == CINT_COMPONENT_ID_GEMS)
        iConsumptionRisk = GetLocalInt(GetModule(), sCraftTag + "_gems_consumption");
    else if(iComponentID == CINT_COMPONENT_ID_IDEALGEMS)
        iConsumptionRisk = GetLocalInt(GetModule(), sCraftTag + "_idealgems_consumption");
    else if(iComponentID == CINT_COMPONENT_ID_CLOTHSS)
        iConsumptionRisk = GetLocalInt(GetModule(), sCraftTag + "_clothss_consumption");
    else if(iComponentID == CINT_COMPONENT_ID_CLOTHSM)
        iConsumptionRisk = GetLocalInt(GetModule(), sCraftTag + "_clothsm_consumption");
    else if(iComponentID == CINT_COMPONENT_ID_CLOTHSL)
        iConsumptionRisk = GetLocalInt(GetModule(), sCraftTag + "_clothsl_consumption");
    else if(iComponentID == CINT_COMPONENT_ID_FLOWERS)
        iConsumptionRisk = GetLocalInt(GetModule(), sCraftTag + "_flowers_consumption");
    else if(iComponentID == CINT_COMPONENT_ID_DYES)
        iConsumptionRisk = GetLocalInt(GetModule(), sCraftTag + "_dyes_consumption");

    return iConsumptionRisk;

}



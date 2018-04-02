//Dependencies: ats_const_material, ats_const_skill

/////////////////////////////////////////////////////
// ATS_GetSmeltingLevel                            //
//      Gets the minimum skill level for smelting  //
//      the specified ore material                 //
// Returns: int - minimum skill value              //
/////////////////////////////////////////////////////
int ATS_GetSmeltingLevel
(
int iOreType    // Material constant for an ore
)
{
    if(iOreType == CINT_MATERIAL_COPPER)
        return CINT_SMELTLEVEL_COPPER;
    else if(iOreType == CINT_MATERIAL_BRONZE)
        return CINT_SMELTLEVEL_BRONZE;
    else if(iOreType == CINT_MATERIAL_IRON)
        return CINT_SMELTLEVEL_IRON;
    else if(iOreType == CINT_MATERIAL_SILVER)
        return CINT_SMELTLEVEL_SILVER;
    else if(iOreType == CINT_MATERIAL_GOLD)
        return CINT_SMELTLEVEL_GOLD;
    else if(iOreType == CINT_MATERIAL_SHADOW)
        return CINT_SMELTLEVEL_SHADOW;
    else if(iOreType == CINT_MATERIAL_VERDICITE)
        return CINT_SMELTLEVEL_VERDICITE;
    else if(iOreType == CINT_MATERIAL_RUBICITE)
        return CINT_SMELTLEVEL_RUBICITE;
    else if(iOreType == CINT_MATERIAL_SYENITE)
        return CINT_SMELTLEVEL_SYENITE;
    else if(iOreType == CINT_MATERIAL_MITHRAL)
        return CINT_SMELTLEVEL_MITHRAL;
    else if(iOreType == CINT_MATERIAL_ADAMANTINE)
        return CINT_SMELTLEVEL_ADAMANTINE;
    else if(iOreType == CINT_MATERIAL_MYRKANDITE)
        return CINT_SMELTLEVEL_MYRKANDITE;
    else
        return 0;
}

//Dependencies: ats_const_mat, ats_config



/////////////////////////// /////////////////////////
// ATS_GetMaterialTypeFromTag                      //
//      Gets an item's material type constant      //
// Returns: int - Material Type constant           //
/////////////////////////////////////////////////////
int ATS_GetMaterialTypeFromTag(string sItemTag)
{
    string sMaterialID;

    // If the tag passed in is just the material tag
    if(GetStringLength(sItemTag) == 3)
        sMaterialID = sItemTag;
    else
        //Grab the tag from the item tag
        sMaterialID = GetSubString(sItemTag, 13, 3);

    if(sMaterialID == CSTR_MATERIAL_ID_IRON)
        return CINT_MATERIAL_IRON;
    else if(sMaterialID == CSTR_MATERIAL_ID_COPPER)
        return CINT_MATERIAL_COPPER;
    else if(sMaterialID == CSTR_MATERIAL_ID_BRONZE)
        return CINT_MATERIAL_BRONZE;
    else if(sMaterialID == CSTR_MATERIAL_ID_SILVER)
        return CINT_MATERIAL_SILVER;
    else if(sMaterialID == CSTR_MATERIAL_ID_GOLD)
        return CINT_MATERIAL_GOLD;
    else if(sMaterialID == CSTR_MATERIAL_ID_SHADOW)
        return CINT_MATERIAL_SHADOW;
    else if(sMaterialID == CSTR_MATERIAL_ID_VERDICITE)
        return CINT_MATERIAL_VERDICITE;
    else if(sMaterialID == CSTR_MATERIAL_ID_RUBICITE)
        return CINT_MATERIAL_RUBICITE;
    else if(sMaterialID == CSTR_MATERIAL_ID_SYENITE)
        return CINT_MATERIAL_SYENITE;
    else if(sMaterialID == CSTR_MATERIAL_ID_MITHRAL)
        return CINT_MATERIAL_MITHRAL;
    else if(sMaterialID == CSTR_MATERIAL_ID_ADAMANTINE)
        return CINT_MATERIAL_ADAMANTINE;
    else if(sMaterialID == CSTR_MATERIAL_ID_MYRKANDITE)
        return CINT_MATERIAL_MYRKANDITE;
    else if(sMaterialID == CSTR_MATERIAL_ID_CLOTH)
        return CINT_MATERIAL_CLOTH;
    else if(sMaterialID == CSTR_MATERIAL_ID_SLH)
        return CINT_MATERIAL_SLH;
    else if(sMaterialID == CSTR_MATERIAL_ID_MLH)
        return CINT_MATERIAL_MLH;
    else if(sMaterialID == CSTR_MATERIAL_ID_LLH)
        return CINT_MATERIAL_LLH;
   else if(sMaterialID == CSTR_MATERIAL_ID_MALACHITE)
        return CINT_MATERIAL_MALACHITE;
    else if(sMaterialID == CSTR_MATERIAL_ID_AMETHYST)
        return CINT_MATERIAL_AMETHYST;
    else if(sMaterialID == CSTR_MATERIAL_ID_JADE)
        return CINT_MATERIAL_JADE;
    else if(sMaterialID == CSTR_MATERIAL_ID_LAPIS_LAZULI)
        return CINT_MATERIAL_LAPIS_LAZULI;
    else if(sMaterialID == CSTR_MATERIAL_ID_TURQUOISE)
        return CINT_MATERIAL_TURQUOISE;
    else if(sMaterialID == CSTR_MATERIAL_ID_OPAL)
        return CINT_MATERIAL_OPAL;
    else if(sMaterialID == CSTR_MATERIAL_ID_ONYX)
        return CINT_MATERIAL_ONYX;
    else if(sMaterialID == CSTR_MATERIAL_ID_PEARL)
        return CINT_MATERIAL_PEARL;
    else if(sMaterialID == CSTR_MATERIAL_ID_SAPPHIRE)
        return CINT_MATERIAL_SAPPHIRE;
    else if(sMaterialID == CSTR_MATERIAL_ID_BLACK_SAPPHIRE)
        return CINT_MATERIAL_BLACK_SAPPHIRE;
    else if(sMaterialID == CSTR_MATERIAL_ID_FIRE_OPAL)
        return CINT_MATERIAL_FIRE_OPAL;
    else if(sMaterialID == CSTR_MATERIAL_ID_RUBY)
        return CINT_MATERIAL_RUBY ;
    else if(sMaterialID == CSTR_MATERIAL_ID_EMERALD)
        return CINT_MATERIAL_EMERALD;
    else if(sMaterialID == CSTR_MATERIAL_ID_DIAMOND)
        return CINT_MATERIAL_DIAMOND;
    else if(sMaterialID == CSTR_MATERIAL_ID_OAK)
        return CINT_MATERIAL_OAK;
    else if(sMaterialID == CSTR_MATERIAL_ID_ELM)
        return CINT_MATERIAL_ELM;
    else if(sMaterialID == CSTR_MATERIAL_ID_ASH)
        return CINT_MATERIAL_ASH;
    else if(sMaterialID == CSTR_MATERIAL_ID_ARR)
        return CINT_MATERIAL_ARR;
    else if(sMaterialID == CSTR_MATERIAL_ID_C01)
        return CINT_MATERIAL_C01;
    else if(sMaterialID == CSTR_MATERIAL_ID_C02)
        return CINT_MATERIAL_C02;
    else if(sMaterialID == CSTR_MATERIAL_ID_C03)
        return CINT_MATERIAL_C03;
    else if(sMaterialID == CSTR_MATERIAL_ID_C04)
        return CINT_MATERIAL_C04;
    else if(sMaterialID == CSTR_MATERIAL_ID_C05)
        return CINT_MATERIAL_C05;
    else if(sMaterialID == CSTR_MATERIAL_ID_C06)
        return CINT_MATERIAL_C06;
    else if(sMaterialID == CSTR_MATERIAL_ID_C07)
        return CINT_MATERIAL_C07;
    else if(sMaterialID == CSTR_MATERIAL_ID_C08)
        return CINT_MATERIAL_C08;
    else if(sMaterialID == CSTR_MATERIAL_ID_C09)
        return CINT_MATERIAL_C09;
    else if(sMaterialID == CSTR_MATERIAL_ID_C10)
        return CINT_MATERIAL_C10;
    else if(sMaterialID == CSTR_MATERIAL_ID_C11)
        return CINT_MATERIAL_C11;
    else if(sMaterialID == CSTR_MATERIAL_ID_C12)
        return CINT_MATERIAL_C12;
    else if(sMaterialID == CSTR_MATERIAL_ID_C13)
        return CINT_MATERIAL_C13;
    else if(sMaterialID == CSTR_MATERIAL_ID_C14)
        return CINT_MATERIAL_C14;
    else if(sMaterialID == CSTR_MATERIAL_ID_C15)
        return CINT_MATERIAL_C15;
    else if(sMaterialID == CSTR_MATERIAL_ID_C16)
        return CINT_MATERIAL_C16;
    else if(sMaterialID == CSTR_MATERIAL_ID_C17)
        return CINT_MATERIAL_C17;
    else if(sMaterialID == CSTR_MATERIAL_ID_C18)
        return CINT_MATERIAL_C18;
    else if(sMaterialID == CSTR_MATERIAL_ID_ALK)
        return CINT_MATERIAL_ALK;
    else
        return CINT_MATERIAL_UNKNOWN;
}

/////////////////////////////////////////////////////
// ATS_GetMaterialType                             //
//      Gets an item's material type constant      //
// Returns: int - Material Type constant           //
/////////////////////////////////////////////////////
int ATS_GetMaterialType(object oTargetItem)
{
    string sObjectTag = GetTag(oTargetItem);

    return ATS_GetMaterialTypeFromTag(sObjectTag);

}
/////////////////////////////////////////////////////
// ATS_GetMaterialTag                              //
//      Translates the material type constant into //
//      a 3 character string equivalent which is   //
//      also the last 3 characters of any crafted  //
//      item's tag                                 //
// Returns: string - Material Type tag             //
/////////////////////////////////////////////////////
string ATS_GetMaterialTag
(
int iMaterialType   // Material type constant
)
{
    if(iMaterialType == CINT_MATERIAL_COPPER)
        return CSTR_MATERIAL_ID_COPPER;
    else if(iMaterialType == CINT_MATERIAL_BRONZE)
        return CSTR_MATERIAL_ID_BRONZE;
    else if(iMaterialType == CINT_MATERIAL_IRON)
        return CSTR_MATERIAL_ID_IRON;
    else if(iMaterialType == CINT_MATERIAL_SILVER)
        return CSTR_MATERIAL_ID_SILVER;
    else if(iMaterialType == CINT_MATERIAL_GOLD)
        return CSTR_MATERIAL_ID_GOLD;
    else if(iMaterialType == CINT_MATERIAL_SHADOW)
        return CSTR_MATERIAL_ID_SHADOW;
    else if(iMaterialType == CINT_MATERIAL_VERDICITE)
        return CSTR_MATERIAL_ID_VERDICITE;
    else if(iMaterialType == CINT_MATERIAL_RUBICITE)
        return CSTR_MATERIAL_ID_RUBICITE;
    else if(iMaterialType == CINT_MATERIAL_SYENITE)
        return CSTR_MATERIAL_ID_SYENITE;
    else if(iMaterialType == CINT_MATERIAL_MITHRAL)
        return CSTR_MATERIAL_ID_MITHRAL;
    else if(iMaterialType == CINT_MATERIAL_ADAMANTINE)
        return CSTR_MATERIAL_ID_ADAMANTINE;
    else if(iMaterialType == CINT_MATERIAL_MYRKANDITE)
        return CSTR_MATERIAL_ID_MYRKANDITE;
    else if(iMaterialType == CINT_MATERIAL_CLOTH)
        return CSTR_MATERIAL_ID_CLOTH;
    else if(iMaterialType == CINT_MATERIAL_SLH)
        return CSTR_MATERIAL_ID_SLH;
    else if(iMaterialType == CINT_MATERIAL_MLH)
        return CSTR_MATERIAL_ID_MLH;
    else if(iMaterialType == CINT_MATERIAL_LLH)
        return CSTR_MATERIAL_ID_LLH;
   else if(iMaterialType == CINT_MATERIAL_MALACHITE)
        return CSTR_MATERIAL_ID_MALACHITE;
    else if(iMaterialType == CINT_MATERIAL_AMETHYST)
        return CSTR_MATERIAL_ID_AMETHYST;
    else if(iMaterialType == CINT_MATERIAL_JADE)
        return CSTR_MATERIAL_ID_JADE;
    else if(iMaterialType == CINT_MATERIAL_LAPIS_LAZULI)
        return CSTR_MATERIAL_ID_LAPIS_LAZULI;
    else if(iMaterialType == CINT_MATERIAL_TURQUOISE)
        return CSTR_MATERIAL_ID_TURQUOISE;
    else if(iMaterialType == CINT_MATERIAL_OPAL)
        return CSTR_MATERIAL_ID_OPAL;
    else if(iMaterialType == CINT_MATERIAL_ONYX)
        return CSTR_MATERIAL_ID_ONYX;
    else if(iMaterialType == CINT_MATERIAL_PEARL)
        return CSTR_MATERIAL_ID_PEARL;
    else if(iMaterialType == CINT_MATERIAL_SAPPHIRE)
        return CSTR_MATERIAL_ID_SAPPHIRE;
    else if(iMaterialType == CINT_MATERIAL_BLACK_SAPPHIRE)
        return CSTR_MATERIAL_ID_BLACK_SAPPHIRE;
    else if(iMaterialType == CINT_MATERIAL_FIRE_OPAL)
        return CSTR_MATERIAL_ID_FIRE_OPAL;
    else if(iMaterialType == CINT_MATERIAL_RUBY)
        return CSTR_MATERIAL_ID_RUBY ;
    else if(iMaterialType == CINT_MATERIAL_EMERALD)
        return CSTR_MATERIAL_ID_EMERALD;
    else if(iMaterialType == CINT_MATERIAL_DIAMOND)
        return CSTR_MATERIAL_ID_DIAMOND;
    else if(iMaterialType == CINT_MATERIAL_OAK)
        return CSTR_MATERIAL_ID_OAK;
    else if(iMaterialType == CINT_MATERIAL_ELM)
        return CSTR_MATERIAL_ID_ELM;
    else if(iMaterialType == CINT_MATERIAL_ASH)
        return CSTR_MATERIAL_ID_ASH;
    else if(iMaterialType == CINT_MATERIAL_ARR)
        return CSTR_MATERIAL_ID_ARR;
    else if(iMaterialType == CINT_MATERIAL_C01)
        return CSTR_MATERIAL_ID_C01;
    else if(iMaterialType == CINT_MATERIAL_C02)
        return CSTR_MATERIAL_ID_C02;
    else if(iMaterialType == CINT_MATERIAL_C03)
        return CSTR_MATERIAL_ID_C03;
    else if(iMaterialType == CINT_MATERIAL_C04)
        return CSTR_MATERIAL_ID_C04;
    else if(iMaterialType == CINT_MATERIAL_C05)
        return CSTR_MATERIAL_ID_C05;
    else if(iMaterialType == CINT_MATERIAL_C06)
        return CSTR_MATERIAL_ID_C06;
    else if(iMaterialType == CINT_MATERIAL_C07)
        return CSTR_MATERIAL_ID_C07;
    else if(iMaterialType == CINT_MATERIAL_C08)
        return CSTR_MATERIAL_ID_C08;
    else if(iMaterialType == CINT_MATERIAL_C09)
        return CSTR_MATERIAL_ID_C09;
    else if(iMaterialType == CINT_MATERIAL_C10)
        return CSTR_MATERIAL_ID_C10;
    else if(iMaterialType == CINT_MATERIAL_C11)
        return CSTR_MATERIAL_ID_C11;
    else if(iMaterialType == CINT_MATERIAL_C12)
        return CSTR_MATERIAL_ID_C12;
    else if(iMaterialType == CINT_MATERIAL_C13)
        return CSTR_MATERIAL_ID_C13;
    else if(iMaterialType == CINT_MATERIAL_C14)
        return CSTR_MATERIAL_ID_C14;
    else if(iMaterialType == CINT_MATERIAL_C15)
        return CSTR_MATERIAL_ID_C15;
    else if(iMaterialType == CINT_MATERIAL_C16)
        return CSTR_MATERIAL_ID_C16;
    else if(iMaterialType == CINT_MATERIAL_C17)
        return CSTR_MATERIAL_ID_C17;
    else if(iMaterialType == CINT_MATERIAL_C18)
        return CSTR_MATERIAL_ID_C18;
    else if(iMaterialType == CINT_MATERIAL_ALK)
        return CSTR_MATERIAL_ID_ALK;
    else
        return "NON"; // Unknown material
}




/////////////////////////////////////////////////////
// ATS_GetMaterialName                             //
//      Returns the string name of the passed in   //
//      material type constant                     //
// Returns: string - material name                 //
/////////////////////////////////////////////////////
string ATS_GetMaterialName(int iMaterialType)
{
    if(iMaterialType == CINT_MATERIAL_COPPER)
        return CSTR_MATERIAL_COPPER;
    else if(iMaterialType == CINT_MATERIAL_BRONZE)
        return CSTR_MATERIAL_BRONZE;
    else if(iMaterialType == CINT_MATERIAL_IRON)
        return CSTR_MATERIAL_IRON;
    else if(iMaterialType == CINT_MATERIAL_SILVER)
        return CSTR_MATERIAL_SILVER;
    else if(iMaterialType == CINT_MATERIAL_GOLD)
        return CSTR_MATERIAL_GOLD;
    else if(iMaterialType == CINT_MATERIAL_SHADOW)
        return CSTR_MATERIAL_SHADOW;
    else if(iMaterialType == CINT_MATERIAL_VERDICITE)
        return CSTR_MATERIAL_VERDICITE;
    else if(iMaterialType == CINT_MATERIAL_RUBICITE)
        return CSTR_MATERIAL_RUBICITE;
    else if(iMaterialType == CINT_MATERIAL_SYENITE)
        return CSTR_MATERIAL_SYENITE;
    else if(iMaterialType == CINT_MATERIAL_MITHRAL)
        return CSTR_MATERIAL_MITHRAL;
    else if(iMaterialType == CINT_MATERIAL_ADAMANTINE)
        return CSTR_MATERIAL_ADAMANTINE;
    else if(iMaterialType == CINT_MATERIAL_MYRKANDITE)
        return CSTR_MATERIAL_MYRKANDITE;
    else if(iMaterialType == CINT_MATERIAL_CLOTH)
        return CSTR_MATERIAL_CLOTH;
    else if(iMaterialType == CINT_MATERIAL_SLH)
        return CSTR_MATERIAL_SLH;
    else if(iMaterialType == CINT_MATERIAL_MLH)
        return CSTR_MATERIAL_MLH;
    else if(iMaterialType == CINT_MATERIAL_LLH)
        return CSTR_MATERIAL_LLH;
   else if(iMaterialType == CINT_MATERIAL_MALACHITE)
        return CSTR_MATERIAL_MALACHITE;
    else if(iMaterialType == CINT_MATERIAL_AMETHYST)
        return CSTR_MATERIAL_AMETHYST;
    else if(iMaterialType == CINT_MATERIAL_JADE)
        return CSTR_MATERIAL_JADE;
    else if(iMaterialType == CINT_MATERIAL_LAPIS_LAZULI)
        return CSTR_MATERIAL_LAPIS_LAZULI;
    else if(iMaterialType == CINT_MATERIAL_TURQUOISE)
        return CSTR_MATERIAL_TURQUOISE;
    else if(iMaterialType == CINT_MATERIAL_OPAL)
        return CSTR_MATERIAL_OPAL;
    else if(iMaterialType == CINT_MATERIAL_ONYX)
        return CSTR_MATERIAL_ONYX;
    else if(iMaterialType == CINT_MATERIAL_PEARL)
        return CSTR_MATERIAL_PEARL;
    else if(iMaterialType == CINT_MATERIAL_SAPPHIRE)
        return CSTR_MATERIAL_SAPPHIRE;
    else if(iMaterialType == CINT_MATERIAL_BLACK_SAPPHIRE)
        return CSTR_MATERIAL_BLACK_SAPPHIRE;
    else if(iMaterialType == CINT_MATERIAL_FIRE_OPAL)
        return CSTR_MATERIAL_FIRE_OPAL;
    else if(iMaterialType == CINT_MATERIAL_RUBY)
        return CSTR_MATERIAL_RUBY ;
    else if(iMaterialType == CINT_MATERIAL_EMERALD)
        return CSTR_MATERIAL_EMERALD;
    else if(iMaterialType == CINT_MATERIAL_DIAMOND)
        return CSTR_MATERIAL_DIAMOND;
    else if(iMaterialType == CINT_MATERIAL_OAK)
        return CSTR_MATERIAL_OAK;
    else if(iMaterialType == CINT_MATERIAL_ELM)
        return CSTR_MATERIAL_ELM;
    else if(iMaterialType == CINT_MATERIAL_ASH)
        return CSTR_MATERIAL_ASH;
    else if(iMaterialType == CINT_MATERIAL_ARR)
        return CSTR_MATERIAL_ARR;
    else if(iMaterialType == CINT_MATERIAL_C01)
        return CSTR_MATERIAL_C01;
    else if(iMaterialType == CINT_MATERIAL_C02)
        return CSTR_MATERIAL_C02;
    else if(iMaterialType == CINT_MATERIAL_C03)
        return CSTR_MATERIAL_C03;
    else if(iMaterialType == CINT_MATERIAL_C04)
        return CSTR_MATERIAL_C04;
    else if(iMaterialType == CINT_MATERIAL_C05)
        return CSTR_MATERIAL_C05;
    else if(iMaterialType == CINT_MATERIAL_C06)
        return CSTR_MATERIAL_C06;
    else if(iMaterialType == CINT_MATERIAL_C07)
        return CSTR_MATERIAL_C07;
    else if(iMaterialType == CINT_MATERIAL_C08)
        return CSTR_MATERIAL_C08;
    else if(iMaterialType == CINT_MATERIAL_C09)
        return CSTR_MATERIAL_C09;
    else if(iMaterialType == CINT_MATERIAL_C10)
        return CSTR_MATERIAL_C10;
    else if(iMaterialType == CINT_MATERIAL_C11)
        return CSTR_MATERIAL_C11;
    else if(iMaterialType == CINT_MATERIAL_C12)
        return CSTR_MATERIAL_C12;
    else if(iMaterialType == CINT_MATERIAL_C13)
        return CSTR_MATERIAL_C13;
    else if(iMaterialType == CINT_MATERIAL_C14)
        return CSTR_MATERIAL_C14;
    else if(iMaterialType == CINT_MATERIAL_C15)
        return CSTR_MATERIAL_C15;
    else if(iMaterialType == CINT_MATERIAL_C16)
        return CSTR_MATERIAL_C16;
    else if(iMaterialType == CINT_MATERIAL_C17)
        return CSTR_MATERIAL_C17;
    else if(iMaterialType == CINT_MATERIAL_C18)
        return CSTR_MATERIAL_C18;
    else
        return "";

}
/////////////////////////////////////////////////////
// ATS_GetMaterialMinBonus                         //
//      Returns the material skill adjustment for  //
//      the min value of a skill                   //
// Returns: int - skill value adjustment           //
/////////////////////////////////////////////////////
int ATS_GetMaterialMinBonus(int iMaterialType)  // material type constant
{
    if(iMaterialType == CINT_MATERIAL_COPPER)
        return CINT_MATERIAL_MINBONUS_COPPER;
    else if(iMaterialType == CINT_MATERIAL_BRONZE)
        return CINT_MATERIAL_MINBONUS_BRONZE;
    else if(iMaterialType == CINT_MATERIAL_IRON)
        return CINT_MATERIAL_MINBONUS_IRON;
    else if(iMaterialType == CINT_MATERIAL_SILVER)
        return CINT_MATERIAL_MINBONUS_SILVER;
    else if(iMaterialType == CINT_MATERIAL_GOLD)
        return CINT_MATERIAL_MINBONUS_GOLD;
    else if(iMaterialType == CINT_MATERIAL_SHADOW)
        return CINT_MATERIAL_MINBONUS_SHADOW;
    else if(iMaterialType == CINT_MATERIAL_RUBICITE)
        return CINT_MATERIAL_MINBONUS_RUBICITE;
    else if(iMaterialType == CINT_MATERIAL_VERDICITE)
        return CINT_MATERIAL_MINBONUS_VERDICITE;
    else if(iMaterialType == CINT_MATERIAL_SYENITE)
        return CINT_MATERIAL_MINBONUS_SYENITE;
    else if(iMaterialType == CINT_MATERIAL_MITHRAL)
        return CINT_MATERIAL_MINBONUS_MITHRAL;
    else if(iMaterialType == CINT_MATERIAL_ADAMANTINE)
        return CINT_MATERIAL_MINBONUS_ADAMANTINE;
    else if(iMaterialType == CINT_MATERIAL_MYRKANDITE)
        return CINT_MATERIAL_MINBONUS_MYRKANDITE;
   else if(iMaterialType == CINT_MATERIAL_MALACHITE)
        return CINT_MATERIAL_MINBONUS_MALACHITE;
    else if(iMaterialType == CINT_MATERIAL_AMETHYST)
        return CINT_MATERIAL_MINBONUS_AMETHYST;
    else if(iMaterialType == CINT_MATERIAL_JADE)
        return CINT_MATERIAL_MINBONUS_JADE;
    else if(iMaterialType == CINT_MATERIAL_LAPIS_LAZULI)
        return CINT_MATERIAL_MINBONUS_LAPIS_LAZULI;
    else if(iMaterialType == CINT_MATERIAL_TURQUOISE)
        return CINT_MATERIAL_MINBONUS_TURQUOISE;
    else if(iMaterialType == CINT_MATERIAL_OPAL)
        return CINT_MATERIAL_MINBONUS_OPAL;
    else if(iMaterialType == CINT_MATERIAL_ONYX)
        return CINT_MATERIAL_MINBONUS_ONYX;
    else if(iMaterialType == CINT_MATERIAL_PEARL)
        return CINT_MATERIAL_MINBONUS_PEARL;
    else if(iMaterialType == CINT_MATERIAL_SAPPHIRE)
        return CINT_MATERIAL_MINBONUS_SAPPHIRE;
    else if(iMaterialType == CINT_MATERIAL_BLACK_SAPPHIRE)
        return CINT_MATERIAL_MINBONUS_BLACK_SAPPHIRE;
    else if(iMaterialType == CINT_MATERIAL_FIRE_OPAL)
        return CINT_MATERIAL_MINBONUS_FIRE_OPAL;
    else if(iMaterialType == CINT_MATERIAL_RUBY)
        return CINT_MATERIAL_MINBONUS_RUBY ;
    else if(iMaterialType == CINT_MATERIAL_EMERALD)
        return CINT_MATERIAL_MINBONUS_EMERALD;
    else if(iMaterialType == CINT_MATERIAL_DIAMOND)
        return CINT_MATERIAL_MINBONUS_DIAMOND;
    else if(iMaterialType == CINT_MATERIAL_OAK)
        return CINT_MATERIAL_MINBONUS_OAK;
    else if(iMaterialType == CINT_MATERIAL_ELM)
        return CINT_MATERIAL_MINBONUS_ELM;
    else if(iMaterialType == CINT_MATERIAL_ASH)
        return CINT_MATERIAL_MINBONUS_ASH;
    else if(iMaterialType == CINT_MATERIAL_ARR)
        return CINT_MATERIAL_MINBONUS_ARR;
    else if(iMaterialType == CINT_MATERIAL_C01)
        return CINT_MATERIAL_MINBONUS_C01;
    else if(iMaterialType == CINT_MATERIAL_C02)
        return CINT_MATERIAL_MINBONUS_C02;
    else if(iMaterialType == CINT_MATERIAL_C03)
        return CINT_MATERIAL_MINBONUS_C03;
    else if(iMaterialType == CINT_MATERIAL_C04)
        return CINT_MATERIAL_MINBONUS_C04;
    else if(iMaterialType == CINT_MATERIAL_C05)
        return CINT_MATERIAL_MINBONUS_C05;
    else if(iMaterialType == CINT_MATERIAL_C06)
        return CINT_MATERIAL_MINBONUS_C06;
    else if(iMaterialType == CINT_MATERIAL_C07)
        return CINT_MATERIAL_MINBONUS_C07;
    else if(iMaterialType == CINT_MATERIAL_C08)
        return CINT_MATERIAL_MINBONUS_C08;
    else if(iMaterialType == CINT_MATERIAL_C09)
        return CINT_MATERIAL_MINBONUS_C09;
    else if(iMaterialType == CINT_MATERIAL_C10)
        return CINT_MATERIAL_MINBONUS_C10;
    else if(iMaterialType == CINT_MATERIAL_C11)
        return CINT_MATERIAL_MINBONUS_C11;
    else if(iMaterialType == CINT_MATERIAL_C12)
        return CINT_MATERIAL_MINBONUS_C12;
    else if(iMaterialType == CINT_MATERIAL_C13)
        return CINT_MATERIAL_MINBONUS_C13;
    else if(iMaterialType == CINT_MATERIAL_C14)
        return CINT_MATERIAL_MINBONUS_C14;
    else if(iMaterialType == CINT_MATERIAL_C15)
        return CINT_MATERIAL_MINBONUS_C15;
    else if(iMaterialType == CINT_MATERIAL_C16)
        return CINT_MATERIAL_MINBONUS_C16;
    else if(iMaterialType == CINT_MATERIAL_C17)
        return CINT_MATERIAL_MINBONUS_C17;
    else if(iMaterialType == CINT_MATERIAL_C18)
        return CINT_MATERIAL_MINBONUS_C18;
    else
        return 0;

}

/////////////////////////////////////////////////////
// ATS_GetMaterialMaxBonus                         //
//      Returns the material skill adjustment for  //
//      the max value of a skill                   //
// Returns: int - skill value adjustment           //
/////////////////////////////////////////////////////
int ATS_GetMaterialMaxBonus(int iMaterialType)  // material type constant
{
    if(iMaterialType == CINT_MATERIAL_COPPER)
        return CINT_MATERIAL_MAXBONUS_COPPER;
    else if(iMaterialType == CINT_MATERIAL_BRONZE)
        return CINT_MATERIAL_MAXBONUS_BRONZE;
    else if(iMaterialType == CINT_MATERIAL_IRON)
        return CINT_MATERIAL_MAXBONUS_IRON;
    else if(iMaterialType == CINT_MATERIAL_SILVER)
        return CINT_MATERIAL_MAXBONUS_SILVER;
    else if(iMaterialType == CINT_MATERIAL_GOLD)
        return CINT_MATERIAL_MAXBONUS_GOLD;
    else if(iMaterialType == CINT_MATERIAL_SHADOW)
        return CINT_MATERIAL_MAXBONUS_SHADOW;
    else if(iMaterialType == CINT_MATERIAL_RUBICITE)
        return CINT_MATERIAL_MAXBONUS_RUBICITE;
    else if(iMaterialType == CINT_MATERIAL_VERDICITE)
        return CINT_MATERIAL_MAXBONUS_VERDICITE;
    else if(iMaterialType == CINT_MATERIAL_SYENITE)
        return CINT_MATERIAL_MAXBONUS_SYENITE;
    else if(iMaterialType == CINT_MATERIAL_MITHRAL)
        return CINT_MATERIAL_MAXBONUS_MITHRAL;
    else if(iMaterialType == CINT_MATERIAL_ADAMANTINE)
        return CINT_MATERIAL_MAXBONUS_ADAMANTINE;
    else if(iMaterialType == CINT_MATERIAL_MYRKANDITE)
        return CINT_MATERIAL_MAXBONUS_MYRKANDITE;
   else if(iMaterialType == CINT_MATERIAL_MALACHITE)
        return CINT_MATERIAL_MAXBONUS_MALACHITE;
    else if(iMaterialType == CINT_MATERIAL_AMETHYST)
        return CINT_MATERIAL_MAXBONUS_AMETHYST;
    else if(iMaterialType == CINT_MATERIAL_JADE)
        return CINT_MATERIAL_MAXBONUS_JADE;
    else if(iMaterialType == CINT_MATERIAL_LAPIS_LAZULI)
        return CINT_MATERIAL_MAXBONUS_LAPIS_LAZULI;
    else if(iMaterialType == CINT_MATERIAL_TURQUOISE)
        return CINT_MATERIAL_MAXBONUS_TURQUOISE;
    else if(iMaterialType == CINT_MATERIAL_OPAL)
        return CINT_MATERIAL_MAXBONUS_OPAL;
    else if(iMaterialType == CINT_MATERIAL_ONYX)
        return CINT_MATERIAL_MAXBONUS_ONYX;
    else if(iMaterialType == CINT_MATERIAL_PEARL)
        return CINT_MATERIAL_MAXBONUS_PEARL;
    else if(iMaterialType == CINT_MATERIAL_SAPPHIRE)
        return CINT_MATERIAL_MAXBONUS_SAPPHIRE;
    else if(iMaterialType == CINT_MATERIAL_BLACK_SAPPHIRE)
        return CINT_MATERIAL_MAXBONUS_BLACK_SAPPHIRE;
    else if(iMaterialType == CINT_MATERIAL_FIRE_OPAL)
        return CINT_MATERIAL_MAXBONUS_FIRE_OPAL;
    else if(iMaterialType == CINT_MATERIAL_RUBY)
        return CINT_MATERIAL_MAXBONUS_RUBY ;
    else if(iMaterialType == CINT_MATERIAL_EMERALD)
        return CINT_MATERIAL_MAXBONUS_EMERALD;
    else if(iMaterialType == CINT_MATERIAL_DIAMOND)
        return CINT_MATERIAL_MAXBONUS_DIAMOND;
    else if(iMaterialType == CINT_MATERIAL_OAK)
        return CINT_MATERIAL_MAXBONUS_OAK;
    else if(iMaterialType == CINT_MATERIAL_ELM)
        return CINT_MATERIAL_MAXBONUS_ELM;
    else if(iMaterialType == CINT_MATERIAL_ASH)
        return CINT_MATERIAL_MAXBONUS_ASH;
    else if(iMaterialType == CINT_MATERIAL_ARR)
        return CINT_MATERIAL_MAXBONUS_ARR;
    else if(iMaterialType == CINT_MATERIAL_C01)
        return CINT_MATERIAL_MAXBONUS_C01;
    else if(iMaterialType == CINT_MATERIAL_C02)
        return CINT_MATERIAL_MAXBONUS_C02;
    else if(iMaterialType == CINT_MATERIAL_C03)
        return CINT_MATERIAL_MAXBONUS_C03;
    else if(iMaterialType == CINT_MATERIAL_C04)
        return CINT_MATERIAL_MAXBONUS_C04;
    else if(iMaterialType == CINT_MATERIAL_C05)
        return CINT_MATERIAL_MAXBONUS_C05;
    else if(iMaterialType == CINT_MATERIAL_C06)
        return CINT_MATERIAL_MAXBONUS_C06;
    else if(iMaterialType == CINT_MATERIAL_C07)
        return CINT_MATERIAL_MAXBONUS_C07;
    else if(iMaterialType == CINT_MATERIAL_C08)
        return CINT_MATERIAL_MAXBONUS_C08;
    else if(iMaterialType == CINT_MATERIAL_C09)
        return CINT_MATERIAL_MAXBONUS_C09;
    else if(iMaterialType == CINT_MATERIAL_C10)
        return CINT_MATERIAL_MAXBONUS_C10;
    else if(iMaterialType == CINT_MATERIAL_C11)
        return CINT_MATERIAL_MAXBONUS_C11;
    else if(iMaterialType == CINT_MATERIAL_C12)
        return CINT_MATERIAL_MAXBONUS_C12;
    else if(iMaterialType == CINT_MATERIAL_C13)
        return CINT_MATERIAL_MAXBONUS_C13;
    else if(iMaterialType == CINT_MATERIAL_C14)
        return CINT_MATERIAL_MAXBONUS_C14;
    else if(iMaterialType == CINT_MATERIAL_C15)
        return CINT_MATERIAL_MAXBONUS_C15;
    else if(iMaterialType == CINT_MATERIAL_C16)
        return CINT_MATERIAL_MAXBONUS_C16;
    else if(iMaterialType == CINT_MATERIAL_C17)
        return CINT_MATERIAL_MAXBONUS_C17;
    else if(iMaterialType == CINT_MATERIAL_C18)
        return CINT_MATERIAL_MAXBONUS_C18;
    else
        return 0;

}
/////////////////////////////////////////////////////
// ATS_GetDefaultMaterialDurability                //
//      Returns the default durability of a        //
//      material                                   //
// Returns: int - skill value adjustment           //
/////////////////////////////////////////////////////
int ATS_GetDefaultMaterialDurability(int iMaterialType)  // material type constant
{
    if(iMaterialType == CINT_MATERIAL_COPPER)
        return CINT_MATERIAL_DURABILITY_COPPER;
    else if(iMaterialType == CINT_MATERIAL_BRONZE)
        return CINT_MATERIAL_DURABILITY_BRONZE;
    else if(iMaterialType == CINT_MATERIAL_IRON)
        return CINT_MATERIAL_DURABILITY_IRON;
    else if(iMaterialType == CINT_MATERIAL_SILVER)
        return CINT_MATERIAL_DURABILITY_SILVER;
    else if(iMaterialType == CINT_MATERIAL_GOLD)
        return CINT_MATERIAL_DURABILITY_GOLD;
    else if(iMaterialType == CINT_MATERIAL_SHADOW)
        return CINT_MATERIAL_DURABILITY_SHADOW;
    else if(iMaterialType == CINT_MATERIAL_RUBICITE)
        return CINT_MATERIAL_DURABILITY_RUBICITE;
    else if(iMaterialType == CINT_MATERIAL_VERDICITE)
        return CINT_MATERIAL_DURABILITY_VERDICITE;
    else if(iMaterialType == CINT_MATERIAL_SYENITE)
        return CINT_MATERIAL_DURABILITY_SYENITE;
    else if(iMaterialType == CINT_MATERIAL_MITHRAL)
        return CINT_MATERIAL_DURABILITY_MITHRAL;
    else if(iMaterialType == CINT_MATERIAL_ADAMANTINE)
        return CINT_MATERIAL_DURABILITY_ADAMANTINE;
    else if(iMaterialType == CINT_MATERIAL_MYRKANDITE)
        return CINT_MATERIAL_DURABILITY_MYRKANDITE;
    else if(iMaterialType == CINT_MATERIAL_OAK)
        return CINT_MATERIAL_DURABILITY_OAK;
    else if(iMaterialType == CINT_MATERIAL_ELM)
        return CINT_MATERIAL_DURABILITY_ELM;
    else if(iMaterialType == CINT_MATERIAL_ASH)
        return CINT_MATERIAL_DURABILITY_ASH;
    else if(iMaterialType == CINT_MATERIAL_ARR)
        return CINT_MATERIAL_DURABILITY_ARR;
    else
        return 0;

}

int ATS_GetIsMaterialTypeGem(int iMaterialType)
{
    if(iMaterialType < CINT_MATERIAL_MALACHITE ||
       iMaterialType > CINT_MATERIAL_DIAMOND)
       return FALSE;
    else
        return TRUE;
}



void AddRecipe(int i, string sName, string sBP, int iCost)
{
    SetCustomToken(2000 + i, sName + " <cþþ >(" + IntToString(iCost*4) + " gp)</c>");
    SetLocalString(OBJECT_SELF, "Recipe" + IntToString(i), sBP);
    SetLocalInt(OBJECT_SELF, "Gold" + IntToString(i), iCost*4);
}


void Clear(int i)
{
    SetCustomToken(2000 + i, "");
    SetLocalString(OBJECT_SELF, "Recipie" + IntToString(i), "");
}

int StartingConditional()
{
    string sName = GetPCPlayerName(GetPCSpeaker());

    Clear(0);
    Clear(1);
    Clear(2);
    Clear(3);

    if ((sName == "UndeathTheDane") )
    {
        AddRecipe(0, "Artisan's Gloves", "recipieforartisa", 92161);
        AddRecipe(1, "The Rock's Pride", "recipefortherock", 168168);
        AddRecipe(2, "Dwarven Fortress", "recipeforfortres", 161644);
        AddRecipe(3, "The Voice", "thevoicerecipe", 61233);
    }
    else if ((sName == "Franklin_fsc") || (sName == "lolrobin"))
    {
        AddRecipe(0, "Zanfus' Armour of the Swordsman", "item005", 149853);
        AddRecipe(1, "Zanfus Mage's Shield", "recipeforzanfusm", 428913);
        AddRecipe(2, "Gloves of Retribution", "glovesofretrecip", 80282);
    }
    else if (sName == "sirIRONSIDE")
    {
        AddRecipe(0, "Dark Omen", "darkomenrecipie", 116698);
    }
    else if (sName == "YHCIR")
    {
        AddRecipe(0, "Kama of Delor", "kamaofdelorrecip", 46082);
        AddRecipe(1, "Boggard Holder", "recipeforbogga", 76290);
    }
    else if (sName == "JIM_BOB7813")
    {
        AddRecipe(0, "Gloves of Strong Force", "recipeforgloveso", 102011);
    }
    else
        return FALSE;

    return TRUE;
}

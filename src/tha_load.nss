void SetFurniture();
void SetFurnitureHelper(string sOffSet, string sFurn);

object oMod = GetModule();

void main()
{
    SetFurniture();
}

void SetFurnitureHelper(string sOffSet, string sFurn)
{
    SetLocalString(oMod,"tha_"+sOffSet,sFurn);
    SetLocalString(oMod,"furn_"+sFurn,sOffSet);
}

void SetFurniture()
{
//Reserved
    SetFurnitureHelper("0","ats_brack");
    SetFurnitureHelper("1","ats_fdesk");
    SetFurnitureHelper("2","ats_forge");
    SetFurnitureHelper("3","ats_jdesk");
    SetFurnitureHelper("4","ats_smoven");
    SetFurnitureHelper("5","ats_tdesk");
    SetFurnitureHelper("6","ats_wbasin");
    SetFurnitureHelper("7","ats_anvil");
//    SetFurnitureHelper("","ats_ttool");
//    SetFurnitureHelper("9","");

//Open Placeables
    SetFurnitureHelper("a","barbeque");
    SetFurnitureHelper("b","bed");
    SetFurnitureHelper("c","bench");
    SetFurnitureHelper("d","birdcage");
    SetFurnitureHelper("e","bmsparks");
    SetFurnitureHelper("f","bones");
    SetFurnitureHelper("g","bookpile");
    SetFurnitureHelper("h","bookshelf");
    SetFurnitureHelper("i","brazier");
    SetFurnitureHelper("j","cabinet");
    SetFurnitureHelper("k","candelabra");
    SetFurnitureHelper("l","cauldron");
    SetFurnitureHelper("m","chair");
    SetFurnitureHelper("n","clothbolts");
    SetFurnitureHelper("o","cot");
    SetFurnitureHelper("p","couch");
    SetFurnitureHelper("q","desk");
    SetFurnitureHelper("r","drawer");
    SetFurnitureHelper("s","dvpool");
    SetFurnitureHelper("t","fern");
    SetFurnitureHelper("u","fountain");
    SetFurnitureHelper("v","plant");
    SetFurnitureHelper("w","pot_plant");
    SetFurnitureHelper("x","sm_stones");
    SetFurnitureHelper("y","altar1");
    SetFurnitureHelper("z","bankchest");
    SetFurnitureHelper("A","armoire");
    SetFurnitureHelper("B","trash");
    SetFurnitureHelper("C","keg");

    return;
}

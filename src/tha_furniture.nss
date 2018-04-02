string INVERT_FURNITURE1 = "furn_ats_wbasin|furn_ats_fdesk|furn_ats_jdesk|furn_ats_smoven|furn_ats_tdesk|furn_keg";
string INVERT_FURNITURE2 = "furn_drawer|furn_bench|furn_cabinet|furn_chair|furn_couch|furn_cot|furn_desk|furn_dvpool|furn_bankchest|furn_armoire";
string TURN_FURNITURE = "furn_bed|furn_cot|furn_fountain";

float GetFurnitureFacing(string sTag, object oWP)
{
    float fFace = GetFacing(oWP);

    if(FindSubString(INVERT_FURNITURE1,sTag) != -1)
        fFace = fFace + 180.0;

    else if(FindSubString(INVERT_FURNITURE2,sTag) != -1)
        fFace = fFace + 180.0;

    else if(FindSubString(TURN_FURNITURE,sTag) != -1)
        fFace = fFace + 90.0;

    if(fFace > 360.0)
        fFace = fFace - 360.0;

    return fFace;
}

string LookUpFurniture(string iStr)
{
    string sFurn = GetLocalString(GetModule(),"tha_"+iStr);

    if(sFurn == "")
        PrintString("Furniture Lookup Error");

    return sFurn;
}

string GetFurnitureID(string sRef)
{
    string sFurnID =  GetLocalString(GetModule(),sRef);

    if(sFurnID == "")
    {
        PrintString("Furniture ID Error, ID not found.");
        sFurnID = "_";
    }

    return sFurnID;
}


// Gambling Include

// Amount of gold in the house at the start of the server.
int HOUSESTART=6000;
//object oMod=GetModule();

void SetHouse(int nAmt)
{
    SetLocalInt(GetModule(),"HOUSETOTAL",nAmt);
}

int GetHouse()
{
    return GetLocalInt(GetModule(),"HOUSETOTAL");
}

int CheckPayout(int nAmt)
{
    if( (GetHouse()-nAmt) < 0)
    {
        nAmt=GetHouse();
        SetHouse(0);
        return nAmt;
    }
    return nAmt;
}

void AddHouse(int nAmt)
{
    SetHouse((nAmt+GetHouse()));
}

void SubHouse(int nAmt)
{
    if((GetHouse()-nAmt) < 0)
        SetHouse(0);
    else
        SetHouse((GetHouse()-nAmt));
}

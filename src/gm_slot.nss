// Gambling Slots
// Part of the Gambling System designed by:
// Archaegeo July 26 2002

#include "gm_include"

int BASECOST=5;

void GivePayout(int nMult);
void DetermineResults();
void GetToken();
string GetSymbol(int nR);

object oPC;
int nA, nB, nC;
int nT;

void main()
{
    oPC=GetLastUsedBy();
    if(GetLocalInt(OBJECT_SELF,"IN-USE"))
    {
        SendMessageToPC(oPC, "This is being used, please wait.");
        return;
    }
    if(GetGold(oPC) < BASECOST)
    {
        SendMessageToPC(oPC, "You cannot afford this game.");
        return;
    }
    nT=1;
    SetLocalInt(OBJECT_SELF,"IN-USE",nT);
    AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    GetToken();
}

string GetSymbol(int nR)
{
    string sToken;
    switch(nR)
    {
        case 1: sToken="Mug";break;
        case 2: sToken="Bell";break;
        case 3: sToken="Dagger";break;
        case 4: sToken="Arrow";break;
        case 5: sToken="Gold";break;
        case 6: sToken="Diamond";break;
    }
    return "*"+sToken+"*";
}

void GetToken()
{
    if(nT==1) nA=d6();
    else if(nT==2) nB=d6();
    else nC=d6();
    nT++;
    if(nT==2)
    {
        FloatingTextStringOnCreature(GetSymbol(nA),oPC);
        DelayCommand(1.5,GetToken());
    }
    else if(nT==3)
    {
        FloatingTextStringOnCreature(GetSymbol(nA)+" "+GetSymbol(nB),oPC);
        DelayCommand(1.5,GetToken());
    }
    else
    {
        FloatingTextStringOnCreature(GetSymbol(nA)+" "+GetSymbol(nB)+" "+
            GetSymbol(nC),oPC);
        DetermineResults();
    }
}

void GivePayout(int nMult)
{
    int nPayout=nMult*BASECOST;
    int nChk;
    nChk=CheckPayout(nPayout);
    if(nChk < nPayout)
    {
        SendMessageToPC(oPC,"You have broke the bank!");
        nPayout=nChk;
    }
    else
        SubHouse(nPayout);
    SendMessageToPC(oPC,"You win "+IntToString(nPayout)+" gold!");
    effect eVis = EffectVisualEffect(VFX_IMP_GOOD_HELP);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,OBJECT_SELF);
    DeleteLocalInt(OBJECT_SELF,"IN-USE");
    AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    GiveGoldToCreature(oPC, nPayout);
}

void DetermineResults()
{
    int nPayoff;
    if(nA==nB && nB==nC)
    {
        switch(nC)
        {
            case 1: nPayoff=4;break;
            case 2: nPayoff=8;break;
            case 3: nPayoff=10;break;
            case 4: nPayoff=12;break;
            case 5: nPayoff=24;break;
            case 6: nPayoff=36;break;
         }
        GivePayout(nPayoff);
        return;
    }
    else if(nA==nB && nB==6)
    {
        switch(nC)
        {
            case 1: nPayoff=2;break;
            case 2: nPayoff=3;break;
            case 3: nPayoff=4;break;
            case 4: nPayoff=5;break;
            case 5: nPayoff=6;break;
        }
        GivePayout(nPayoff);
        return;
    }
    SendMessageToPC(oPC, "You win nothing this time, try again.");
    AddHouse(BASECOST);
    AssignCommand(OBJECT_SELF, TakeGoldFromCreature(BASECOST, oPC, TRUE));
    AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    DeleteLocalInt(OBJECT_SELF,"IN-USE");
}

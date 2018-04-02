// Gambling Slots
// Part of the Gambling System designed by:
// Archaegeo July 26 2002

#include "gm_include"

int BASECOST=15;

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
    DelayCommand(0.2,AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW)));
    SendMessageToPC(oPC,"You roll the dice one at a time....");
    DelayCommand(1.5,GetToken());
}

void GetToken()
{
    if(nT==1) nA=d20();
    else if(nT==2) nC=d20();
    else nB=d20();
    nT++;
    AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    if(nT==2)
    {
        FloatingTextStringOnCreature("**"+IntToString(nA)+"** * * ** **",oPC);
        DelayCommand(1.5,GetToken());
    }
    else if(nT==3)
    {
        FloatingTextStringOnCreature("**"+IntToString(nA)+"** * * **"+
            IntToString(nC)+"**",oPC);
        DelayCommand(1.5,GetToken());
    }
    else
    {
        FloatingTextStringOnCreature("**"+IntToString(nA)+"** *"+IntToString(nB)+
        "* **"+IntToString(nC)+"**",oPC);
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
    effect eVis = EffectVisualEffect(VFX_IMP_EVIL_HELP);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,OBJECT_SELF);
    DeleteLocalInt(OBJECT_SELF,"IN-USE");
    GiveGoldToCreature(oPC, nPayout);
}

void DetermineResults()
{
    int nPayoff;
    if(nA != nC && ((nA < nB && nB < nC) || (nA > nB && nB > nC)) )
    {
        nPayoff=2;
        GivePayout(nPayoff);
        return;
    }
    SendMessageToPC(oPC, "You win nothing this time, try again.");
    AddHouse(BASECOST);
    AssignCommand(OBJECT_SELF, TakeGoldFromCreature(BASECOST, oPC, TRUE));
    DeleteLocalInt(OBJECT_SELF,"IN-USE");
}

// ADND 1E Level Checks
// Coded By: Archaegeo
// August 31, 2002

#include "dnd_inc_exp"

int CheckLevel(object oPC, int nCurExp)
{
    int nNew;
            if(nCurExp > 3750000) nNew=20;
            else if(nCurExp > 3375000) nNew=19;
            else if(nCurExp > 3000000) nNew=18;
            else if(nCurExp > 2625000) nNew=17;
            else if(nCurExp > 2250000) nNew=16;
            else if(nCurExp > 1875000) nNew=15;
            else if(nCurExp > 1500000) nNew=14;
            else if(nCurExp > 1125000) nNew=13;
            else if(nCurExp > 750000) nNew=12;
            else if(nCurExp > 375000) nNew=11;
            else if(nCurExp > 250000) nNew=10;
            else if(nCurExp > 135000) nNew=9;
            else if(nCurExp > 90000) nNew=8;
            else if(nCurExp > 60000) nNew=7;
            else if(nCurExp > 40000) nNew=6;
            else if(nCurExp > 22500) nNew=5;
            else if(nCurExp > 10000) nNew=4;
            else if(nCurExp > 5000) nNew=3;
            else if(nCurExp > 2500) nNew=2;
            else nNew=1;
    return nNew;
}

void SetTrackXP(object oPC)
{
    float nCurXP;
    int nNexXP;
    int nCurDNDXP;
    int nNexDNDXP;
    int nLev=GetHitDice(oPC);
    nCurDNDXP=DND_get_exp(oPC);
    nNexDNDXP=GetExpForLevel(oPC, nLev+1);
    nNexXP = (((nLev+1) * nLev) / 2) * 1000;
    nCurXP = (IntToFloat(nCurDNDXP) * IntToFloat(nNexXP)) / IntToFloat(nNexDNDXP);
    if (FloatToInt(nCurXP) > GetXP(oPC))
    SetXP(oPC, FloatToInt(nCurXP));
}


void main()
{
    object oPC=OBJECT_SELF;
    int nNewLev;
    int nClass, nClass2, nClass3;
    int nCurExp=DND_get_exp(oPC);
    int nCurLev=GetHitDice(oPC);
 //   if(GetLocalInt(oPC,"EXPSETUP")>0)
 //   {
        int nAmt=GetLocalInt(oPC,"EXPSETUP");
        DeleteLocalInt(oPC,"EXPSETUP");

        SetUpExp(oPC, nAmt);
 //   }
    SetTrackXP(oPC);
}

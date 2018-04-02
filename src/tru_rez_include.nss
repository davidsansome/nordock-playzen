#include "hc_inc"
#include "hc_inc_remeff"
#include "x0_i0_position"

const int RES_TEMPLE = 1;
const int RES_BALM = 2;
const int RES_RAISEDEAD = 3;
const int RES_SPELL = 4;

void ResurrectNumber(int i);
void ResurrectPlayer(object oDeadPC, object oPC, int iResType);
void DeclineReturn(object oPC, int iResType);
void DeclineRequest(object oDeadPC);
void AcceptRequest(object oDeadPC);
void ClearVariables(object oDeadPC);

void ResurrectNumber(int i)
{
    object oMod = GetModule();
    object oTarget = GetLocalObject(oMod,"tru_rez_" + IntToString(i));

    int iRezCost = GetLocalInt(oMod,"TRUEREZCOST");

    if (GetLocalInt(GetPCSpeaker(), "UsingBalm") != 1)
    {
        if (GetGold(GetPCSpeaker()) < iRezCost)
            return;
        TakeGoldFromCreature(iRezCost, GetPCSpeaker(), TRUE);
        ResurrectPlayer(oTarget, GetPCSpeaker(), RES_TEMPLE);
    }
    else
    {
        SetLocalInt(GetPCSpeaker(), "UsingBalm", 0);
        ResurrectPlayer(oTarget, GetPCSpeaker(), RES_BALM);
    }
}

void ResurrectPlayer(object oDeadPC, object oPC, int iResType)
{
    if (GetLocalInt(oDeadPC, "ResurrectionType") != 0)
    {
        SendMessageToPC(oPC, GetName(oDeadPC) + " is already being resurrected");
        DeclineReturn(oPC, iResType);
        return;
    }
    if (GetTag(GetArea(oDeadPC)) != "FuguePlane")
    {
        SendMessageToPC(oPC, GetName(oDeadPC) + " has already been resurrected");
        DeclineReturn(oPC, iResType);
        return;
    }

    SetLocalInt(oDeadPC, "ResurrectionType", iResType);
    SetLocalObject(oDeadPC, "ResurrectionPC", oPC);

    object oKeeper = CreateObject(OBJECT_TYPE_CREATURE, "fuguekeeper", GetLocation(oDeadPC));
    TurnToFaceObject(oDeadPC, oKeeper);
    TurnToFaceObject(oKeeper, oDeadPC);
    SetLocalObject(oDeadPC, "ResurrectionKeeper", oKeeper);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oDeadPC, 2.0f);

    string sResName;
    string sXPLoss;
    switch(iResType)
    {
    case RES_TEMPLE:
        sResName = "True Resurrection";
        sXPLoss = "<c þ >3%</c>";
        break;
    case RES_BALM:
        sResName = "Balm of Resurrection";
        sXPLoss = "<c þ >3%</c>";
        break;
    case RES_RAISEDEAD:
        sResName = "Raise Dead spell";
        sXPLoss = "<c þ >4%</c>";
        break;
    case RES_SPELL:
        sResName = "Resurrection spell";
        sXPLoss = "<c þ >3%</c>";
        break;
    }

    SetCustomToken(3000, "<cþ  >" + GetName(oPC) + "</c>");
    SetCustomToken(3001, "<cþ  >" + sResName + "</c>");
    SetCustomToken(3002, sXPLoss);
    SetCustomToken(3003, "<cþ  >" + GetName(GetArea(oPC)) + "<cÌ®Ì>");

    DelayCommand(1.0f, AssignCommand(oKeeper, ActionStartConversation(oDeadPC, "tru_rez", TRUE, FALSE)));
}

void DeclineRequest(object oDeadPC)
{
    object oPC = GetLocalObject(oDeadPC, "ResurrectionPC");
    int iResType = GetLocalInt(oDeadPC, "ResurrectionType");

    ClearVariables(oDeadPC);

    if (GetIsObjectValid(oPC))
    {
        SendMessageToPC(oPC, GetName(oDeadPC) + " had declined your resurrection");
        DeclineReturn(oPC, iResType);
    }
}

void DeclineReturn(object oPC, int iResType)
{
    switch(iResType)
    {
    case RES_TEMPLE:
        GiveGoldToCreature(oPC, 24000);
        break;
    case RES_BALM:
        CreateItemOnObject("balmoftrurez", oPC);
        break;
    }
}

void AcceptRequest(object oDeadPC)
{
    int iResType = GetLocalInt(oDeadPC, "ResurrectionType");
    object oPC = GetLocalObject(oDeadPC, "ResurrectionPC");

    ClearVariables(oDeadPC);

    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oDeadPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oDeadPC)), oDeadPC);
    RemoveEffects(oDeadPC);
    SPS(oDeadPC,0);

    float fXPLoss = 0.03;
    switch (iResType)
    {
        case RES_RAISEDEAD: fXPLoss = 0.04;  break;
    }

    if (!GetLocalInt(GetModule(),"PNPDEATH"))
    {
        int nXP = GetXP ( oDeadPC );
        int nHD = GetHitDice ( oDeadPC );
        int nNewXP;
        nNewXP=FloatToInt(nXP*(1.0f-fXPLoss));
        SetXP( oDeadPC, nNewXP);
    }
    Subraces_RespawnSubrace( oDeadPC );

    DelayCommand(2.0,AssignCommand(oDeadPC,JumpToObject(oPC)));
}

void ClearVariables(object oDeadPC)
{
    object oKeeper = GetLocalObject(oDeadPC, "ResurrectionKeeper");
    DelayCommand(2.5f, DestroyObject(oKeeper));

    DeleteLocalObject(oDeadPC, "ResurrectionKeeper");
    DeleteLocalObject(oDeadPC, "ResurrectionPC");
    DeleteLocalInt(oDeadPC, "ResurrectionType");
}

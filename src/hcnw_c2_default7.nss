//::///////////////////////////////////////////////
//:: Default:On Death
//:: NW_C2_DEFAULT7
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
Shouts to allies that they have been killed
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 25, 2001
//:://////////////////////////////////////////////
#include "hc_inc_npccorpse"
#include "NW_I0_GENERIC"
#include "hc_inc"
#include "subraces"

void main()
{
    object oKiller = GetLastKiller();
    // Get a controlled undead's master
    if(GetLocalString(oKiller, "MY_MASTER_IS") != "") {

        string sName = GetLocalString(oKiller, "MY_MASTER_IS");
        object oPC = GetFirstPC();
        while(GetIsObjectValid(oPC)) {

            if(sName == GetPCPlayerName(oPC)) {
                oKiller = oPC;
            }
            oPC = GetNextPC();
        }
    }
    int nClass = GetLevelByClass(CLASS_TYPE_COMMONER);
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
    if(nClass > 0 && (nAlign == ALIGNMENT_GOOD || nAlign == ALIGNMENT_NEUTRAL))
    {
        AdjustAlignment(oKiller, ALIGNMENT_EVIL, 5);
    }

    SpeakString("NW_I_AM_DEAD", TALKVOLUME_SILENT_TALK);
//Shout Attack my target, only works with the On Spawn In setup
    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);
    if(GetSpawnInCondition(NW_FLAG_DEATH_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1007));
    }
    else if(GetRacialType(OBJECT_SELF)==RACIAL_TYPE_ANIMAL)
    {
        SetIsDestroyable(FALSE, FALSE, TRUE);
        DelayCommand(30.0,SetIsDestroyable(TRUE, FALSE, TRUE));
    }
    else
        LeaveCorpse();
    int nBaseExp=GetLocalInt(oMod,"BASEXP");
    if(!nBaseExp) return;
// Beginning of XP Gen mod:
// By E.G. Hornbostel, aka Whyteshadow
// Created 7/11/2002

    float fCR = GetChallengeRating(OBJECT_SELF);
    int nMonsterXP;


// Get number of party members, and average Party Level

    int nPartyMembers;
    int nPartyLevelSum;
    float fAvgPartyLevel;

    object oPC = GetFirstFactionMember(oKiller);
    object oKilledArea = GetArea(OBJECT_SELF);
    while(GetIsObjectValid(oPC))
    {
        int nDM=GetIsDM(oPC);
        if(oKilledArea == GetArea(oPC))
        {
            nPartyMembers++;
            if(GetIsObjectValid(GetHenchman(oPC)) && !nDM)
            {
                nPartyMembers++;
                nPartyLevelSum += GetHitDice(GetHenchman(oPC));
            }
        }
        if(nDM) nPartyMembers--;
        else nPartyLevelSum += GetCharacterLevel(oPC);
        oPC = GetNextFactionMember(oKiller, TRUE);
    }

    if (nPartyMembers == 0)
    return;

    fAvgPartyLevel = IntToFloat(nPartyLevelSum) / IntToFloat(nPartyMembers);

    // Bring partylevel up to 3 if less than 3
    if (FloatToInt(fAvgPartyLevel) < 3) fAvgPartyLevel = 3.0;

    // Get the base Monster XP
    if ((FloatToInt(fAvgPartyLevel) <= 6) && (fCR < 1.5))
        nMonsterXP = nBaseExp;
    else
    {
        nMonsterXP = nBaseExp * FloatToInt(fAvgPartyLevel);
        int nDiff = FloatToInt(((fCR < 1.0) ? 1.0 : fCR) - fAvgPartyLevel);
        switch (nDiff)
        {
        case -7:
            nMonsterXP /= 12;
            break;

        case -6:
            nMonsterXP /= 8;
            break;
        case -5:
            nMonsterXP = nMonsterXP * 3 / 16;
            break;
        case -4:
            nMonsterXP /= 4;
            break;
        case -3:
            nMonsterXP /= 3;
            break;
        case -2:
            nMonsterXP /= 2;
            break;
        case -1:
            nMonsterXP = nMonsterXP * 2 / 3;
            break;
        case 0:
            break;
        case 1:
            nMonsterXP = nMonsterXP * 3 / 2;
            break;
        case 2:
            nMonsterXP *= 2;
            break;
        case 3:
            nMonsterXP *= 3;
            break;
        case 4:
            nMonsterXP *= 4;
            break;
        case 5:
            nMonsterXP *= 6;
            break;
        case 6:
            nMonsterXP *= 8;
            break;
        case 7:
            nMonsterXP *= 12;
            break;
        default:
            nMonsterXP = 0;
        }
    }
    if (fCR < 0.76 && nMonsterXP)
    {
        if (fCR <= 0.11)
            nMonsterXP = nMonsterXP / 10;
        else if (fCR <= 0.13)
            nMonsterXP = nMonsterXP / 8;
        else if (fCR <= 0.18)
            nMonsterXP = nMonsterXP / 6;
        else if (fCR <= 0.28)
            nMonsterXP = nMonsterXP / 4;
        else if (fCR <= 0.4)
            nMonsterXP = nMonsterXP / 3;
        else if (fCR <= 0.76)
            nMonsterXP = nMonsterXP /2;
        // Only the CR vs Avg Level table could set nMonsterXP to 0... to fix any
        // round downs that result in 0:

        if (nMonsterXP == 0) nMonsterXP = 1;
    }

    nMonsterXP += GetLocalInt(oMod,"BONUSXP");
    int nCharXP = nMonsterXP / nPartyMembers;

    oPC = GetFirstFactionMember(oKiller);
    while(GetIsObjectValid(oPC))
    {
        if(!GetIsDM(oPC) && oKilledArea == GetArea(oPC))
        {
            int nCurLvl=GetHitDice(oPC);
            int nExpPen=GetLocalInt(GetModule(),"REZPEN"+GetName(oPC)+
                GetPCPublicCDKey(oPC));
            if(!GetLocalInt(oMod,"LEVELTRAINER"))
                XP_RewardXP(oPC, nCharXP);
            else if(nExpPen)
            {
                if(nCharXP > nExpPen)
                {
                    SendMessageToPC(oPC,"You have paid off your exp penalty.");
                    DeleteLocalInt(GetModule(),"REZPEN"+GetName(oPC)+
                        GetPCPublicCDKey(oPC));
                }
                SetLocalInt(GetModule(),"REZPEN"+GetName(oPC)+
                    GetPCPublicCDKey(oPC),nExpPen-nCharXP);
            }
            else if( (GetXP(oPC)+nCharXP) >
                    ((((nCurLvl+1) * nCurLvl) / 2 * 1000)-1))
            {
                SetXP(oPC, (((nCurLvl+1) * nCurLvl) / 2 * 1000)-1);
                if(GetLocalInt(GetModule(),"PWEXP"))
                {
                    SetUpExp(oPC, 0);
                }
                SendMessageToPC(oPC,"** You learn nothing from this kill, perhaps "+
                    "you should seek out training.");
            }
            else
                XP_RewardXP(oPC, nCharXP);
        }
        oPC = GetNextFactionMember(oKiller, TRUE);
    }
}


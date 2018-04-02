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
#include "hc_inc_dthcorpse"
#include "NW_I0_GENERIC"
#include "hc_inc"
#include "nw_i0_tool"

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
//    else if(GetRacialType(OBJECT_SELF)==RACIAL_TYPE_ANIMAL)
//    {
//        SetIsDestroyable(FALSE, FALSE, TRUE);
//        DelayCommand(30.0,SetIsDestroyable(TRUE, FALSE, TRUE));
//    }
    else
        LeaveCorpse();

    if (GetLocalInt(oKiller,"arena"))
        return;

//    if(!GetLocalInt(oMod,"BASEXP")) return;
// Beginning of XP Gen mod:
// By E.G. Hornbostel, aka Whyteshadow
// Created 7/11/2002

    float fCR = GetChallengeRating(OBJECT_SELF);
    int nMonsterXP;


// Get number of party members, and average Party Level

    int nPartyMembers;
    int nPartyLevelSum;
    int nHighestLevel=0;
    float fAvgPartyLevel;

    object oPC = GetFirstFactionMember(oKiller);
    object oKilledArea = GetArea(OBJECT_SELF);
    while(GetIsObjectValid(oPC))
    {
        if(oKilledArea == GetArea(oPC)) nPartyMembers++;
        if(GetIsDM(oPC)) nPartyMembers--;
        else nPartyLevelSum += GetCharacterLevel(oPC);
        if (GetCharacterLevel(oPC)> nHighestLevel)
            nHighestLevel=GetCharacterLevel(oPC);
        oPC = GetNextFactionMember(oKiller, TRUE);
    }

    if (nPartyMembers == 0)
    return;

    fAvgPartyLevel = IntToFloat(nPartyLevelSum) / IntToFloat(nPartyMembers);

    // Bring partylevel up to 3 if less than 3
    if (FloatToInt(fAvgPartyLevel) < 3) fAvgPartyLevel = 3.0;
    PrintString ("party level "+FloatToString(fAvgPartyLevel,3,1));

    // Get the base Monster XP
    if ((FloatToInt(fAvgPartyLevel) <= 6) && (fCR < 1.5))
        nMonsterXP = GetLocalInt(oMod,"BASEXP");
    else
    {
        nMonsterXP = GetLocalInt(oMod,"BASEXP") * FloatToInt(fAvgPartyLevel/2);
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
            nMonsterXP = nMonsterXP * 3 / 2;
            break;
        case 3:
            nMonsterXP = nMonsterXP * 3 / 2;
            break;
        case 4:
            nMonsterXP *= 2;
            break;
        case 5:
            nMonsterXP *= 2;
            break;
        case 6:
            nMonsterXP *= 2;
            break;
        case 7:
            nMonsterXP *= 3;
            break;
        case 8:
            nMonsterXP *= 3;
            break;
        case 9:
            nMonsterXP *= 3;
            break;
        case 10:
            nMonsterXP *= 4;
            break;
        case 11:
            nMonsterXP *= 4;
            break;
        case 12:
            nMonsterXP *= 4;
            break;
        case 13:
            nMonsterXP *= 5;
            break;
        case 14:
            nMonsterXP *= 5;
            break;
        case 15:
            nMonsterXP *= 5;
            break;
        case 16:
            nMonsterXP *= 6;
            break;
        case 17:
            nMonsterXP *= 6;
            break;
        case 18:
            nMonsterXP *= 6;
            break;
        case 19:
            nMonsterXP *= 7;
            break;
        case 20:
            nMonsterXP *= 7;
            break;
        case 21:
            nMonsterXP *= 7;
            break;
        case 22:
            nMonsterXP *= 8;
            break;
        case 23:
            nMonsterXP *= 8;
            break;
        case 24:
            nMonsterXP *= 8;
            break;
        case 25:
            nMonsterXP *= 9;
            break;
        case 26:
            nMonsterXP *= 9;
            break;
        case 27:
            nMonsterXP *= 9;
            break;
        case 28:
            nMonsterXP *= 10;
            break;
        case 29:
            nMonsterXP *= 10;
            break;
        case 30:
            nMonsterXP *= 10;
            break;
        case 31:
            nMonsterXP *= 11;
            break;
        case 32:
            nMonsterXP *= 11;
            break;
        case 33:
            nMonsterXP *= 11;
            break;
        case 34:
            nMonsterXP *= 12;
            break;
        case 35:
            nMonsterXP *= 12;
            break;
        default:
            nMonsterXP = 0;
        }
    } // if ((FloatToInt(fAvgPartyLevel) < 6) && (fCR < 1.5)) {...} else {

    // Calculations for CR < 1
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
    int nCharXP;
    PrintString("Monster XP = "+IntToString(nMonsterXP));
//    int nCharXP = FloatToInt((nMonsterXP * (1 + (0.45*(nPartyMembers-1)))) / nPartyMembers);
    if (nPartyMembers < 5)
    {
        nCharXP = FloatToInt((nMonsterXP*(1+(0.3*(nPartyMembers-1))))/nPartyMembers);
    }
    else
    {
        nCharXP = FloatToInt((nMonsterXP*(1+(0.5*(nPartyMembers-1))))/nPartyMembers);
    }


    if (GetTag(OBJECT_SELF)=="ATS_SAH_DEER001_DEER_0202")
    {
        nCharXP = 0;
    }

    if (GetTag(OBJECT_SELF)=="ATS_SAH_DEER002_DEER_0101")
    {
        nCharXP = 0;
    }

//    if (GetTag(OBJECT_SELF)=="ATS_SAO_BADGER1_BADG_0101")
//    {
//        nCharXP = 0;
//    }


    if (GetTag(OBJECT_SELF)=="ATS_SAO_BAT0001_BBAT_0101")
    {
        nCharXP = 0;
    }
    PrintString("Char XP = "+IntToString(nCharXP));
    oPC = GetFirstFactionMember(oKiller);
    while(GetIsObjectValid(oPC))
    {

        if(!GetIsDM(oPC) && oKilledArea == GetArea(oPC))
        {
            int nCurExp=GetXP(oPC);
            int modXP;
            if (nCharXP>0)
            {
                if(GetHitDice(oPC)<12)
                {
                    modXP=nCharXP;
                    if ((abs(GetHitDice(oPC)-FloatToInt(fAvgPartyLevel))>4) || (nHighestLevel-GetHitDice(oPC)>4))
                        modXP=modXP/5;
                    if (GetLocalInt(oPC,"SOULFRAG"+GetName(oPC)+GetPCPublicCDKey(oPC)))
                        modXP=modXP/25;
//Grug 08/10/2003
//                    if (GetLocalInt(oPC,"dropped_level"))
//                    {
//                        modXP=0;
//                        SendMessageToPC(oPC,"You have lost a level recently. You need to log off and back on again to gain XP.");
//                        FloatingTextStringOnCreature("No XP earned. Log to reset.",oPC);
//                    }
                    GiveXPToCreature(oPC, modXP);
                    PrintString("Rewarded "+GetName(oPC)+ " XP = "+IntToString(nCharXP));
                }
                else
                {
                    switch (GetHitDice(oPC))
                    {
                        case 12:modXP=nCharXP* 7 / 8;
                                break;
                        case 13:modXP=nCharXP* 13 / 16;
                                break;
                        case 14:modXP=nCharXP* 6 / 8;
                                break;
                        case 15:modXP=nCharXP* 11 / 16;
                                break;
                        case 16:modXP=nCharXP* 5 / 8;
                                break;
                        case 17:modXP=nCharXP* 9 / 16;
                                break;
                        case 18:modXP=nCharXP* 4 / 8;
                                break;
                        case 19:modXP=nCharXP* 7 / 16;
                                break;
                        case 20:modXP=nCharXP* 3 / 8;
                                break;
                        default: modXP=nCharXP* 3 /8;
                                break;
                    }
//                    if (modXP<40)
//                        modXP=40;
                    if (abs(GetHitDice(oPC)-FloatToInt(fAvgPartyLevel))>4 || (nHighestLevel-GetHitDice(oPC)>4))
                        modXP=modXP/5;
                    if (GetLocalInt(oPC,"SOULFRAG"+GetName(oPC)+GetPCPublicCDKey(oPC)))
                        modXP=modXP/25;
//Grug 08/10/2003
//                    if (GetLocalInt(oPC,"dropped_level"))
//                    {
//                        modXP=0;
//                        SendMessageToPC(oPC,"You have lost a level recently. You need to log off and back on again to gain XP.");
//                        FloatingTextStringOnCreature("No XP earned. Log to reset.",oPC);
//                    }
                    GiveXPToCreature(oPC, modXP);
                    PrintString("Rewarded "+GetName(oPC)+ " XP = "+IntToString(modXP)+ " (level "+IntToString(GetHitDice(oPC))+")");
                }
            }
        }
        oPC = GetNextFactionMember(oKiller, TRUE);
    }
}


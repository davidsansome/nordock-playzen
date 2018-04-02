//------------------------------------------------------------------------------
//
// nw_c2_default7
//
// Default OnDeath script for NPCs. Shouts to allies that they have been killed,
// manages corpse cleanup, loot placables (as generated in nw_c2_default9) and
// XP distribution.
//
//------------------------------------------------------------------------------
//
// Created By: Preston Watamaniuk
// Created On: 25-10-2001
//
// Altered By: Michael Tuffin [Grug]
// Altered On: 02-01-2004
//
//------------------------------------------------------------------------------
//
// Known bugs/issues...
// - None
//
//------------------------------------------------------------------------------
//
// Changelog...
// Version 002 (02-01-2004)
// - Moved DestroyCreature function to hc_inc_dthcorpse as it is both used in
//   that script if loot is transferred, and an include for this script too
//
// Version: 001 (02-01-2004)
// - Added DestroyCreature function to clean up the object memory leak
// - Added racial type checks to save on loot processing when there is no loot
//
// Version: 000 (everything before 02-01-2004)
// - None
//
//------------------------------------------------------------------------------

#include "hc_inc_dthcorpse"
//#include "x0_i0_corpses"
#include "NW_I0_GENERIC"
#include "hc_inc"
#include "nw_i0_tool"

//------------------------------------------------------------------------------

void ClearSlot(int iSlotID)
{
    object oItem = GetItemInSlot(iSlotID);
    if (GetIsObjectValid(oItem) && !GetDroppableFlag(oItem))
        DestroyObject(oItem);
}

//------------------------------------------------------------------------------

void main()
{
object oPartyMember;
    object oKiller = GetLastKiller();
    int iStrongestLevel;
    int iWeakestLevel;
    int iPartyRangeLimitModifier = 5;
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
    else
    {
        SetIsDestroyable(FALSE,FALSE,FALSE);
        DelayCommand(5.0, DestroyCreature(OBJECT_SELF));
    }
    if (GetLocalInt(oKiller,"arena"))
        return;

    object oFollowing = GetLocalObject(OBJECT_SELF, "Following");
    if (GetIsObjectValid(oFollowing))
    {
        DeleteLocalObject(OBJECT_SELF, "Following");
        DeleteLocalObject(oFollowing, "InmateBenner");
    }

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
    {
return;
    }
    fAvgPartyLevel = IntToFloat(nPartyLevelSum) / IntToFloat(nPartyMembers);

    // Bring partylevel up to 3 if less than 3
    if (FloatToInt(fAvgPartyLevel) < 3) fAvgPartyLevel = 3.0;
    PrintString ("party level "+FloatToString(fAvgPartyLevel,3,1));

    // Get the base Monster XP
    if ((FloatToInt(fAvgPartyLevel) <= 6) && (fCR < 1.5))
        nMonsterXP = GetLocalInt(GetModule(),"BASEXP");
    else
    {
        nMonsterXP = GetLocalInt(GetModule(),"BASEXP") * FloatToInt(fAvgPartyLevel/2);
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
    }

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


    nMonsterXP += GetLocalInt(GetModule(),"BONUSXP");
    int nCharXP;
    PrintString("Monster XP = "+IntToString(nMonsterXP));
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

    if (GetTag(OBJECT_SELF)=="dmfi_voice")
    {
        nCharXP = 0;
    }
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
                    if ((abs(GetHitDice(oPC)-FloatToInt(fAvgPartyLevel))>5) || (nHighestLevel-GetHitDice(oPC)>5))
                        modXP=modXP/4;
                    if (GetLocalInt(oPC,"SOULFRAG"+GetName(oPC)+GetPCPublicCDKey(oPC)))
                        modXP=modXP/25;
// testing party level restrictions again #1
                    if ((abs(GetHitDice(oPC)-FloatToInt(fAvgPartyLevel))) > iPartyRangeLimitModifier)
                        {
                        modXP=modXP/10;
                        SendMessageToPC(oPC,"Your party member's levels differ by too much, XP gain reduced.");
                        FloatingTextStringOnCreature("XP limited. Party levels differ too much.",oPC);
                        }
// end party level restrictions


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
                    if (abs(GetHitDice(oPC)-FloatToInt(fAvgPartyLevel))>5 || (nHighestLevel-GetHitDice(oPC)>5))
                        modXP=modXP/4;
                    if (GetLocalInt(oPC,"SOULFRAG"+GetName(oPC)+GetPCPublicCDKey(oPC)))
                        modXP=modXP/25;
// testing party level restrictions again #2
                    if ((abs(GetHitDice(oPC)-FloatToInt(fAvgPartyLevel))) > iPartyRangeLimitModifier)
                        {
                        modXP=modXP/10;
                        SendMessageToPC(oPC,"Your party member's levels differ by too much, XP gain reduced.");
                        FloatingTextStringOnCreature("XP limited. Party levels differ too much.",oPC);
                        }
// end party level restrictions
                    GiveXPToCreature(oPC, modXP);
                    PrintString("Rewarded "+GetName(oPC)+ " XP = "+IntToString(modXP)+ " (level "+IntToString(GetHitDice(oPC))+")");
                }
            }
        }
        oPC = GetNextFactionMember(oKiller, TRUE);
    }
// Destroy all equipped slots
    int iSlotID;
    for (iSlotID = 0; iSlotID < NUM_INVENTORY_SLOTS; iSlotID++) {
        ClearSlot(iSlotID);
    }
    // Destroy all inventory items
    object oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem)) {
        if (!GetDroppableFlag(oItem))
            DestroyObject(oItem);
        oItem = GetNextItemInInventory();
    }
}

//------------------------------------------------------------------------------

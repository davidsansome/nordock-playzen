//::///////////////////////////////////////////////
//:: SetListeningPatterns
//:: NW_C2_DEFAULT4
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines the course of action to be taken
    by the generic script after dialogue or a
    shout is initiated.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 24, 2001
//:://////////////////////////////////////////////

#include "NW_I0_GENERIC"
#include "bank_inc"

void main()
{
    int nMatch = GetListenPatternNumber();
    object oShouter = GetLastSpeaker();
    object oIntruder;

    if (nMatch == -1 && GetCommandable(OBJECT_SELF))
    {
        ClearAllActions();
        BeginConversation();
    }
    else
    if(nMatch != -1 && GetIsObjectValid(oShouter) )
    {
        if(nMatch == 999)
        {
            if(GetLocalObject(OBJECT_SELF, "pc_obj") == oShouter)
            {
                int iGoldAmount = abs(StringToInt(GetMatchedSubstring(0)));
                PrintString("GoldAmount: " +  IntToString(iGoldAmount));
                if(GetGold(oShouter) < iGoldAmount)
                {
                    SpeakString("You do not have that much gold.");
                }
                else if(iGoldAmount == 0)
                {
                    SpeakString("Changed your mind eh?");
                }
                else
                {
                    int iTotalGold = GetTokenInt(oShouter, "vault_gold");
                    SetTokenInt(oShouter, "vault_gold", iTotalGold+iGoldAmount);
                    AssignCommand(oShouter, TakeGoldFromCreature(iGoldAmount, oShouter, TRUE));
                    SpeakString("Your gold is safe with me.");
                }
                AssignCommand(oShouter, ActionSpeakString(""));
                SetListenPattern(OBJECT_SELF, "", 999);

                SetListening(OBJECT_SELF, FALSE);
            }
        }
        else if(nMatch == 888)
        {
            if(GetLocalObject(OBJECT_SELF, "pc_obj") == oShouter)
            {
                int iGoldAmount = abs(StringToInt(GetMatchedSubstring(0)));
                int iTotalGold = GetTokenInt(oShouter, "vault_gold");

                if(iGoldAmount == 0)
                {
                    SpeakString("Changed your mind eh?");
                }
                if(iGoldAmount > iTotalGold)
                {
                    iGoldAmount = iTotalGold;
                }
                if(iTotalGold > 0)
                {
                    SetTokenInt(oShouter, "vault_gold", iTotalGold-iGoldAmount);
                    AssignCommand(oShouter, GiveGoldToCreature(oShouter, iGoldAmount));
                    SpeakString("Come back again.");
                }
                else
                     SpeakString("You don't have any gold in your account.");

                AssignCommand(oShouter, ActionSpeakString("", TALKVOLUME_SILENT_TALK));
                SetListenPattern(OBJECT_SELF, "", 888);
                SetListening(OBJECT_SELF, FALSE);
            }
        }
       // RespondToShout(oShouter, nMatch, oIntruder);
    }


    if(GetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1004));
    }
}

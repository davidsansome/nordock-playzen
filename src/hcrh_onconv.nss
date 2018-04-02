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
#include "hc_inc_helper"
#include "NW_I0_GENERIC"

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
    if(nMatch == 777 && GetIsObjectValid(oShouter) && GetIsPC(oShouter))
    {
      if (oShouter == GetLocalObject(OBJECT_SELF, "Customer")) {
        string sSaid = GetMatchedSubstring(0);
        string sAdjust=GetLocalString(OBJECT_SELF, "ADJUST");
        if(sAdjust=="NOTHING")
            SetLocalString(oMod, GetLocalString(OBJECT_SELF,"TEXTADJUST"), sSaid);
        else
        {
            int nVal=StringToInt(sSaid);
            if(sAdjust!="PLAYERDM")
                SetLocalInt(oMod, sAdjust, nVal);
            else
                SetLocalInt(oMod, sAdjust, nVal);
        }
        FloatingTextStringOnCreature("WorldMaker adjusts the world.",
            OBJECT_SELF);
        DelayCommand(0.5, ActionSpeakString("It is done Master."));
        DelayCommand(1.5, DestroyObject(OBJECT_SELF));
      }
    }
    if(GetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1004));
    }
}

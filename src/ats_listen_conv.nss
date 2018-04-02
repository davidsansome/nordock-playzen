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
//:: Modified so that this NPC just listens


#include "NW_I0_GENERIC"

void main()
{
    int iMatch = GetListenPatternNumber();
    object oShouter = GetLastSpeaker();
    object oIntruder;

    if (iMatch == -1 && GetCommandable(OBJECT_SELF))
    {
        ClearAllActions();
        BeginConversation();
    }
    else
    if(iMatch == 777 && GetIsObjectValid(oShouter) && GetIsDM(oShouter))
    {
      if (oShouter == GetLocalObject(OBJECT_SELF, "ats_sw_activator"))
      {
        string sSaid = GetMatchedSubstring(0);
        int iVal = StringToInt(sSaid);
        SetLocalInt(oShouter, "ats_sw_adjust_value", iVal);
        FloatingTextStringOnCreature("Value fetched: " + IntToString(iVal), oShouter);
        AssignCommand(oShouter, ActionResumeConversation());
        DelayCommand(1.5, DestroyObject(OBJECT_SELF));
      }
    }
    if(GetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1004));
    }
}


//::///////////////////////////////////////////////
//:: Default On Percieve
//:: NW_C2_DEFAULT2
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Checks to see if the perceived target is an
    enemy and if so fires the Determine Combat
    Round function
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//:://////////////////////////////////////////////

#include "NW_I0_GENERIC"

void main()
{
    //This is the equivalent of a force conversation bubble, should only be used if you want an NPC
    //to say something while he is already engaged in combat.
    if(GetSpawnInCondition(NW_FLAG_SPECIAL_COMBAT_CONVERSATION) && GetIsPC(GetLastPerceived()) && GetLastPerceptionSeen())
    {
        SpeakOneLinerConversation();
    }
    //If the last perception event was hearing based or if someone vanished then go to search mode
    if ((GetLastPerceptionVanished()) && GetIsEnemy(GetLastPerceived()))
    {
        object oGone = GetLastPerceived();
        if((GetAttemptedAttackTarget() == GetLastPerceived() ||
           GetAttemptedSpellTarget() == GetLastPerceived() ||
           GetAttackTarget() == GetLastPerceived()) && GetArea(GetLastPerceived()) != GetArea(OBJECT_SELF))
        {
           ClearAllActions();
           DetermineCombatRound();
        }
    }
    //Do not bother checking the last target seen if already fighting
    else if(!GetIsObjectValid(GetAttemptedAttackTarget()) && !GetIsObjectValid(GetAttemptedSpellTarget()))
    {
        //Check if the last percieved creature was actually seen
        if(GetLastPerceptionSeen())
        {
            if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
            {
                DetermineSpecialBehavior();
            }
            else if(GetIsEnemy(GetLastPerceived()))
            {
                if(!GetHasEffect(EFFECT_TYPE_SLEEP))
                {
                    SetFacingPoint(GetPosition(GetLastPerceived()));
                    SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK);
                    DetermineCombatRound();
                }
            }
            //Linked up to the special conversation check to initiate a special one-off conversation
            //to get the PCs attention
            else if(GetSpawnInCondition(NW_FLAG_SPECIAL_CONVERSATION) && GetIsPC(GetLastPerceived()))
            {
                ActionStartConversation(OBJECT_SELF);
            }
        }
    }
    if(GetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT) && GetLastPerceptionSeen())
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1002));
    }

    object oPC = GetLastPerceived();
    if (!GetIsPC(oPC) && !GetIsDM(oPC))
        return;
    if (GetLocalInt(oPC, "TylnWarned") == TRUE)
        return;

    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    if (GetIsObjectValid(oWeapon))
    {
        TurnToFaceObject(oPC);
        string sSpeak;
        int iRandom = d6();
        switch (iRandom)
        {
            case 1: sSpeak = "Hey, put that weapon away!"; break;
            case 2: sSpeak = "You can't walk around here with that thing out!"; break;
            case 3: sSpeak = "Put that away!"; break;
            case 4: sSpeak = "No weapons in here please!"; break;
            case 5: sSpeak = "Oi!  Put that weapon away!"; break;
            default: sSpeak = "I'm not warning you again!  Put the weapon away"; break;
        }
        SpeakString(sSpeak);
        SetLocalInt(oPC, "TylnWarned", TRUE);
        DelayCommand(10.0, SetLocalInt(oPC, "TylnWarned", FALSE));
    }
}

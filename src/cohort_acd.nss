//::///////////////////////////////////////////////
//:: Resurrecting Cohort UserDefinedActions Script.
//:: cohort_rez_acd
//:://////////////////////////////////////////////
/*
    v1.0.6  - Cohorts are less shouty when getting help.
            - Cohorts provide location information when dragging corpses.
            - PW Cohort support.
            - Cohorts Seeking Employment.
            - Cohorts Signing up for welfare.... Just kidding :)

    v1.0.5  Added text references from cohort_text.
            Cohorts will now ask for monetary aid from players if needed.
            Message spamming should be reduced.
            (yibble)

    v1.0.3  Removed use of REZMASTERONLY. Now that Cohorts can help others through
    conversation, there was no need for it anymore.

    The new ghost system in HCR 1.8.7 causes some major headaches, as Fugue
    makes for good timing. This script will not work with the ghost system on!
    (yibble)

*/
//:://////////////////////////////////////////////
//:: Created By: Nathan 'yibble' Reynolds <yibble@yibble.org>
//:: Created On: 09/02/2002
//:://////////////////////////////////////////////
#include "cohort_inc"

void main()
{
    int nUser = GetUserDefinedEventNumber();

    if(nUser == 1001) //HEARTBEAT
    {
        object oCreature = GetNearestObjectByTag("DeathCorpse");
        object oOwner = GetLocalObject(oCreature, "Owner");
        object oRealMaster = GetLocalObject(OBJECT_SELF, "RealMaster");
        object oItem1, oItem2;

//::///////////////////////////////////////////////////
// EMERGENCY ACTIONS TO BE TAKEN IF THE MASTER DIES :(
//::///////////////////////////////////////////////////

    /* Check for a Death Corpse of the player that this cohort is working for */
        if(GetBeenHired())
        {
            if((GetIsObjectValid(oCreature)) && (GetDistanceToObject(oCreature) <= CORPSEDISTANCE) && (oRealMaster == oOwner) && (GetTag(GetArea(oRealMaster)) == FUGUEPLANETAG))
            {

    /* Check if the caller has a BW or HCR Resurrection Scroll. Innate level for
    this scroll is listed as level 7 cleric. */
                if((GetIsObjectValid(GetItemPossessedBy(OBJECT_SELF,"NW_IT_SPDVSCR702"))) || (GetIsObjectValid(GetItemPossessedBy(OBJECT_SELF,"Resurrection"))))
                {
                    if(REZLEVELLIMIT)
                    {
                        if(GetLevelByClass(CLASS_TYPE_CLERIC, OBJECT_SELF) >= RESURRECTION_INNATE_LEVEL)
                           UseScrollOnObject(SPELL_RESURRECTION, oCreature);
                    }
                    else
                       UseScrollOnObject(SPELL_RESURRECTION, oCreature);
                }

    /* Check if the caller has a BW or HCR Raise Dead Scroll. Innate level for
    this scroll is listed as level 5 cleric. */
                else if((GetIsObjectValid(GetItemPossessedBy(OBJECT_SELF,"NW_IT_SPDVSCR501"))) || (GetIsObjectValid(GetItemPossessedBy(OBJECT_SELF,"RaiseDead"))))
                {
                    if(REZLEVELLIMIT)
                    {
                        if(GetLevelByClass(CLASS_TYPE_CLERIC, OBJECT_SELF) >= RAISEDEAD_INNATE_LEVEL)
                            UseScrollOnObject(SPELL_RAISE_DEAD, oCreature);
                    }
                    else
                        UseScrollOnObject(SPELL_RAISE_DEAD, oCreature);
                }

    /* Check to see if the cohort has a Resurrection spell. */
                else if(GetHasSpell(SPELL_RESURRECTION))
                {
                    if(REZFEEDBACK)
                    {
                        SpeakString(REZFEEDBACK1);
                        SendMessageToPC(oRealMaster, GetName(OBJECT_SELF) + ": " + REZFEEDBACK4);
                    }
                    ClearAllActions();
                    ActionCastSpellAtObject(SPELL_RESURRECTION, oCreature);
                }

    /* Check to see if cohort has a Raise Dead spell. */
                else if(GetHasSpell(SPELL_RAISE_DEAD))
                {
                    if(REZFEEDBACK)
                    {
                        SpeakString(REZFEEDBACK1);
                        SendMessageToPC(oRealMaster, GetName(OBJECT_SELF) + ": " + REZFEEDBACK5);
                    }
                    ClearAllActions();
                    ActionCastSpellAtObject(SPELL_RAISE_DEAD, oCreature);
                }

    /* Scrolls and Spells fail, so let's try to locate a Resurrection scroll in
    the immediate area. */
                else if(((GetIsObjectValid(oItem1 = GetNearestObjectByTag("NW_IT_SPDVSCR702")) && (GetDistanceToObject(oItem1) <= CORPSEDISTANCE)) || ((GetIsObjectValid(oItem2 = GetNearestObjectByTag("Resurrection")) && (GetDistanceToObject(oItem2) <= CORPSEDISTANCE)))))
                {
                    if(REZFEEDBACK)
                    {
                        SpeakString(REZFEEDBACK6);
                        SendMessageToPC(oRealMaster, GetName(OBJECT_SELF) + ": " + REZFEEDBACK7);
                    }
                    ClearAllActions();

                    if(GetIsObjectValid(oItem1))
                        AssignCommand(OBJECT_SELF, ActionPickUpItem(oItem1));
                    else
                        AssignCommand(OBJECT_SELF, ActionPickUpItem(oItem2));
                }

    /* Let's try to locate a Raise Dead scroll in the immediate area. */
                else if(((GetIsObjectValid(oItem1 = GetNearestObjectByTag("NW_IT_SPDVSCR501")) && (GetDistanceToObject(oItem1) <= CORPSEDISTANCE)) || ((GetIsObjectValid(oItem2 = GetNearestObjectByTag("RaiseDead")) && (GetDistanceToObject(oItem2) <= CORPSEDISTANCE)))))
                {
                    if(REZFEEDBACK)
                    {
                        SpeakString(REZFEEDBACK6);
                        SendMessageToPC(oRealMaster, GetName(OBJECT_SELF) + ": " + REZFEEDBACK8);
                    }
                    ClearAllActions();

                    if(GetIsObjectValid(oItem1))
                        AssignCommand(OBJECT_SELF, ActionPickUpItem(oItem1));
                    else
                        AssignCommand(OBJECT_SELF, ActionPickUpItem(oItem2));
                }

    /* Search the owners body for a Resurrection scroll. */
                else if((GetIsObjectValid(oItem1 = GetItemPossessedBy(oCreature, "NW_IT_SPDVSCR702"))) || (GetIsObjectValid(oItem2 = GetItemPossessedBy(oCreature, "Resurrection"))))
                {
                    if(REZFEEDBACK)
                    {
                        SpeakString(REZFEEDBACK9);
                        SendMessageToPC(oRealMaster, GetName(OBJECT_SELF) + ": " + REZFEEDBACK10);
                    }
                    ClearAllActions();

                    if(GetIsObjectValid(oItem1))
                        DestroyObject(oItem1);
                    else
                        DestroyObject(oItem2);
                    CreateItemOnObject("sy_it_spdvscr706");

                    AssignCommand(OBJECT_SELF, ActionForceMoveToLocation(GetLocation(oCreature), TRUE));
                    AssignCommand(OBJECT_SELF, ActionInteractObject(oCreature));
                }

    /* Search the owners body for a Raise Dead scroll. */
                else if((GetIsObjectValid(oItem1 = GetItemPossessedBy(oCreature, "NW_IT_SPDVSCR501"))) || (GetIsObjectValid(oItem2 = GetItemPossessedBy(oCreature, "RaiseDead"))))
                {
                    if(REZFEEDBACK)
                    {
                        SpeakString(REZFEEDBACK9);
                        SendMessageToPC(oRealMaster, GetName(OBJECT_SELF) + ": " + REZFEEDBACK11);
                    }
                    ClearAllActions();

                    if(GetIsObjectValid(oItem1))
                        DestroyObject(oItem1);
                    else
                        DestroyObject(oItem2);
                    CreateItemOnObject("sy_it_spdvscr505");

                    AssignCommand(OBJECT_SELF, ActionForceMoveToLocation(GetLocation(oCreature), TRUE));
                    AssignCommand(OBJECT_SELF, ActionInteractObject(oCreature));
                }

    /* all else fails? grab the body. */
                else if((GetItemPossessedBy(OBJECT_SELF, "PlayerCorpse") == OBJECT_INVALID) && (!GetLocalInt(OBJECT_SELF, "SeekingRez")) && (GetTag(GetArea(oRealMaster)) == FUGUEPLANETAG))
                {
                    object oPlayerCorpse = GetItemPossessedBy(oCreature, "PlayerCorpse");
                    object oDupePlayerCorpse;

        /* from hc_on_play_death */
                    string sName=GetName(oRealMaster);
                    string sCDK=GetPCPublicCDKey(oRealMaster);
                    string sID=sName+sCDK;

                    if(GetIsObjectValid(oPlayerCorpse))
                    {
                        ClearAllActions();
                        AssignCommand(OBJECT_SELF, ActionForceMoveToLocation(GetLocation(oCreature), TRUE));
                        AssignCommand(OBJECT_SELF, ActionInteractObject(oCreature));

        /* as ActionTakeItem doesn't seem to work on placeables, we're going to have
        to do this the hard way. */
                        if(GetIsObjectValid(oDupePlayerCorpse = CreateItemOnObject("playercorpse", OBJECT_SELF)))
                        {

        /* from hc_on_play_death */
                            SetLocalObject(oDupePlayerCorpse, "Owner", (GetLocalObject(oPlayerCorpse, "Owner")));
                            SetLocalObject(oDupePlayerCorpse, "DeathCorpse", (GetLocalObject(oPlayerCorpse, "DeathCorpse")));
                            SetLocalString(oDupePlayerCorpse, "Name", (GetLocalString(oPlayerCorpse, "Name")));
                            SetLocalString(oDupePlayerCorpse, "Key", (GetLocalString(oPlayerCorpse, "Key")));
                            SetLocalInt(oDupePlayerCorpse, "Alignment", (GetLocalInt(oPlayerCorpse, "Alignment")));
                            SetLocalString(oDupePlayerCorpse, "Deity", (GetLocalString(oPlayerCorpse, "Deity")));
                            SetLocalObject(GetModule(), "PlayerCorpse" + sID, oDupePlayerCorpse);

                            DestroyObject(oPlayerCorpse);

        /* from hc_on_acq_item */
                            object oDeathCorpse=CreateObject(OBJECT_TYPE_PLACEABLE, "DeathCorpse",GetLocation(GetObjectByTag("StorageMarker")));

                            SetLocalObject(oRealMaster, "DeathCorpse", oDeathCorpse);
                            SetLocalObject(GetModule(), "DeathCorpse" + sName + sCDK, oDeathCorpse);
                            SetLocalObject(oDeathCorpse, "Owner", oRealMaster);
                            SetLocalString(oDeathCorpse, "Name", sName);
                            SetLocalString(oDeathCorpse, "Key", sCDK);
                            SetLocalObject(oDeathCorpse, "PlayerCorpse", oRealMaster);
                            hcTransferObjects(oCreature, oDeathCorpse);

                            SetLocalInt(OBJECT_SELF, "SeekingRez", TRUE);

                            if(REZFEEDBACK)
                            {
                                SpeakString(REZFEEDBACK12);
                                SendMessageToPC(oRealMaster, GetName(OBJECT_SELF) + ": " + REZFEEDBACK13);
                            }
                        }
                        else
                            if(REZFEEDBACK)
                                SendMessageToPC(oRealMaster, GetName(OBJECT_SELF) + ": " + REZFEEDBACK14);
                    }
                }
            }

    /* once we have the body, we need to seek a resurrection. */
            else if((GetItemPossessedBy(OBJECT_SELF, "PlayerCorpse") != OBJECT_INVALID) && (GetLocalInt(OBJECT_SELF, "SeekingRez")) && (!GetLocalInt(OBJECT_SELF, "WaitingRez")) && (GetTag(GetArea(GetLocalObject(GetItemPossessedBy(OBJECT_SELF, "PlayerCorpse"), "Owner"))) == FUGUEPLANETAG))
            {
                object oPlayerCorpse = GetItemPossessedBy(OBJECT_SELF, "PlayerCorpse");
                location lDestination;

                if(PWCOHORT)
                    lDestination = GetPersistentLocation(OBJECT_SELF, "EmergencyHomeBase");
                else
                    lDestination = GetLocation(GetObjectByTag(COHORTTOWNCENTRE + GetTag(OBJECT_SELF)));

                object oTarget;

                int iRezzersLevel;

    /* is a useable PC nearby? */
                if((GetIsObjectValid(oTarget = GetNearestCreature(CREATURE_TYPE_CLASS, CLASS_TYPE_CLERIC))) && (GetIsPC(oTarget)) && (GetDistanceToObject(oTarget) <= CORPSEDISTANCE) && (iRezzersLevel= GetLevelByClass(CLASS_TYPE_CLERIC, oTarget) >= PCSEEKLEVEL) && (!IsInConversation(oTarget)) && (GetLocalInt(OBJECT_SELF, "SeekingRez")) && (!GetLocalInt(OBJECT_SELF, "WaitingRez")) && (!GetLocalInt(oTarget, "RefusedRez" + GetTag(OBJECT_SELF))))
                {
                    ClearAllActions();
                    SpeakString(REZFEEDBACK15);

                    if(REZFEEDBACK)
                        SendMessageToPC(oRealMaster, GetName(OBJECT_SELF) + ": " + REZFEEDBACK16);

                    ActionStartConversation(oTarget);
                }

    /* is a useable NPC nearby? */
                else if((GetIsObjectValid(oTarget = GetNearestCreature(CREATURE_TYPE_CLASS, CLASS_TYPE_CLERIC))) && (!GetIsPC(oTarget)) && (GetDistanceToObject(oTarget) <= CORPSEDISTANCE) && (iRezzersLevel = GetLevelByClass(CLASS_TYPE_CLERIC, oTarget) >= NPCSEEKLEVEL) && (!IsInConversation(oTarget)) && (!GetLocalInt(OBJECT_SELF, "NPCNoRez")))
                {
    /* from hc_act_pct */
                    if(REZFEEDBACK)
                        SendMessageToPC(oRealMaster, GetName(OBJECT_SELF) + ": " + REZFEEDBACK17);
                    SetLocalObject(OBJECT_SELF,"CLERIC", oTarget);
                    SetLocalObject(OBJECT_SELF,"DEADMAN", oRealMaster);
                    SetLocalObject(OBJECT_SELF,"ITEM", GetItemPossessedBy(OBJECT_SELF, "PlayerCorpse"));
                    ExecuteScript("cohort_act_pct", OBJECT_SELF);
                }

    /* check to see if cohort is begging and a PC is nearby with funds. */
                else if((GetIsObjectValid(oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC))) && (GetDistanceToObject(oTarget) <= CORPSEDISTANCE) && (!IsInConversation(oTarget)) && (GetLocalInt(OBJECT_SELF, "SeekingRez")) && (!GetLocalInt(OBJECT_SELF, "WaitingRez")) && (!GetLocalInt(oTarget, "RefusedCoin" + GetTag(OBJECT_SELF))) && (GetLocalInt(OBJECT_SELF, "NPCNoRez") > 1) && (GetGold(oTarget) >= (GetLocalInt(OBJECT_SELF, "NPCNoRez") - GetGold(OBJECT_SELF))))
                {
                    ClearAllActions();
                    SpeakString(REZFEEDBACK24);

                    if(REZFEEDBACK)
                        SendMessageToPC(oRealMaster, GetName(OBJECT_SELF) + ": " + REZFEEDBACK25);

                    ActionStartConversation(oTarget);
                }
                else if((GetLocation(OBJECT_SELF) != lDestination))
                {
                    float fCurrentMagnitude;

                    fCurrentMagnitude = VectorMagnitude(GetPosition(OBJECT_SELF));

                    if(fCurrentMagnitude == GetLocalFloat(OBJECT_SELF, "LastLocationRez"))
                    {
                        if(REZFEEDBACK)
                            SendMessageToPC(oRealMaster, GetName(OBJECT_SELF) + ": " + REZFEEDBACK18);
                        ActionDoCommand(ActionJumpToLocation(lDestination));
                    }
                    else
                    {
                        if(REZFEEDBACK)
                            SendMessageToPC(oRealMaster, GetName(OBJECT_SELF) + ": " + REZFEEDBACK19 + GetName(GetAreaFromLocation(GetLocation(OBJECT_SELF))) + REZFEEDBACK19a + GetName(GetAreaFromLocation(lDestination)) + ".");
                        SetLocalFloat(OBJECT_SELF, "LastLocationRez", fCurrentMagnitude);
                        ActionDoCommand(ActionForceMoveToLocation(lDestination, FALSE));
                    }
                }
            }

    /* we don't have a PCT, but we're waiting for a rez from a player who has
    offered to help us. */
            else if((GetItemPossessedBy(OBJECT_SELF, "PlayerCorpse") != OBJECT_INVALID) && (GetLocalInt(OBJECT_SELF, "SeekingRez")) && (GetLocalInt(OBJECT_SELF, "WaitingRez")) && (GetTag(GetArea(GetLocalObject(GetItemPossessedBy(OBJECT_SELF, "PlayerCorpse"), "Owner"))) == FUGUEPLANETAG))
            {
                int iCount;
                object oRezzer;

    /* increment the waiting round timer */
                iCount = GetLocalInt(OBJECT_SELF, "WaitingRez");
                iCount ++;
                SetLocalInt(OBJECT_SELF, "WaitingRez", iCount);
                if(REZFEEDBACK)
                    SendMessageToPC(oRealMaster, GetName(OBJECT_SELF) + ": " + REZFEEDBACK20 + IntToString(iCount) + REZFEEDBACK21);

    /* if we've waited long enough, the PC is probably wasting our time. */
                if(iCount == PCREZWAITLIMIT)
                {
                    SetLocalInt(OBJECT_SELF, "SeekingRez", FALSE);
                    SetLocalInt(OBJECT_SELF, "WaitingRez", FALSE);
                    SetLocalInt(oRezzer = GetLocalObject(OBJECT_SELF, "OfferedRez"), "RefusedRez" + GetTag(OBJECT_SELF), TRUE);
                    if(REZFEEDBACK)
                        SendMessageToPC(oRealMaster, GetName(OBJECT_SELF) + ": " + GetName(oRezzer) + REZFEEDBACK22);
                }
            }
        }

//::///////////////////////////////////////////////////
// COHORT SEEKING EMPLOYMENT (Persistent)
//::///////////////////////////////////////////////////
        else if(!GetBeenHired() && (PWCOHORT))
        {
            if((SEEKEMPLOYMENT) && (GetLocalInt(OBJECT_SELF, "SEEKEMPLOYMENT")) && (USELEADERSHIP))
            {
                object oPC = GetFirstPC();
                string sTag = GetTag(OBJECT_SELF);

    /* So we've not been hired and we're not seeking a valid object. */
                if((!GetIsObjectValid(GetPersistentObject(OBJECT_SELF, "SeekingEmploymentBy"))) && (Random(99) >= GetLocalInt(OBJECT_SELF, "CHANCEEMPLOYMENT")))
                {
                    oPC = GetFirstPC();
                    while(GetIsObjectValid(oPC))
                    {
                        if(!GetPersistentInt(oPC, sTag + "RefusedEmployment"))
                        {
                            if((GetHasFeat(FEAT_SKILL_FOCUS_PERSUADE, oPC)) && (GetHitDice(oPC) >= 6) && (GetHitDice(oPC) - GetHitDice(OBJECT_SELF) >= COHORTLAG) && (!GetPersistentInt(oPC, GetTag(OBJECT_SELF) + "RefusedSeekingEmployment")))
                            {
                                SetPersistentObject(OBJECT_SELF, "SeekingEmploymentBy", oPC);
                                break;
                            }
                        }
                        oPC = GetNextPC();
                    }
                }
                if((GetIsObjectValid(oPC = GetPersistentObject(OBJECT_SELF, "SeekingEmploymentBy"))) && (GetArea(oPC) == GetArea(OBJECT_SELF)) && (!IsInConversation(oPC)) && (!GetIsInCombat(oPC)))
                {
                    //SendMessageToPC(oPC, GetName(OBJECT_SELF) + "DEBUG:cohort_acd:I'm attempting to initiate a conversation with you at " + GetName(GetAreaFromLocation(GetLocation(OBJECT_SELF))));
                    ActionDoCommand(ActionStartConversation(oPC));
                }
                else if(GetIsObjectValid(oPC = GetPersistentObject(OBJECT_SELF, "SeekingEmploymentBy")))
                {
                    //SendMessageToPC(oPC, GetName(OBJECT_SELF) + "DEBUG:cohort_acd:I am seeking employment with you. I am at " + GetName(GetAreaFromLocation(GetLocation(OBJECT_SELF))));
                    ActionDoCommand(ActionForceMoveToLocation(GetLocation(oPC), TRUE));
                }
            }
        }
//::///////////////////////////////////////////////////
// COHORT SEEKING EMPLOYMENT (non-Persistent)
//::///////////////////////////////////////////////////
        else if(!GetBeenHired() && (!PWCOHORT))
        {
            if((SEEKEMPLOYMENT) && (GetLocalInt(OBJECT_SELF, "SEEKEMPLOYMENT")) && (USELEADERSHIP))
            {
                object oPC = GetFirstPC();
                string sTag = GetTag(OBJECT_SELF);

    /* So we've not been hired and we're not seeking a valid object. */
                if((!GetIsObjectValid(GetLocalObject(OBJECT_SELF, "SeekingEmploymentBy"))) && (Random(99) <= GetLocalInt(OBJECT_SELF, "CHANCEEMPLOYMENT")))
                {
                    oPC = GetFirstPC();
                    while(GetIsObjectValid(oPC))
                    {
                        if(!GetLocalInt(oPC, sTag + "RefusedEmployment"))
                        {
                            if((GetHasFeat(FEAT_SKILL_FOCUS_PERSUADE, oPC)) && (GetHitDice(oPC) >= 6) && (GetHitDice(oPC) - GetHitDice(OBJECT_SELF) >= COHORTLAG) && (!GetLocalInt(oPC, GetTag(OBJECT_SELF) + "RefusedSeekingEmployment")))
                            {
                                SetLocalObject(OBJECT_SELF, "SeekingEmploymentBy", oPC);
                                break;
                            }
                        }
                        oPC = GetNextPC();
                    }
                }
                if((GetIsObjectValid(oPC = GetLocalObject(OBJECT_SELF, "SeekingEmploymentBy"))) && (GetArea(oPC) == GetArea(OBJECT_SELF)) && (!IsInConversation(oPC)) && (!GetIsInCombat(oPC)))
                {
                    //SendMessageToPC(oPC, GetName(OBJECT_SELF) + "DEBUG:cohort_acd:I'm attempting to initiate a conversation with you at " + GetName(GetAreaFromLocation(GetLocation(OBJECT_SELF))));
                    ActionDoCommand(ActionStartConversation(oPC));
                }
                else if(GetIsObjectValid(oPC = GetLocalObject(OBJECT_SELF, "SeekingEmploymentBy")))
                {
                    //SendMessageToPC(oPC, GetName(OBJECT_SELF) + "DEBUG:cohort_acd:I am seeking employment with you. I am at " + GetName(GetAreaFromLocation(GetLocation(OBJECT_SELF))));
                    ActionDoCommand(ActionForceMoveToLocation(GetLocation(oPC), TRUE));
                }
            }
        }

    }
}



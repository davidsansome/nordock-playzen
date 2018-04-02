//::///////////////////////////////////////////////
//:: Resurrecting Cohort ActionsTaken Script.
//:: cohortdlg_rez_at
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    v1.0.5   Now uses text references.

    v1.0.3   This script is to be used on the ActionsTaken hook for in a
    conversation file, for when the NPC is instructed to resurrect a Death
    Corpse.

*/
//:://////////////////////////////////////////////
//:: Created By: Nathan 'yibble' Reynolds <yibble@yibble.org>
//:: Created On: 02/09/2002
//:://////////////////////////////////////////////
#include "cohort_inc"

void main()
{
    object oCreature = GetNearestObjectByTag("DeathCorpse");
    object oOwner = GetLocalObject(oCreature, "Owner");
    object oItem1, oItem2;

/* Check for a Death Corpse of the player that this cohort is working for if
REZMASTERONLY == TRUE. If REZMASTERONLY == FALSE, check for a Death Corpse
of anyone. */
    if((GetIsObjectValid(oCreature)) && (GetDistanceBetween(OBJECT_SELF, oCreature) <= CORPSEDISTANCE))
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
                SendMessageToPC(oOwner, GetName(OBJECT_SELF) + ": " + REZFEEDBACK4);
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
                SendMessageToPC(oOwner, GetName(OBJECT_SELF) + ": " + REZFEEDBACK5);
            }
            ClearAllActions();
            ActionCastSpellAtObject(SPELL_RAISE_DEAD, oCreature);
        }
        else
            SpeakString(REZFEEDBACK23);
    }
}

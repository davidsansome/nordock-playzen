//::///////////////////////////////////////////////
//:: Time Stop
//:: NW_S0_TimeStop.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All persons in the Area are frozen in time
    except the caster.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////

/*This is a modified version of kaltors PW friendly time stop script
It has been modified to do several new functions

--It not will not dominate summoned units, to prevent them from becomine masterless
--It follows standard 9.0 second timestop with a .75 delay
--It applies a small visual affect to all units to show a timestop in effect
--It applies a knockdown effect to summoned units to prevent them doing anything(no summoned unit has
  immune to knockdown to my knowledge
--it applies a Immobilize effect to prevent units from moving (an occasional bug with big PW's on high CPU load).

Modification by Robin - 1st Mar 2005
-- Doesn't affect players immune to Transmutation
-- Mages cast timestop for 15 seconds, scroll-users cast for 1+1d6 seconds
*/

int GetIsItemImmuneToTimestop(object oItem)
{
    itemproperty pProp = GetFirstItemProperty(oItem);
    while (GetIsItemPropertyValid(pProp) == TRUE)
    {
        if (GetItemPropertyType(pProp) == ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL)
        {
            if (GetItemPropertySubType(pProp) == 7) // Transmutation
                return TRUE;
        }
        pProp = GetNextItemProperty(oItem);
    }
    return FALSE;
}

int GetIsImmuneToTimestop(object oTG)
{
    if (GetIsItemImmuneToTimestop(GetItemInSlot(INVENTORY_SLOT_ARMS, oTG)) == TRUE) return TRUE;
    if (GetIsItemImmuneToTimestop(GetItemInSlot(INVENTORY_SLOT_ARROWS, oTG)) == TRUE) return TRUE;
    if (GetIsItemImmuneToTimestop(GetItemInSlot(INVENTORY_SLOT_BELT, oTG)) == TRUE) return TRUE;
    if (GetIsItemImmuneToTimestop(GetItemInSlot(INVENTORY_SLOT_BOLTS, oTG)) == TRUE) return TRUE;
    if (GetIsItemImmuneToTimestop(GetItemInSlot(INVENTORY_SLOT_BOOTS, oTG)) == TRUE) return TRUE;
    if (GetIsItemImmuneToTimestop(GetItemInSlot(INVENTORY_SLOT_BULLETS, oTG)) == TRUE) return TRUE;
    if (GetIsItemImmuneToTimestop(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oTG)) == TRUE) return TRUE;
    if (GetIsItemImmuneToTimestop(GetItemInSlot(INVENTORY_SLOT_CHEST, oTG)) == TRUE) return TRUE;
    if (GetIsItemImmuneToTimestop(GetItemInSlot(INVENTORY_SLOT_CLOAK, oTG)) == TRUE) return TRUE;
    if (GetIsItemImmuneToTimestop(GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oTG)) == TRUE) return TRUE;
    if (GetIsItemImmuneToTimestop(GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oTG)) == TRUE) return TRUE;
    if (GetIsItemImmuneToTimestop(GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oTG)) == TRUE) return TRUE;
    if (GetIsItemImmuneToTimestop(GetItemInSlot(INVENTORY_SLOT_HEAD, oTG)) == TRUE) return TRUE;
    if (GetIsItemImmuneToTimestop(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTG)) == TRUE) return TRUE;
    if (GetIsItemImmuneToTimestop(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oTG)) == TRUE) return TRUE;
    if (GetIsItemImmuneToTimestop(GetItemInSlot(INVENTORY_SLOT_NECK, oTG)) == TRUE) return TRUE;
    if (GetIsItemImmuneToTimestop(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTG)) == TRUE) return TRUE;
    if (GetIsItemImmuneToTimestop(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oTG)) == TRUE) return TRUE;
    return FALSE;
}

void main()
{
    object oArea = GetArea(OBJECT_SELF);
    location lLocation = GetLocation(OBJECT_SELF);
    object oTG = GetFirstObjectInArea(oArea);

    float fDuration;

    int iMageClasses = GetLevelByClass(CLASS_TYPE_SORCERER) + GetLevelByClass(CLASS_TYPE_WIZARD);
    if (iMageClasses <= 8)
        fDuration = 1.0 + d6();
    else
        fDuration = 15.0;

    while (oTG != OBJECT_INVALID)
    {
        if(GetObjectType(oTG) == OBJECT_TYPE_CREATURE && oTG != OBJECT_SELF && !GetIsDM(oTG) && !GetIsImmuneToTimestop(oTG))
        {
            if(!GetIsObjectValid(GetMaster(oTG)))
            {
                DelayCommand(0.75f, AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneDominated(), oTG, fDuration)));
            }
            else
            {
                DelayCommand(0.75f, AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(), oTG, fDuration)));
            }
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_BLUR), oTG, fDuration + 0.75f);
            DelayCommand(0.75f, AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oTG, fDuration + 0.75f)));
        }
        oTG = GetNextObjectInArea(oArea);
    }
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_TIME_STOP, FALSE));

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_TIME_STOP), lLocation);
}



//::////////////////////////////////////////////////////:://
//:: Invizible420's Alternate Timestop Spell          //:://
//::                                                  //:://
//:: By: Invizible420                                 //:://
//:: (Created 12/20/02 updated 12/27/02 (v 1.05)      //:://
//::////////////////////////////////////////////////////:://
//::                                                  //:://
//:: Persistent World Workaround for Bioware's        //:://
//:: Default Timestop Spell.  This will Decrease      //:://
//:: Attack and Movement Speed, then CutSceneDominate //:://
//:: creatures within a radius of the caster.         //:://
//::                                                  //:://
//:: This version now uses the module to dominate the //:://
//:: the creatures, this stops PC from dominating     //:://
//:: other PC's.  Also added a fix to not dominate    //:://
//:: a caster's familiars.                            //:://
//::                                                  //:://
//:: Contact info/Bug Reports: Digiddy777@yahoo.com   //:://
//::////////////////////////////////////////////////////:://
//:: Edited by: Nakey                                 //:://
//:: Edited on: 24-01-04                              //:://
//:: Line(s) edited: 76                               //:://
//:: Changes: Script now checks for variable on a     //:://
//:: creature (GA_TS_IMMUNE) and skips applying the   //:://
//:: TS effects if it equals 1.                       //:://
//::////////////////////////////////////////////////////:://
/*#include "NW_I0_GENERIC"

// Customize User Defined Variables
float fDur   = 15.0; // Duration in seconds
float fDist  = 45.0; // Radius in meters
int iSlow    = 100;  // Percentage to decrease movement by
int iDAttack = 100;  // Amount to decrease attack by



// Function to resume creature(s) previous actions wrapped for Delay
void ResumeLast(object oResumee, object oIntruder)
    {
    // Delay DetermineCombatRound
    DelayCommand(fDur+0.25,AssignCommand(oResumee,DetermineCombatRound(oIntruder)));
    }

// Function to control TimeStop effects
void TSEffects(object oEffector, object oCaster)
    {
    // Check if stopped creature is a hostile
    if (GetIsReactionTypeHostile(oCaster,oEffector) == TRUE) {
    // Start the resume combat round after Timestop
    ResumeLast(oEffector, oCaster);
    }
    // Decrease the creature(s) attack
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAttackDecrease(iDAttack,ATTACK_BONUS_MISC),oEffector,fDur);
    // Stop the creature(s) from moving for fDur seconds
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectMovementSpeedDecrease(iSlow),oEffector,fDur);
    // Make module dominate the creature(s) for fDur seconds
    AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneDominated(),oEffector,fDur));
    // Clear the creature(s) action que
    AssignCommand(oEffector,ClearAllActions(TRUE));
    // Disable Commandable (actions que)
    SetCommandable(FALSE,oEffector);
    // Enable Commandable after fDur
    DelayCommand(fDur,SetCommandable(TRUE,oEffector));
    }

// Function to get creature(s) within radius and apply the alternate TimeStop
void TimeStop(object oTarget)
    {
    object oNearestC;  // Define nearest creature
    // Begin loop to find all creatures within the fDist meter radius
    oNearestC = GetFirstObjectInShape(SHAPE_SPHERE, fDist, GetSpellTargetLocation(), FALSE, OBJECT_TYPE_CREATURE);
    while(GetIsObjectValid(oNearestC))
         {
         // To make sure it doesn't stop the caster or caster's familiar
         string sNCName = GetName(oNearestC);
         if (oNearestC != oTarget && GetAnimalCompanionName(oTarget) != sNCName && GetLocalInt(oNearestC, "GA_TS_IMMUNE") != 1)  {
            // Start the TimeStop effects
            DelayCommand(0.75,TSEffects(oNearestC,oTarget));
            }
         // Get the next creature in the fDist meter radius and continue loop
         oNearestC = GetNextObjectInShape(SHAPE_SPHERE, fDist, GetSpellTargetLocation(), FALSE, OBJECT_TYPE_CREATURE);
         }
    }

// Begin Main Function
void main()
    {
    //Signal event to start the TimeStop
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_TIME_STOP, FALSE));
    // Begin custom TimeStop
    TimeStop(OBJECT_SELF);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_TIME_STOP), GetSpellTargetLocation());
    }
    */

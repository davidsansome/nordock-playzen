// hc_acquire - test for getting objects
// Archaegeo 2002 June 29

// hc_include file, lots of constants
#include "hc_inc"
#include "hc_inc_transfer"
#include "hc_inc_on_acq"
//#include "i_tagtests"
#include "ats_inc_acquire"
#include "journal_include"
#include "rr_persist"
#include "apts_inc_ptok"

void main()
{
    object oItem = GetModuleItemAcquired();
    object oPossessor = GetItemPossessor(oItem);
    if (!GetIsPC(oPossessor))
        return;

    object oLoser = GetModuleItemAcquiredFrom();

    if(!preEvent()) return;
    ATS_OnAcquireItem(oPossessor, oItem, oLoser);
//  int nBT=GetLocalInt(oMod,"BURNTORCH");
    string sTag=GetTag(oItem);
//Altered by Grug - 08/10/2003
//Removed from heartbeats to reduce lag
//    if(nBT && sTag=="hc_lantern" && GetLocalInt(oItem,"BURNCOUNT")==0)
//        SetLocalInt(oItem,"BURNCOUNT", nBT * (FloatToInt(HoursToSeconds(1)/6.0)));

//Altered by Grug - 18-Apr-2004
//No longer needed, now is a nodrop item
//if(sTag=="HCRHelpwand" && GetPCPublicCDKey(oPossessor)!=
//        GetPersistentString(oMod,"PLAYERDM"))
//    {
//        DestroyObject(oItem);
//        postEvent();
//        return;
//    }

// Only reason for this script is the loot system, so save overhead
    if(GetLocalInt(oMod,"LOOTSYSTEM")==FALSE)
    {
        postEvent();
        return;
    }
    if(sTag=="bagofgold")
    {
        int nAmtGold=GetLocalInt(oItem,"AmtGold");
        GiveGoldToCreature(oPossessor,nAmtGold);
        DestroyObject(oItem);
    }
// Added by Grug 08/10/2003
// Tenser's Sword is for balors only.
// If it is being aquired then a couple of wizards are trying to exploit with polymorph
// Altered by Grug 06-01-2004 for the new shapeshifter types
    if((sTag == "NW_WSWMLS013") /* Tenser's Sword */
        || (sTag == "X2_IT_CREWPWHIP")  /* Shocking Whip */
        || (sTag == "X2_IT_CREWPWHIP2") /* Epic Shocking Whip */
        || (sTag == "X2_IT_CREWPKOBSW") /* Kobold Commando Sword */
        || (sTag == "X2_IT_CREWPKOBS2") /* Kobold Commando Sword */
        || (sTag == "X2_WDROWLS002") /* Drow Venomblade +3 */
        || (sTag == "x2_it_wplmss011") /* Drider Spear +2 */
        || (sTag == "x2_it_crewpvscyt") /* Risen Lord Scythe */
        || (sTag == "x2_it_frzdrowbld") /* Frozen Drow Blade */
        || (sTag == "x2_it_wplmss012") /* Drider Spear +5 */
        || (sTag == "X2_IT_MINOAXE") /* Epic Minotaur Axe */
        || (sTag == "x2_it_rakstaff") /* Rakshasa Staff */
        || (sTag == "X2_IT_CREWMAZERA") /* Azer Flaming Waraxe +5 */
        /* || "NW_WAXMBT002"  Battleaxe +1 - Allowed because it is a drop*/)
    {
        DestroyObject(oItem);
        return;
    }

// Added by Grug 08/01/2004
// Basic PP protection for predatory players
// Removed because too many items in the mod are marked as stolen
/*
effect eDominateTheif = EffectCutsceneDominated();
if (GetStolenFlag(oItem))
{
    if (GetLocalInt(oPossessor,"JUSTSTOLE") != 1)
    {
       SetLocalInt(oPossessor,"JUSTSTOLE",1);
       DelayCommand(30.0,DeleteLocalInt(oPossessor,"JUSTSTOLE"));
    }
    else
    {
       FloatingTextStringOnCreature("You fumble as you try to try to steal items too quickly!",oPossessor,FALSE);
       SendMessageToPC(oPossessor,"You fumble as you try to try to steal items too quickly!");
       AssignCommand(oPossessor,ClearAllActions(TRUE));
       AssignCommand(oPossessor,ActionPutDownItem(oItem));
       DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDominateTheif, oPossessor, 20.0));
    }
}
*/

    // Journal entries
    if (GetIsObjectValid(oLoser))
    {
        if (sTag == "TomeofDarkGlyphs")
        {
            if (GPI(oPossessor, "nMainQuest") != 1)
                dhAddJournalQuestEntry("mainquest", 1, oPossessor, FALSE, FALSE, FALSE);
            return;
        }
        else if (sTag == "TokenofPossession")
        {
            if (GPI(oPossessor, "nMainQuest") != 1)
                dhAddJournalQuestEntry("mainquest", 4, oPossessor, FALSE, FALSE, FALSE);
            return;
        }
        else if (sTag == "bloodstainednote")
        {
            if (GPI(oPossessor, "OrcShamanHeadCompleted") != 1)
                dhAddJournalQuestEntry("bloodstainednote", 1, oPossessor, FALSE, FALSE, FALSE);
            return;
        }
        else if (sTag == "CaptainTuckersSignet")
        {
            if (GetTokenBool(oPossessor, "tucker_ring") != TRUE)
                dhAddJournalQuestEntry("tucker_ring", 2, oPossessor, FALSE, FALSE, FALSE);
            return;
        }
        else if (sTag == "KoboldShamanStaff")
        {
            if (GetTokenBool(oPossessor, "kobold_staff") != TRUE)
            {
                string sSubrace = GetStringLowerCase(GetSubRace(oPossessor));
                if (sSubrace == "drow")
                    dhAddJournalQuestEntry("kobold_staff_drow", 2, oPossessor, FALSE, FALSE, FALSE);
                else if (sSubrace == "duergar")
                    dhAddJournalQuestEntry("kobold_staff_duergar", 2, oPossessor, FALSE, FALSE, FALSE);
                else
                    dhAddJournalQuestEntry("kobold_staff", 2, oPossessor, FALSE, FALSE, FALSE);
            }
            return;
        }
        else if (sTag == "DorneryllsSheath")
        {
            if (GetTokenBool(oPossessor, "dorn_quest_2") != TRUE)
                dhAddJournalQuestEntry("trondor", 3, oPossessor, TRUE, FALSE, FALSE);
            return;
        }
        else if (sTag == "GrunBaksHead")
        {
            if (GetTokenBool(oPossessor, "trgob_quest_2") != TRUE)
                dhAddJournalQuestEntry("trondor", 5, oPossessor, TRUE, FALSE, FALSE);
            return;
        }
    }

    if(sTag=="PlayerCorpse")
    {
        object oDC=GetLocalObject(oItem,"DeathCorpse");
        object oOwner=GetLocalObject(oItem,"Owner");
        string sName=GetLocalString(oItem,"Name");
        string sCDK=GetLocalString(oItem,"Key");
        object oLimbo=GetObjectByTag("StorageMarker");

// Move the Dead persons Death Corpse to _Limbo if someone picks up their
// PC Token.  This part works fine.
        if(GetIsObjectValid(oDC))
        {
            object oDeathCorpse=CreateObject(OBJECT_TYPE_PLACEABLE, "DeathCorpse",
                                GetLocation(oLimbo));
            SetLocalObject(oItem,"DeathCorpse",oDeathCorpse);
            SetLocalObject(oMod,"DeathCorpse"+sName+sCDK,oDeathCorpse);
            SetLocalObject(oDeathCorpse,"Owner",oOwner);
            SetLocalString(oDeathCorpse,"Name",sName);
            SetLocalString(oDeathCorpse,"Key",sCDK);
            SetLocalObject(oDeathCorpse,"PlayerCorpse",oItem);
            hcTransferObjects(oDC, oDeathCorpse);
        }
    }

    // Pickpocket protection
    // Robin - 1st Mar 2005

    if ((GetStolenFlag(oItem) == TRUE) && (GetResRef(oLoser) == "playerlockbox"))
    {
        // Can't take items from the lockbox
        object oCopy = CopyItem(oItem, oLoser, TRUE);
        SetStolenFlag(oCopy, FALSE);
        DestroyObject(oItem);
        return;
    }
    if ((GetStolenFlag(oItem) == TRUE) && (GetIsPC(oLoser) || GetIsPC(GetItemPossessor(oLoser))))
    {
        // We've acquired a stolen item from another PC.
        // This does NOT mean it's a pickpocket - it could be due to bartering
        // a normal item with the stolen flag set.  To make sure, we check if
        // the thief dislikes the victim, or the victim dislikes the thief.
        // We assume a PC is unlikely to barter with someone set to dislike.

        object oLoserPC = oLoser;
        if (GetIsPC(GetItemPossessor(oLoser)))
            oLoserPC = GetItemPossessor(oLoser);

        if (GetIsReactionTypeHostile(oLoserPC, oPossessor) || GetIsReactionTypeHostile(oPossessor, oLoserPC))
        {
            int iResult;
            string sMessage;
            int iPPRank = GetSkillRank(SKILL_PICK_POCKET, oPossessor) / 2;

            if (GetHitDice(oLoserPC) - GetHitDice(oPossessor) <= -4)
            {
                // Victims rated effortless automatically keep their items
                iResult = 1;
                sMessage = "You fool, that victim doesn't have anything worth stealing.";
            }
            else
            {
                // Victim makes a reflex save against:
                // Thief's PP rank/2 + 1d20
                int iDC = iPPRank + d20();
                iResult = ReflexSave(oLoserPC, iDC);
                sMessage = "The item falls from your grasp, back into the pockets of your victim.";
            }

            if (iResult != 0) // If the victim succeeds, we give the item back
            {
                object oCopy = CopyItem(oItem, oLoser, TRUE);
                SetStolenFlag(oCopy, FALSE);
                DestroyObject(oItem);

                SendMessageToPC(oPossessor, sMessage);
            }

            // We now make a spot check comparison:
            // Victim's spot rank + 1d20   vs.   Thief's PP rank/2 + 1d20
            int iSpotRank = GetSkillRank(SKILL_SPOT, oLoserPC);

            if (iSpotRank + d20() > iPPRank + d20())
            {
                // If the victim succeeds the spot check, make him do 2 things:
                // 1. Speak a randomised message
                string sItemName = GetName(oItem);
                string sThiefName = GetName(oPossessor);
                switch (d4())
                {
                    case 1: AssignCommand(oLoserPC, SpeakString("Thief!  Thief!")); break;
                    case 2: AssignCommand(oLoserPC, SpeakString("Help!  Thief!")); break;
                    case 3: AssignCommand(oLoserPC, SpeakString(sThiefName + " robbed me!  Stop him!")); break;
                    case 4: AssignCommand(oLoserPC, SpeakString("Hey!  Give me back my " + sItemName)); break;
                }

                // 2. Make the victim attack the thief
                if (!GetIsInCombat(oLoserPC))
                {
                    AssignCommand(oLoserPC, ActionAttack(oPossessor));
                }
            }

            return;
        }
    }

/**************************************************
 * Start of Scott Thorne's "No Drop Items" script
 * This script makes the PC pick "undroppable"
 * items back up and take items back
 * from placeables and other PC's
 * if they decide to drop it or barter it.
 *
 * We will be using this for the subrace spell-like
 * ability items.
 *
 *  - Panduh
 **************************************************/
 /* <-- Remove this to return the no-drop script to functionality
if (GetIsNoDrop(oItem))
{

    object oOwner = GetLocalObject(oItem, "ND_OWNER");
    string sOwnerName = GetName(oOwner);
    object oPossessor = GetItemPossessor(oItem);
    string sPossessorName = GetName(oPossessor);
    string sItemName = GetName(oItem);

    if (!GetIsPC(oOwner))
    {

        if (GetIsPC(oPossessor))
        {

//Debug("Branding no-drop item " + sItemName + " to " + sPossessorName);
            SetLocalObject(oItem, "ND_OWNER", oPossessor);

        }
        else
        {

//Debug("No-drop item " + sItemName + " picked up by NPC " + sPossessorName);
            DeleteLocalObject(oItem, "ND_OWNER");  // Clear ownership

        }

    }
    else
    {

        if (sOwnerName != sPossessorName)
        {

            if (GetIsPC(oPossessor))
            {

//Debug("PC returning no-drop item " + sItemName + ", belongs to " + sOwnerName);
                AssignCommand(oPossessor, ClearAllActions());
                AssignCommand(oPossessor, ActionJumpToObject(oOwner));
                AssignCommand(oPossessor, ActionGiveItem(oItem, oOwner));
                SendMessageToPC(oPossessor, "The " + sItemName + " mysteriously vanishes from your pack!");

            }
            else
            {

//Debug("NPC took no-drop item");
                DeleteLocalObject(oItem, "ND_OWNER"); // Clear ownership

            }

        }
        else
        {

//Debug("Re-acquiring own no-drop item " + sItemName);
            // No action, re-acquiring own item
        }
    }

}  // if GetIsNoDrop()
/***************************************************
* End of Scott Thorne's "No Drop Items" script
***************************************************/
    if( FindSubString(GetTag(oItem), "_ART") > 0 )
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE), oItem, 0.0f);
        SetLocalInt(GetItemPossessor(oItem), "ART_HASART", TRUE);
    }
    postEvent();
}

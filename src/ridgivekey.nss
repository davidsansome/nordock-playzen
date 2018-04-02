//::///////////////////////////////////////////////
//:: FileName ridgivekey
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/12/2002 3:43:30 PM
//:://////////////////////////////////////////////



//::///////////////////////////////////////////////
//:: FileName riddler_check
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/12/2002 3:41:05 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "rr_persist"
#include "journal_include"

int RiddlerItemCheck()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "ATS_C_A023_N_RUB"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "ATS_C_W130_N_MIT"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "Drowheadhighpriestess"))
        return FALSE;

    return TRUE;
}





void main()
{
 //set up
 object oPC=GetPCSpeaker();
 object oItemToTake;
 object oMod = GetModule();
 int nQuestDone = GetLocalInt(oMod, "nQuestDone");
 string sDeny = "You have destroyed the BlackAvar already.";
 string sTooLate = "I'm sorry but I hve no keys left, come back tomorrow";
 // Give the speaker the items, checking for exploits
 if(RiddlerItemCheck())
        {

        if (!GPI(oPC,"nMainQuest") && !nQuestDone)
            {
            CreateItemOnObject("inodriobasementk", oPC, 1);
            }
            else if(GPI(oPC,"nMainQuest"))
            {
            SpeakString(sDeny);
            }
            else if(!GPI(oPC,"nMainQuest") && nQuestDone)
            {
            SpeakString(sTooLate);
            DestroyObject(GetObjectByTag("Riddler"));
            DestroyObject(GetObjectByTag("InoGong"));
            return;
            }
 // Remove items from the player's inventory
        oItemToTake = GetItemPossessedBy(oPC, "Drowheadhighpriestess");
        if(GetIsObjectValid(oItemToTake) != 0)
            DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "ATS_C_A023_N_RUB");
        if(GetIsObjectValid(oItemToTake) != 0)
            DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "ATS_C_W130_N_MIT");
        if(GetIsObjectValid(oItemToTake) != 0)
            DestroyObject(oItemToTake);
        // DestroyObject(GetObjectByTag("Riddler"));
        // DestroyObject(GetObjectByTag("InoGong"));
        dhAddJournalQuestEntry("mainquest", 8, GetPCSpeaker(), FALSE);
        }
    else
        {
        //Player has attempted an exploit (dropping items after meeting conversation requirements. Insult, curse & kill)
        SendMessageToPC(GetPCSpeaker(), "Do not dare to play with me, child. You have lost your chance to fulfil your destiny today");

         int iAbilityTotal = 0;
         effect CurseOfTheExploiter = EffectCurse(5, 5, 5, 5, 5, 5);
         iAbilityTotal += GetAbilityModifier(ABILITY_CHARISMA, GetPCSpeaker());
         iAbilityTotal += GetAbilityModifier(ABILITY_CONSTITUTION, GetPCSpeaker());
         iAbilityTotal += GetAbilityModifier(ABILITY_DEXTERITY, GetPCSpeaker());
         iAbilityTotal += GetAbilityModifier(ABILITY_INTELLIGENCE, GetPCSpeaker());
         iAbilityTotal += GetAbilityModifier(ABILITY_STRENGTH, GetPCSpeaker());
         iAbilityTotal += GetAbilityModifier(ABILITY_WISDOM, GetPCSpeaker());

         if (iAbilityTotal>30)
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, CurseOfTheExploiter, GetPCSpeaker(), 1800.0);
         AssignCommand(GetPCSpeaker(), JumpToLocation(GetLocation(GetObjectByTag ("FugueMarker"))));

        DestroyObject(GetObjectByTag("Riddler"));
        DestroyObject(GetObjectByTag("InoGong"));
        }
}

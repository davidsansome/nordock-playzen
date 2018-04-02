//::///////////////////////////////////////////////
//:: FileName tucker_did_kob
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/10/2002 6:45:24 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "apts_inc_ptok"
#include "journal_include"
int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "KoboldShamanStaff") && (GetTokenBool(GetPCSpeaker(), "kobold_staff") == 0))
        return TRUE;

    return FALSE;
}

 void main()
{
    object oPC = GetPCSpeaker();
    if(StartingConditional())
    {
        // Give the speaker some XP
        RewardPartyGP(500, oPC);
        RewardPartyXP(600, oPC);

        // Remove items from the player's inventory
        object oItemToTake;
        oItemToTake = GetItemPossessedBy(oPC, "KoboldShamanStaff");
        if(GetIsObjectValid(oItemToTake) != 0)
            DestroyObject(oItemToTake);
        // Set the variables
        SetTokenBool(oPC, "kobold_staff", 1);
        string sSubrace = GetStringLowerCase(GetSubRace(oPC));
        if (sSubrace == "drow")
            dhAddJournalQuestEntry("kobold_staff_drow", 3, oPC, FALSE, FALSE, FALSE, TRUE);
        else if (sSubrace == "duergar")
            dhAddJournalQuestEntry("kobold_staff_duergar", 3, oPC, FALSE, FALSE, FALSE, TRUE);
        else
            dhAddJournalQuestEntry("kobold_staff", 3, oPC, FALSE, FALSE, FALSE, TRUE);
    }
    else
    {
         //Player has attempted an exploit (dropping items after meeting conversation requirements. Insult, curse & kill)
         SetTokenBool(oPC, "kobold_staff", 1);
         int iAbilityTotal = 0;
         effect CurseOfTheExploiter = EffectCurse(5, 5, 5, 5, 5, 5);
         iAbilityTotal += GetAbilityModifier(ABILITY_CHARISMA, oPC);
         iAbilityTotal += GetAbilityModifier(ABILITY_CONSTITUTION, oPC);
         iAbilityTotal += GetAbilityModifier(ABILITY_DEXTERITY, oPC);
         iAbilityTotal += GetAbilityModifier(ABILITY_INTELLIGENCE, oPC);
         iAbilityTotal += GetAbilityModifier(ABILITY_STRENGTH, oPC);
         iAbilityTotal += GetAbilityModifier(ABILITY_WISDOM, oPC);

         SendMessageToPC(oPC, "A curse upon you, do not anger me like this again!");
         if (iAbilityTotal>30)
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, CurseOfTheExploiter, oPC, 1800.0);
         AssignCommand(oPC, JumpToLocation(GetLocation(GetObjectByTag ("FugueMarker"))));
    }
}






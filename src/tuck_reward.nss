//::///////////////////////////////////////////////
//:: FileName tuck_reward
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/29/2002 1:00:21 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "rr_persist"
#include "journal_include"
int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "OrcShamanHead"))
        return FALSE;

    return TRUE;
}

void main()
{
    if(StartingConditional())
        {
        // Give the speaker some gold
    RewardPartyGP(250, GetPCSpeaker());

    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "OrcShamanHead");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    SPI(GetPCSpeaker(), "OrcShamanHeadCompleted", 1);
    dhAddJournalQuestEntry("bloodstainednote", 3, GetPCSpeaker(), FALSE, FALSE, FALSE, TRUE);

        }
    else
        {
         //Player has attempted an exploit (dropping items after meeting conversation requirements. Insult, curse & kill)

         int iAbilityTotal = 0;
         effect CurseOfTheExploiter = EffectCurse(5, 5, 5, 5, 5, 5);
         iAbilityTotal += GetAbilityModifier(ABILITY_CHARISMA, GetPCSpeaker());
         iAbilityTotal += GetAbilityModifier(ABILITY_CONSTITUTION, GetPCSpeaker());
         iAbilityTotal += GetAbilityModifier(ABILITY_DEXTERITY, GetPCSpeaker());
         iAbilityTotal += GetAbilityModifier(ABILITY_INTELLIGENCE, GetPCSpeaker());
         iAbilityTotal += GetAbilityModifier(ABILITY_STRENGTH, GetPCSpeaker());
         iAbilityTotal += GetAbilityModifier(ABILITY_WISDOM, GetPCSpeaker());

         SendMessageToPC(GetPCSpeaker(), "A curse upon you, do not anger me like this again!");
         if (iAbilityTotal>30)
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, CurseOfTheExploiter, GetPCSpeaker(), 1800.0);
         AssignCommand(GetPCSpeaker(), JumpToLocation(GetLocation(GetObjectByTag ("FugueMarker"))));
        }
}




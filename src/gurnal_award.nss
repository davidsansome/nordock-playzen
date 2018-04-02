//::///////////////////////////////////////////////
//:: FileName gurnal_award
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/1/2002 11:12:13 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "apts_inc_ptok"
#include "journal_include"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "sangroluskull"))
        return TRUE;

    return FALSE;
}

void main()
{
    if (StartingConditional())
    {
    // Mark as having completed the quest
    SetTokenBool(GetPCSpeaker(), "LichQuestComplete", 1);
    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "sangroluskull");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);

    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 5000);

    // Give the speaker some XP
    GiveXPToCreature(GetPCSpeaker(), 2500);

    // Give the speaker the items
    CreateItemOnObject("miracleshield", GetPCSpeaker(), 1);
    CreateItemOnObject("miracleblade", GetPCSpeaker(), 1);

    dhAddJournalQuestEntry("lichquest", 2, GetPCSpeaker(), FALSE, FALSE, FALSE, TRUE);
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

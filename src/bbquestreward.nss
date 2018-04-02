//::///////////////////////////////////////////////
//:: FileName bbquestreward
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/16/2002 5:20:17 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "apts_inc_ptok"
#include "journal_include"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "bbquestnote") && (GetTokenBool(GetPCSpeaker(), "denzecht_vendersh") == 0))
        return TRUE;

    return FALSE;
}

void main()
{
    if(StartingConditional())
    {
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 250);

    // Give the speaker some XP
    GiveXPToCreature(GetPCSpeaker(), 250);

    dhAddJournalQuestEntry("denzecht_vendersh", 2, GetPCSpeaker(), FALSE, FALSE, FALSE, TRUE);


    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "bbquestnote");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
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

//::///////////////////////////////////////////////
//:: FileName tuckringreward
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/20/2002 10:44:46 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "apts_inc_ptok"
#include "journal_include"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "CaptainTuckersSignet") && (GetTokenBool(GetPCSpeaker(), "tucker_ring") == 0))
        return TRUE;

    return FALSE;
}

void main()
{
    if(StartingConditional())
        {
            // Remove items from the player's inventory
        object oItemToTake;
        oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "CaptainTuckersSignet");
        if(GetIsObjectValid(oItemToTake) != 0)
            DestroyObject(oItemToTake);

        // Give the speaker some gold
        GiveGoldToCreature(GetPCSpeaker(), 200);

        // Give the speaker some XP
        if (GetHitDice(GetPCSpeaker())<6)
            GiveXPToCreature(GetPCSpeaker(), 150);

        // Give Persistent Token so quest is not repeatable
        SetTokenBool(GetPCSpeaker(), "tucker_ring", 1);
        dhAddJournalQuestEntry("tucker_ring", 3, GetPCSpeaker(), FALSE, FALSE, FALSE, TRUE);
        }
    else
        {
         //Player has attempted an exploit (dropping items after meeting conversation requirements. Insult, curse & kill)
         SetTokenBool(GetPCSpeaker(), "tucker_ring", 1);

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




//::///////////////////////////////////////////////
//:: FileName vhaerun_award2
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/21/2002 1:17:44 PM
//:://////////////////////////////////////////////

#include "nw_i0_tool"
#include "apts_inc_ptok"
#include "journal_include"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "vhaerunsamuletof") && (GetTokenBool(GetPCSpeaker(), "drowquest")==0))
        return TRUE;

    return FALSE;
}


void main()
{
    // Give the speaker the items
    if(StartingConditional())
        {
        // Remove items from the player's inventory
        object oItemToTake;
        oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "vhaerunsamuletof");
        if(GetIsObjectValid(oItemToTake) != 0)
            DestroyObject(oItemToTake);
        // Give the speaker some gold
        GiveGoldToCreature(GetPCSpeaker(), 10000);
        // Give the speaker some XP
        GiveXPToCreature(GetPCSpeaker(), 2500);
        // Give the speaker the items
        CreateItemOnObject("drowtalisman_nod", GetPCSpeaker(), 1);
        // Set the persistent token variable so quest cannot be repeated
        SetTokenBool(GetPCSpeaker(), "drowquest", 1);

    dhAddJournalQuestEntry("drowquest", 6, GetPCSpeaker(), FALSE, FALSE, FALSE, TRUE);
        }
    else
        {
         //Give token to stop repeating the quest
         SetTokenBool(GetPCSpeaker(), "drowquest", 1);
         //Player has attempted an exploit (dropping items after meeting conversation requirements. Insult, curse & kill)
         int iAbilityTotal = 0;
         effect CurseOfTheExploiter = EffectCurse(5, 5, 5, 5, 5, 5);
         iAbilityTotal += GetAbilityModifier(ABILITY_CHARISMA, GetPCSpeaker());
         iAbilityTotal += GetAbilityModifier(ABILITY_CONSTITUTION, GetPCSpeaker());
         iAbilityTotal += GetAbilityModifier(ABILITY_DEXTERITY, GetPCSpeaker());
         iAbilityTotal += GetAbilityModifier(ABILITY_INTELLIGENCE, GetPCSpeaker());
         iAbilityTotal += GetAbilityModifier(ABILITY_STRENGTH, GetPCSpeaker());
         iAbilityTotal += GetAbilityModifier(ABILITY_WISDOM, GetPCSpeaker());

         SendMessageToPC(GetPCSpeaker(), "For your trivialisation of the amulet - I place a curse upon you, do not anger Lloth like this again!");
         if (iAbilityTotal>30)
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, CurseOfTheExploiter, GetPCSpeaker(), 1800.0);
         AssignCommand(GetPCSpeaker(), JumpToLocation(GetLocation(GetObjectByTag ("FugueMarker"))));
        }
}

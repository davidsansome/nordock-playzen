//::///////////////////////////////////////////////
//:: FileName pav_reward
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2002-11-15 22:24:46
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "apts_inc_ptok"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if (!(HasItem(GetPCSpeaker(), "LordTyrmonsSignetRing")))
        return FALSE;

    return TRUE;
}

 void main()
{
    if(StartingConditional())
        {
        // Mark as having completed the quest
        SetTokenBool(GetPCSpeaker(), "PaladinQuestComplete", 1);
        // Give the speaker some gold
        GiveGoldToCreature(GetPCSpeaker(), 5000);
        // Give the speaker some XP
        GiveXPToCreature(GetPCSpeaker(), 2500);
        AdjustAlignment(GetPCSpeaker(), ALIGNMENT_ALL, 15);
        //Remove items from the player's inventory
        object oItemToTake;
        oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "LordTyrmonsSignetRing");
        if(GetIsObjectValid(oItemToTake) != 0)
            DestroyObject(oItemToTake);
        }
    else
        {
         //Player has attempted an exploit (dropping items after meeting conversation requirements. Insult, curse & kill)
         AdjustAlignment(GetPCSpeaker(), ALIGNMENT_ALL, -15);
         int iAbilityTotal = 0;
         effect CurseOfTheExploiter = EffectCurse(5, 5, 5, 5, 5, 5);
         iAbilityTotal += GetAbilityModifier(ABILITY_CHARISMA, GetPCSpeaker());
         iAbilityTotal += GetAbilityModifier(ABILITY_CONSTITUTION, GetPCSpeaker());
         iAbilityTotal += GetAbilityModifier(ABILITY_DEXTERITY, GetPCSpeaker());
         iAbilityTotal += GetAbilityModifier(ABILITY_INTELLIGENCE, GetPCSpeaker());
         iAbilityTotal += GetAbilityModifier(ABILITY_STRENGTH, GetPCSpeaker());
         iAbilityTotal += GetAbilityModifier(ABILITY_WISDOM, GetPCSpeaker());

         SendMessageToPC(GetPCSpeaker(), "I have marked you as a liar, did you truly believe your childish tricks could fool me? A curse upon you!");
         if (iAbilityTotal>30)
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, CurseOfTheExploiter, GetPCSpeaker(), 1800.0);
         AssignCommand(GetPCSpeaker(), JumpToLocation(GetLocation(GetObjectByTag ("FugueMarker"))));
        }
}


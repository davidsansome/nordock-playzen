#include "nw_i0_tool"
#include "apts_inc_ptok"
#include "journal_include"

int StartingConditional()
{
    int iResult;

    iResult = ((HasItem(GetPCSpeaker(),"RuneofPowerSregtur")) && (GetTokenBool(GetPCSpeaker(),"gal_rune_done")==0));
    return iResult;
}

void main()
{
    if (StartingConditional())
    {
        SetTokenBool(GetPCSpeaker(),"galdor_on_mission",1);
        SetTokenBool(GetPCSpeaker(),"gal_rune_done",1);
        object oItemToTake;
        oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "RuneofPowerSregtur");
        if(GetIsObjectValid(oItemToTake) != 0)
            DestroyObject(oItemToTake);
        dhAddJournalQuestEntry("galdor_rune", 2, GetPCSpeaker(), FALSE, FALSE, FALSE, TRUE);
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

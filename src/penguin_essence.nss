#include "rr_persist"
#include "journal_include"

void main()
{
    object oPC = GetPCSpeaker();

    // Remove essence
    int iFound = FALSE;
    object oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem))
    {
        if (GetTag(oItem) == "PenguinEssence")
        {
            DestroyObject(oItem);
            iFound = TRUE;
            break;
        }
        oItem = GetNextItemInInventory(oPC);
    }

    if (iFound != TRUE)
    {
        // Player tried to use an exploit
        int iAbilityTotal = 0;
        effect CurseOfTheExploiter = EffectCurse(5, 5, 5, 5, 5, 5);
        iAbilityTotal += GetAbilityModifier(ABILITY_CHARISMA, oPC);
        iAbilityTotal += GetAbilityModifier(ABILITY_CONSTITUTION, oPC);
        iAbilityTotal += GetAbilityModifier(ABILITY_DEXTERITY, oPC);
        iAbilityTotal += GetAbilityModifier(ABILITY_INTELLIGENCE, oPC);
        iAbilityTotal += GetAbilityModifier(ABILITY_STRENGTH, oPC);
        iAbilityTotal += GetAbilityModifier(ABILITY_WISDOM, oPC);

        SendMessageToPC(GetPCSpeaker(), "A curse upon you, do not anger me like this again!");
        if (iAbilityTotal>30)
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, CurseOfTheExploiter, oPC, 1800.0);
        AssignCommand(oPC, JumpToLocation(GetLocation(GetObjectByTag ("FugueMarker"))));
        return;
    }

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_LIGHTNING_M), GetLocation(OBJECT_SELF));
    PlaySound("as_wt_thundercl3");

    CreateItemOnObject("arcticorb001", oPC);

    SPI(oPC, "LegendaryPenguins", 1);
    dhAddJournalQuestEntry("penguin", 2, GetPCSpeaker(), FALSE, FALSE, FALSE, TRUE);
}

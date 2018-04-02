// * Normal IQ + Is able to level up
#include "cohort_inc"

int StartingConditional()
{
    int iResult;
    // * April 20. this option should not even come up if the henchman is at max levels
    if (GetHitDice(OBJECT_SELF) < 20)
        iResult = (GetAbilityScore(GetPCSpeaker(),ABILITY_INTELLIGENCE) >= 9) && GetCanLevelUp(GetPCSpeaker());
    else
        iResult = FALSE;
    return iResult;
}

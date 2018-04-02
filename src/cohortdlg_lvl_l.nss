//cohort_check39, built from nw_ch_check39
//originally modified by 69MEH69.
//
//Modified by Edward Beck (0100010) for Cohort system on September 1, 2002.
//Renamed in order to maintain independance from Bioware files
//and for easier itegration.

// * Normal IQ + Is able to level up
#include "cohort_inc"

int StartingConditional()
{
    int iResult;
    // * April 20. this option should not even come up if the henchman is at max levels
    if (GetHitDice(OBJECT_SELF) < 20)  //changed to 20
        iResult = (GetAbilityScore(GetPCSpeaker(),ABILITY_INTELLIGENCE) < 9) && GetCanLevelUp(GetPCSpeaker());
    else
        iResult = FALSE;
    return iResult;
}

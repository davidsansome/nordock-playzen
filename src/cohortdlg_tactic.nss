//cohort_tactic2, built from nw_ch_tactic2
//
//Modified by Edward Beck (0100010) for Cohort system on September 2, 2002.
//Renamed in order to maintain independance from Bioware files
//and for easier itegration.

#include "cohort_inc"
// * Is the PCSpeaker
// * the Henchman's master?
int StartingConditional()
{
    return GetRealMaster() == GetPCSpeaker();
}

//cohortdlg_lvlup, built from nw_ch_action17
//
//Modified by Edward Beck (0100010) for Cohort system on September 2, 2002.
//Renamed in order to maintain independance from Bioware files
//and for easier integration.

// * Henchman levels up
/*
    v1.0.6  - Added PW Cohort support. Now saves Cohort state upon level up.
*/

#include "cohort_inc_pw"

void main()
{
    object speaker = GetPCSpeaker();

    DestroyObject(GetAssociate(ASSOCIATE_TYPE_FAMILIAR));
    object oNew = DoLevelUp(speaker);
    if (GetIsObjectValid(oNew) == TRUE)
    {
        ClearAllActions();
        DelayCommand(1.0,EquipAppropriateWeapons(oNew));

    /* persistent world support. */
        if(PWCOHORT)
            PWCohort_SaveState(oNew);
    }
}

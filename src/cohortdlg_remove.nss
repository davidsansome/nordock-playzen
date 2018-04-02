//cohortdlg_remove, built from nw_ch_remove
//
//Modified by Edward Beck (0100010) for Cohort system on September 2, 2002.
//Renamed in order to maintain independance from Bioware files
//and for easier itegration.

/*
    v1.0.6  - Added PW Cohort support. Now saves Cohort state upon un-hiring.

    v1.0.3  added fix for GetRealMaster not working beyond death in HCR 1.8.7
*/
#include "cohort_inc_pw"

void main()
{
    object speaker = GetPCSpeaker();

    SetFormerMaster(speaker, OBJECT_SELF);

    object myMaster = GetMaster();
    RemoveHenchman(myMaster);

    /* Fix by yibble as GetRealMaster does not work after death in 1.8.7 */
    DeleteLocalObject(OBJECT_SELF, "RealMaster");
    /* End of yibble's fix. */

    object myHenchman = GetHenchman();
    if (GetIsObjectValid(myHenchman))
    {
        RemoveHenchman(OBJECT_SELF, myHenchman);
        AddHenchman(myMaster, myHenchman);
    }
    ClearAllActions();

    /* persistent world support. */
    if(PWCOHORT)
        PWCohort_SaveState();
}

//cohortdlg_join, built from nw_ch_join
//
//Modified by Edward Beck (0100010) for Cohort system on September 2, 2002.
//Renamed in order to maintain independance from Bioware files
//and for easier itegration.

/*
    v1.0.6  - Added PW Cohort support. Cohort will record current hit dice
            and will save there current state upon joining.

    v1.0.3  added fix for GetRealMaster not working beyond death in HCR 1.8.7
*/

#include "cohort_inc_pw"
#include "r_hen_command"

void main()
{
    SetAssociateListenPatterns();
    // * Companions, come in, by default with Attack Nearest Enemy && Follow Master modes
    SetLocalInt(OBJECT_SELF,"NW_COM_MODE_COMBAT",ASSOCIATE_COMMAND_ATTACKNEAREST);
    SetLocalInt(OBJECT_SELF,"NW_COM_MODE_MOVEMENT",ASSOCIATE_COMMAND_FOLLOWMASTER);

    object speaker = GetPCSpeaker();
    SetWorkingForPlayer(speaker);
    SetBeenHired();

    object master = speaker;
    while (GetIsObjectValid(GetHenchman(master)) == TRUE)
    {
        master = GetHenchman(master);
    }
    if (master!=OBJECT_SELF)
        AddHenchman(master);

    SetLocalObject(OBJECT_SELF, "RealMaster", speaker);
    if (!GetIsListening(OBJECT_SELF))
        SpeakString("debug: I'm not listening to you!");
    SetAssociateRelayPatterns();

    /* persistent world support. */
    if(PWCOHORT)
        PWCohort_SaveState();
}

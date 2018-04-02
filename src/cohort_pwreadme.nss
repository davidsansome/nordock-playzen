/*
    Persistent World Compatible Cohorts

    If you change the switch PWCOHORT in cohort_inc_vars to TRUE then rebuild your
    module, you will have enabled Persistent World Cohort Support. This system
    utilises PWDB functionality which is already encompassed by HCR.

    Persistent Cohorts act differantly to non-persistent Cohorts in two ways.

    1. They do not require an Emergency Home WayPoint. This is set in conversation by
    their master, and is stored against the module object using the PWDB system
    included with HCR. It is still recommended that you place the COHORT_TOWN_CENTRE_*
    waypoint, as first iteration of a cohort will set their persistent Emergency Home
    location by this.

    2. Cohorts require their state to be saved to be carried accross server restarts.
    Cohort state saves are instigated in conversation to preserve base HCR files.
    You'll most likely want to change this.

    Two new conversation branches which only appear when PWCOHORT = TRUE are

    Yes? What can I do for you?
     |
     +-- I'd like you to take stock of your equipment and take note of your surroundings.
     |   (Used for saving Cohort state to world state.)
     |
     +-- I'd like you to make this spot your base.
         (Used to store a new Emergency Home WayPoint location.)

    Follow the normal PWDB procedure when restarting your NWN server to re-import
    the Cohort state.

    All iterations of the Cohort must have the same tag and the same name, else they
    will not be able to share state data across server restarts!

    Funtioncs included in "cohort_in_pw" are:
        GetOffsetGameDate(Offeset)
        This will be used in later version to set expiry dates on Cohorts... Maybe even
        special events like birthdays etc...

        PWCohort_RestoreState(Cohort)
        This funtion will restore a previously saved state to the Cohort.

        PWCohort_SaveState(Cohort)
        This function will save a Cohort state. You could include this into your
        PWDB_SaveToDatabase() in hc_on_usr_define. This would save Cohort state
        every 15 minutes for those that you include.

        PWCohort_InitState(Cohort)
        This funtion is used upon the first ever Cohort iteration spawn.

    Room for improvement. It shouldn't be hard at all for PW builders to add funtionality
    for storing Cohort state periodically. Or implement ATS so Cohorts can cross modules
    or server with their masters.
*/
void main(){}

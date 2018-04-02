/*  cohort_inc_vars

    Contains variables for modifing the cohort system.
*/

    /* Defines max number of henchman the PC may have. Setting this to zero
    turns the whole system off. */
    int MAXCOHORTS = 1;

    /* Defines how many levels behind the pc the henchman lags Minimum of 0 */
    int COHORTLAG = 1;

    /* Defines the highest level the henchman can be Minimum of 1, Maximum of 20
    cohort lag however will always define the true maximum. */
    int MAXCOHORTLEVEL = 7;

    /* Forces PC to take a Leadership feat (sybolized with the Feat skill focus
    persuade) AND be at least 6th level to be able to hire a cohort. Not that
    at the moment, this is only to detemine if the PC can get a cohort. It does
    not as of yet enfoce the cohort level restrictions according to leadership
    score outlined on table 2-25 of the 3rd Edition Dungeon Master's guide.
    Set this value to true to require the PC to have skill focus persuade (leadership)
    and be at least 6th level to be capable of hiring a cohort.*/
    int USELEADERSHIP = FALSE;

    /* Restrict a PC's ability to hire a cohort based on their and the cohort's
    alignment. The value given represents the number of steps away from the PC's
    alignment the cohort can be and remain hireable. Thus a value of zero means
    zero steps. This requires that the PC and the cohort to have the same alignment.
    A value of one means it is ok to hire a cohort whose alignment differs on either
    axis byt one step. For example, a lawful good PC could hire a lawful good,
    lawful neutral, true neutral, or neutral good cohort. A PC that was true neutral
    could hire a cohort of any alignment. A value of two allows two steps of difference
    between the alignment of the PC and the alignment of the cohort, which makes it
    possible for the PC to hire a cohort of any alignment.*/
    int ALIGNRESTRICT = 2;


    /* REZFEEDBACK = TRUE will provide feedback from the cohort on the progress
    resurrecting the player, (good for debugging.) Set to FALSE to disable. */
    int REZFEEDBACK = TRUE;

    /* REZLEVELLIMIT = TRUE will limit casting of Raise Dead and Resurrection
    scrolls to Level RAISEDEAD_INNATE_LEVEL and RESURRECTION_INNATE_LEVEL
    Clerics respectively, keeping inline with the scrolls innate level. Set to
    FALSE to allow any cohort to cast from these scrolls. */
    int REZLEVELLIMIT = TRUE;

    /* RAISEDEADINNATELEVEL and RESURRECTIONINNATELEVEL should be set to the
    minimum innate caster level required to utilise the relevant scrolls.
    Default is RAISEDEAD_INNATE_LEVEL = 5 and RESURRECTION_INNATE_LEVEL = 7.
    This is ignored if REZLEVELLIMIT = FALSE */
    int RAISEDEAD_INNATE_LEVEL = 5;
    int RESURRECTION_INNATE_LEVEL = 7;

    /* FUGUEPLANETAG = "FuguePlane". Set this to the area tag of the area you
    use for spirits. Default in HCR is "FuguePlane". */
    string FUGUEPLANETAG = "FuguePlane";

    /* CORPSEDISTANCE = 25.0. Set to the perception distance of the Cohort. */
    float CORPSEDISTANCE = 25.0;

    /* PCSEEKLEVEL = 5 & NPCSEEKLEVEL = 9. The cleric levels that a cohort will
    bother when trying to get their masters resurrected. */
    int PCSEEKLEVEL = 5;
    int NPCSEEKLEVEL = 9;

    /* PCREZWAITLIMIT = 10. This is the number of 6 second rounds that a cohort
    will wait once a PC who has offered to help. */
    int PCREZWAITLIMIT = 10;

    /* COHORTTOWNCENTRE = "COHORT_TOWN_CENTRE_". This is the prefix tag of the
    waypoint that your cohort will head towards with their masters body. Good
    idea to make this close to an NPC cleric. The cohorts tag will be
    appended to the end of this to make up the full waypoint tag. e.g. If your cohort
    with a tag of CORIC heads back to town, they will head towards the waypoint
    with the tag "COHORT_TOWN_CENTRE_CORIC". If PWCOHORT = TRUE, the behaviour is
    modifiedd! See cohort_pwreadme for more details.*/
    string COHORTTOWNCENTRE = "COHORT_TOWN_CENTRE_";

    /* PWCOHORT = FALSE. Advance option. If you are running a Persistent World
    you can take advantage of Persistent Cohorts! (just set PWCOHORT = TRUE).
    See cohort_pwreadme for more details. */
    int PWCOHORT = FALSE;

    /* SEEKEMPLOYMENT = FALSE. If set to true, Cohorts that have a local Int of
    SEEKEMPLOYMENT = TRUE will have a random chances of hearing of PCs reputation
    and then will find the PC and actively seek employment. See cohort_ac9 the and
    uncomment the SEEKEMPLOYMENT line. This setting is ignored if USELEADERSHIP
    = FALSE. */
    int SEEKEMPLOYMENT = FALSE;

void SetCohortEmploymentSeek(object oCohort = OBJECT_SELF)
{
    object oModule = GetModule();

    /* *_SEEKEMPLOYMENT = FALSE. When SEEKEMPLOYMENT = TRUE, individual Cohorts
    can be tagged as being able to seek employment or not. The syntax for this
    by adding a string with the Cohorts TAG agglutinated with _SEEKEMPLOYMENT */
    SetLocalInt(oModule, "ALEXA_SEEKEMPLOYMENT", FALSE);
    SetLocalInt(oModule, "KATIE_SEEKEMPLOYMENT", FALSE);
    SetLocalInt(oModule, "MINIRVA_SEEKEMPLOYMENT", FALSE);
    SetLocalInt(oModule, "CINDY_SEEKEMPLOYMENT", FALSE);

    //Do not edit below this line...
    if(GetLocalInt(oModule, GetTag(OBJECT_SELF) + "_SEEKEMPLOYMENT"))
    {
        SetLocalInt(OBJECT_SELF, "SEEKEMPLOYMENT", TRUE);
        SetLocalInt(OBJECT_SELF, "CHANCEEMPLOYMENT", 4);    //Seek chance per round.
    }
}

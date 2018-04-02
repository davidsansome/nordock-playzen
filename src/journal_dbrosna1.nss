#include "journal_include"

void main()
{
    dhAddJournalQuestEntry("duke_unger", 1, GetPCSpeaker(), FALSE);
    AssignCommand (GetObjectByTag("brosnaduke"), ActionSit (GetObjectByTag("dukechair")));
}

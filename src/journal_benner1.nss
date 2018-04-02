#include "journal_include"
#include "rr_persist"

void main()
{
    dhAddJournalQuestEntry("benner", 1, GetPCSpeaker(), FALSE);
    SetLocalInt(GetPCSpeaker(), "InmateBennerQuest", 1);
}

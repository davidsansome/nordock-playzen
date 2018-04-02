#include "nw_i0_tool"
#include "apts_inc_ptok"
#include "journal_include"

void main()
{
    // Set the variables
    SetTokenBool(GetPCSpeaker(), "gurnal_quest_1", 1);
    dhAddJournalQuestEntry("gurnal_quest", 1, GetPCSpeaker(), FALSE);
}

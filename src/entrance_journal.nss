// Script borrowed from Witch's Wake part 1
// Written by Rob Bartel @ BioWare
// Modified and implemented by Jarketh Thavin

void main()
{
    object oEnterer = GetEnteringObject();
    string sPlayerID = GetPCPlayerName(oEnterer) + GetName(oEnterer);
    int bSeenOnce = GetLocalInt(OBJECT_SELF, sPlayerID+"SeenOnce");
    string sString = "Welcome to Richterm's Retreat and the Land of Nordock. "+
                     "Please read the Journal Entries that were just placed "+
                     "in your journal. They outline the Guidelines of being "+
                     "a player at Richterm's Retreat. Have fun!!";

    if (GetIsPC(oEnterer) == TRUE &&
        bSeenOnce == FALSE)
    {
        //Play GUI sound
        AssignCommand(oEnterer, PlaySound("gui_spell_mem"));

        //Have the Player whisper the message to themselves.
        AssignCommand(oEnterer, SpeakString(sString, TALKVOLUME_WHISPER));

        //Flag the player as having seen the message.
        SetLocalInt(OBJECT_SELF, sPlayerID+"SeenOnce", TRUE);
     }
}

// Script borrowed from Witch's Wake part 1
// Written by Rob Bartel @ BioWare
// Modified and implemented by Jarketh Thavin

void main()
{
    object oEnterer = GetEnteringObject();
    string sPlayerID = GetPCPlayerName(oEnterer) + GetName(oEnterer);
    int bSeenOnce = GetLocalInt(OBJECT_SELF, sPlayerID+"BridgeSeenOnce");
    string sString = "You have an overwhelming feeling that there really "+
                     "isn't anything across this bridge. You feel that "+
                     "the Area Designer probably just put it out here for "+
                     "ornamentation and exploration. =)";

    if (GetIsPC(oEnterer) == TRUE &&
        bSeenOnce == FALSE)
    {
        //Play GUI sound
        AssignCommand(oEnterer, PlaySound("gui_spell_erase"));

        //Have the Player whisper the message to themselves.
        AssignCommand(oEnterer, SpeakString(sString, TALKVOLUME_WHISPER));

        //Flag the player as having seen the message.
        SetLocalInt(OBJECT_SELF, sPlayerID+"BridgeSeenOnce", TRUE);
     }
}

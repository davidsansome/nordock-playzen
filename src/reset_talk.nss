void main()
{
object oPC = GetLastUsedBy();
object oMod = GetModule();

    if(GetLocalInt(oMod, "Reset"+GetPCPublicCDKey(oPC))==TRUE)
    {
    SpeakString("You see your name glow a little stronger then fade back into the crystal with the others.", TALKVOLUME_TALK);
    }
    else
    {
    BeginConversation("reset_talk", oPC);
    }
}

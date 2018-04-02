void main()
{
    SetListenPattern(OBJECT_SELF, "**", 888); //listen to all text
    SetListening(OBJECT_SELF, TRUE);          //be sure NPC is listening
    ExecuteScript("bm_scr_onconv", OBJECT_SELF);
}

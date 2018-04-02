
void main()
{
    SpeakString("How much would you like to deposit?");
    SetListenPattern(OBJECT_SELF, "**", 999);
    SetListening(OBJECT_SELF, TRUE);
    SetLocalObject(OBJECT_SELF, "pc_obj", GetPCSpeaker());
}

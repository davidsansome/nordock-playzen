void main()
{
    object oDM = GetPCSpeaker();
    object oListener = CreateObject(OBJECT_TYPE_CREATURE, "ats_listener", GetLocation(oDM), TRUE);
    SetLocalObject(oListener, "ats_sw_activator", oDM);
    SetLocalObject(oDM, "ats_listener", oListener);

    ActionPauseConversation();
}

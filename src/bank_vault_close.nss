void main()
{
        SetLocked(OBJECT_SELF, FALSE);
        SetLocalInt(OBJECT_SELF, "ats_onused", 0 );
        ActionStartConversation( GetLastClosedBy(), "bank_vault_conv", TRUE);
}

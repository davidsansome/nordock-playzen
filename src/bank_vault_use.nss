void main()
{
    object oLastUser = GetLastUsedBy();
    object oCurrentUser =  GetLocalObject(OBJECT_SELF, "ats_current_user");
    string sCurrentUserName =  GetLocalString(OBJECT_SELF, "ats_current_username");

    int iTimesUsed = GetLocalInt(OBJECT_SELF, "ats_onused");

    if(GetLocalObject(oLastUser,"vault_obj") != OBJECT_SELF)
    {
        //Case: Player tries to open the vault while it is already opened by
        //      another player
        FloatingTextStringOnCreature("You cannot open that.", oLastUser, FALSE);
        return;
    }
    else
        ++iTimesUsed;

    if(iTimesUsed == 1)
    {
        //Case: Vault was not in use and has now been opened
        SetLocalObject(OBJECT_SELF, "ats_current_user", oLastUser);
        SetLocalString(OBJECT_SELF, "ats_current_username", GetName(oLastUser));
        SetLocked(OBJECT_SELF, TRUE);
        SetLocalInt(OBJECT_SELF, "ats_onused", iTimesUsed );
    }
    else if(iTimesUsed == 2)
    {
        // Case: Vault has been validly closed
        SetLocked(OBJECT_SELF, FALSE);
        SetLocalInt(OBJECT_SELF, "ats_onused", 0 );
        ActionStartConversation( oLastUser, "bank_vault_conv", TRUE);

    }


}


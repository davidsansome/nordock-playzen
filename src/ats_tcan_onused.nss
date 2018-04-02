void main()
{

    int iTimesUsed = GetLocalInt(OBJECT_SELF, "ats_onused");
    ++iTimesUsed;

    if(iTimesUsed == 2)
    {
        if(GetLocalInt(OBJECT_SELF, "ats_opened") == TRUE)
        {
            iTimesUsed = 1;
            SetLocalInt(OBJECT_SELF, "ats_opened", FALSE);
        }
        else
        {
            iTimesUsed = 0;
            SetLocalInt(OBJECT_SELF, "ats_onused", 0 );
            ActionStartConversation(GetLastUsedBy(), "", TRUE);
        }
    }
    SetLocalInt(OBJECT_SELF, "ats_onused", iTimesUsed );


}

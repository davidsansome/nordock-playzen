void main()
{
    object oForge = OBJECT_SELF;
    if(GetLocked(oForge) == TRUE && GetIsOpen(oForge) == FALSE && IsInConversation(oForge) == FALSE)
    {
        SetLocked(oForge, FALSE);
    }

}

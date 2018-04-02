void main()
{
    object oPC = GetEnteringObject();
    object oOwner = GetLocalObject(OBJECT_SELF,"Owner");

    int IsPC = GetLocalInt(oPC,"IsAPC");
    int pop = GetLocalInt(OBJECT_SELF,"PCPop");

    if(IsPC)
        SetLocalInt(OBJECT_SELF,"PCPop",pop+1);

    if((IsPC && (oOwner == OBJECT_INVALID)) || (oOwner == oPC))
    {
        SetLocalObject(OBJECT_SELF,"Owner",oPC);
        SignalEvent(OBJECT_SELF,EventUserDefined(500));
    }

    return;
}

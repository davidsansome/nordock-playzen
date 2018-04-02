void main()
{
    object oPC = GetExitingObject();
    object oOwner = GetLocalObject(OBJECT_SELF,"Owner");

    int IsPC = GetLocalInt(oPC,"IsAPC");
    int pop = GetLocalInt(OBJECT_SELF,"PCPop");

    if(IsPC)
    {
        pop = pop-1;

        if((pop <= 0))
            pop = 0;

        SetLocalInt(OBJECT_SELF,"PCPop",pop);

        if(pop <= 0)
            DeleteLocalObject(OBJECT_SELF,"Owner");

        if((oOwner == oPC) || (oOwner == OBJECT_INVALID))
            DeleteLocalInt(OBJECT_SELF,"Open");
    }

    return;
}

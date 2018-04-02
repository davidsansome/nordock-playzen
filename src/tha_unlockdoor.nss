void main()
{
    object oPC = GetLastUsedBy();
    object oArea = GetArea(OBJECT_SELF);

    object oOwner = GetLocalObject(oArea,"Owner");


    if(oPC == oOwner)
    {
        int iLock = !GetLocalInt(oArea,"Open");

        if(iLock)
        {
            SpeakString("Front Door unlocked");
            PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        }

        else
        {
            SpeakString("Front Door locked");
            PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        }

        SetLocalInt(oArea,"Open",iLock);
    }
    else
    {
        SpeakString("You are not the owner and cannot lock or unlock the front door.");
    }
}

void main()
{
    object oPC = GetClickingObject();
    object oTarg = GetTransitionTarget(OBJECT_SELF);
    object oArea = GetArea(oTarg);
    object oOwner = GetLocalObject(oArea,"Owner");

    string hSize = GetTag(GetNearestObject(OBJECT_TYPE_PLACEABLE,oTarg));
    string sMessage;

    int CanJumpToHouse = FALSE;


// Housing Security Code to prevent overlapping of people trying to claim one house, and to prevent uninvited guests
// from entering.

    if(oPC == oOwner)
    {
        sMessage = "No one has claimed the house since you left. You may pass!";
        CanJumpToHouse = TRUE;
    }

    else if(oOwner == OBJECT_INVALID)
    {
        if(GetLocalInt(oArea,"PCPop") <= 0)
        {
            if(GetItemPossessedBy(oPC,hSize+"_house_key") != OBJECT_INVALID)
            {
                sMessage = "Whoever claimed this house has logged out, and the building is empty. You may pass!";
                CanJumpToHouse = TRUE;
            }

            else
                sMessage = "Whoever claimed this house has logged out. The building is empty, but you don't have the right key to claim this house!";
        }

        else
            sMessage = "Whoever claimed this house has logged out, but there are still people inside! The door appears to be barred from the inside.";
    }

    else
    {
        if(GetArea(oOwner) != GetArea(oTarg))
        {
            if(GetLocalInt(oArea,"PCPop") <= 0)
            {
                if(GetItemPossessedBy(oPC,hSize+"_house_key") != OBJECT_INVALID)
                {
                    sMessage = "Whoever claimed this house is not inside, and the building is empty. You may pass!";
                    CanJumpToHouse = TRUE;
                }

                else
                    sMessage = "Whoever claimed this house not inside it. The building is empty, but you don't have the correct key to claim this house.";
            }

            else
                sMessage = "Whoever claimed this house is not inside it, but there are still people inside! The door appears to be barred from the inside.";
        }

        else if(GetLocalInt(oArea,"Open"))
        {
            sMessage = "The front door of the house is unlocked. You may enter.";
            CanJumpToHouse = TRUE;
        }

        else
            sMessage = "The door is barred from the inside. You cannot enter uninvited.";
    }

    if(CanJumpToHouse)
    {
        if((GetLocalObject(oArea,"FrontDoor") == OBJECT_INVALID))
            SetLocalObject(oArea,"FrontDoor",OBJECT_SELF);

        if((oOwner == OBJECT_INVALID) || (GetArea(oOwner) != GetArea(oTarg)))
            SetLocalObject(oArea,"Owner",oPC);

        AssignCommand(oPC,JumpToObject(oTarg));
    }

    else
        FloatingTextStringOnCreature(sMessage,oPC,FALSE);
}




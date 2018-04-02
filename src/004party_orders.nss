//::///////////////////////////////////////////////
//:: Have PC Master and Henchman
//:: 004party_orders
//::
//:://////////////////////////////////////////////
/*
    Is my master a PC?
    Do I have a Henchman?

*/
//:://////////////////////////////////////////////
//:: Created By: Implimian
//:: Created On: Aug. 12, 2002
//:://////////////////////////////////////////////
int StartingConditional()
{
    if(GetIsPC(GetMaster()))
    {
        if(GetIsObjectValid(GetHenchman(OBJECT_SELF)))
            return TRUE;
    }
    return FALSE;
}


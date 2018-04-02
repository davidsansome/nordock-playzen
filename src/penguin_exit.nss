void main()
{
    object oArea = GetArea(GetExitingObject());
    object oPC = GetFirstPC();

    int iArea = 1;

    while(oPC != OBJECT_INVALID)
    {
        if((GetArea(oPC) == oArea) && (oPC != GetExitingObject()))
        {
            iArea=0;
            break;
        }
        oPC=GetNextPC();
    }

    object oTrevor = GetObjectByTag("MagicalTrevor");
    SetLocalInt(oTrevor, "TrevorDisabled", iArea);
}

void main()
{
    object oPlayer = GetLastUsedBy ();
    object oChair;
    if (GetIsPC (oPlayer))
    {
        oChair = GetNearestObject (OBJECT_TYPE_PLACEABLE, oPlayer, 0);
        if (GetIsObjectValid(oChair) && !GetIsObjectValid (GetSittingCreature (oChair)))
        {
            AssignCommand (oPlayer, ActionSit (oChair));
        }
    }
}

void main()
{
    object oClicker = GetClickingObject();
    object oTarget = GetTransitionTarget(OBJECT_SELF);
    object oFugue = GetObjectByTag("fuguemarker");
    object oMod = GetModule();

    SetAreaTransitionBMP(AREA_TRANSITION_RANDOM);

    if (GetLocked(GetObjectByTag("HissingBogGate")) == 1)
    {
        // Altered by Grug 25-May-2004 for death variable
        SetLocalInt(oMod, "NCP_DEAD_" + GetPCPublicCDKey(oClicker), 1); // Set the player as dead

        AssignCommand(oClicker, JumpToObject(oFugue));
    }
    else
    {
        AssignCommand(oClicker, JumpToObject(oTarget));
    }
}

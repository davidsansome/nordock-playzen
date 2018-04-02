void main()
{
// get the user
    object oPC = GetLastUsedBy();
    {
// display a floaty text message above the door.
        FloatingTextStringOnCreature("The door cannot be opened from this side!",oPC);
    }
}

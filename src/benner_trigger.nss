void main()
{
    object oPC = GetEnteringObject();

    if (!GetIsPC(oPC))
        return;

    if ((GetLocalInt(oPC, "InmateBennerQuest") == 2) && (GetIsObjectValid(GetLocalObject(oPC, "InmateBenner"))))
    {
        SetLocalInt(oPC, "InmateBennerQuest", 3);

        object oBenner = GetLocalObject(oPC, "InmateBenner");
        AssignCommand(oBenner, SpeakString("Nice work!  Now you need to get the East Wing key from one of these guards to unlock my old cell."));
    }
}

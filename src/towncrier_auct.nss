//::///////////////////////////////////////////////
//:: FileName towncrier_auct
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: EagleC
//:: Created On: 26/08/2004 17:56:53
//:://////////////////////////////////////////////
void main()
{

    // Remove some gold from the player
    TakeGoldFromCreature(10, GetPCSpeaker(), FALSE);
    object oPC=GetPCSpeaker();
    object oArea=GetArea(OBJECT_SELF);

    string sPCName = GetName(oPC);
    string sAreaName = GetName(oArea);

    int iUnderdark = FALSE;
    if (GetResRef(OBJECT_SELF) == "underdarkscreech")
        iUnderdark = TRUE;

    object oTarget = GetFirstPC();

    while (GetIsObjectValid(oTarget)==TRUE)
    {
        string sSubrace = GetStringLowerCase(GetSubRace(oTarget));
        if (iUnderdark)
        {
            if ((sSubrace == "drow") || (sSubrace == "duergar") || GetIsDM(oTarget))
            {
                DelayCommand(5.0, SendMessageToPC(oTarget, "A high-pitched screeching fills your ears..."));
                DelayCommand(10.0, SendMessageToPC(oTarget, sPCName + " will be holding a public auction in " +sAreaName + " in 5 minutes time."));
                DelayCommand(180.0, SendMessageToPC(oTarget, sAreaName + " Auction starting in 2 minutes."));
                DelayCommand(240.0, SendMessageToPC(oTarget, sAreaName + " Auction starting in 1 minutes."));
                DelayCommand(300.0, SendMessageToPC(oTarget, "Auction now starting in " + sAreaName + "."));
            }
        }
        else
        {
            if (((sSubrace != "drow") && (sSubrace != "duergar")) || GetIsDM(oTarget))
            {
                DelayCommand(5.0, SendMessageToPC(oTarget, "'Hear Ye! Hear Ye!', the town crier calls..."));
                DelayCommand(10.0, SendMessageToPC(oTarget, sPCName + " will be holding an open air auction in " +sAreaName + " in 5 minutes time."));
                DelayCommand(180.0, SendMessageToPC(oTarget, sAreaName + " Open Air Auction starting in 2 minutes."));
                DelayCommand(240.0, SendMessageToPC(oTarget, sAreaName + " Open Air Auction starting in 1 minutes."));
                DelayCommand(300.0, SendMessageToPC(oTarget, "Open Air Auction now starting in " + sAreaName + "."));
            }
       }

        oTarget=GetNextPC();
    }
    SetLocalInt(OBJECT_SELF,"iReady", 0);
    DelayCommand(120.0, SetLocalInt(OBJECT_SELF,"iReady", 1));
}

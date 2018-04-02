//::///////////////////////////////////////////////
//:: FileName towncrier_party
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 26/08/2004 17:56:53
//:://////////////////////////////////////////////
void main()
{

    // Remove some gold from the player
    TakeGoldFromCreature(10, GetPCSpeaker(), FALSE);
    object oPC=GetPCSpeaker();
    object oArea=GetArea(OBJECT_SELF);
    int iHD = GetHitDice(oPC);
    string sLowLvl = IntToString(iHD-4);
    string sHighLvl = IntToString(iHD+4);
    if (iHD < 6)
        sLowLvl = "1";

    int iUnderdark = FALSE;
    if (GetResRef(OBJECT_SELF) == "underdarkscreech")
        iUnderdark = TRUE;

    string sPCName = GetName(oPC);
    string sAreaName = GetName(oArea);

    object oTarget = GetFirstPC();

    while (GetIsObjectValid(oTarget)==TRUE)
    {
        string sSubrace = GetStringLowerCase(GetSubRace(oTarget));
        if (iUnderdark)
        {
            DelayCommand(4.0, SendMessageToPC(oTarget, "A high-pitched screeching fills your ears..."));
            DelayCommand(5.0, SendMessageToPC(oTarget, "."));
            DelayCommand(6.0, SendMessageToPC(oTarget, ".."));
            DelayCommand(7.0, SendMessageToPC(oTarget, sPCName + "(" + IntToString(iHD) + ") is looking to challenge a fellow warrior to fair combat in Mulrock's Arena."));
            DelayCommand(12.0, SendMessageToPC(oTarget, "Should you feel up to this challenge " + sPCName + " will meet you there."));
        }
        else
        {
            DelayCommand(4.0, SendMessageToPC(oTarget, "'Hear Ye! Hear Ye!', the town crier calls..."));
            DelayCommand(5.0, SendMessageToPC(oTarget, "."));
            DelayCommand(6.0, SendMessageToPC(oTarget, ".."));
            DelayCommand(7.0, SendMessageToPC(oTarget, sPCName + "(" + IntToString(iHD) + ") is looking to challenge a fellow warrior to fair combat in Mulrock's Arena."));
            DelayCommand(12.0, SendMessageToPC(oTarget, "Should you feel up to this challenge " + sPCName + " will meet you there."));
        }

        oTarget=GetNextPC();
    }

    SetLocalInt(OBJECT_SELF,"iReady", 0);
    DelayCommand(120.0, SetLocalInt(OBJECT_SELF,"iReady", 1));
}

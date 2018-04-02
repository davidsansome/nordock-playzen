//::///////////////////////////////////////////////
//:: Name           qel_exportall
//:: FileName       qel_exportall
//:: Copyright (c) 2003 Richterms' Retreat
//:://////////////////////////////////////////////
/*
      Psuedo Hearbeat script to perform an
            ExportAllCharacters()
      every nPulse seconds
*/
//:://////////////////////////////////////////////
//:: Created By:      Q'el
//:: Created On:      2-Aug-2003
//:://////////////////////////////////////////////
// made polymorph safe, 20-Apr-04, Q'el
// return true if oPC is under a polymorph effect, false otherwise
int GetIsPolymorphed(object oPC)
{
    effect e = GetFirstEffect(oPC);
    while (GetIsEffectValid(e))
    {
        if (GetEffectType(e) == EFFECT_TYPE_POLYMORPH)
            return TRUE;
        e = GetNextEffect(oPC);
    }
    return FALSE;
}
void qel_exportcharacter(object oPC)
{
    // check for a polymorph effect
    if (!GetIsPolymorphed(oPC)) ExportSingleCharacter(oPC);
}
void qel_exportall()
{
    float fPulse = 600.0;
    string sLogEntry = "Export of all characters completed with qel_exportall.";
//  ExportAllCharacters();
    object oPC = GetFirstPC();
    float fDelay;
    while (GetIsObjectValid(oPC))
    {
        fDelay += 0.5;
        DelayCommand(fDelay, qel_exportcharacter(oPC));
        oPC = GetNextPC();
    }
    WriteTimestampedLogEntry(sLogEntry);
    DelayCommand(fPulse, qel_exportall());
}
void main()
{
   qel_exportall();
}


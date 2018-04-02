#include "rr_persist"

int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();

    iResult = GPI(oPC,"mcu_rego");
    return iResult;
}

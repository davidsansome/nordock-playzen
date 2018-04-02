#include "paus_inc_generic"

void main()
{
    ResetHenchmenState();
    SetAssociateState(NW_ASC_MODE_DEFEND_MASTER, FALSE);
    SetAssociateState(NW_ASC_MODE_STAND_GROUND, FALSE);
    DetermineCombatRound();
}


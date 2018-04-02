//::///////////////////////////////////////////////
//:: FileName guard_attack
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/7/2002 9:53:31 AM
//:://////////////////////////////////////////////
#include "nw_i0_generic"

void main()
{

    // Set the faction to hate the player, then attack the player
    SetIsTemporaryEnemy(GetPCSpeaker(), OBJECT_SELF);
    DetermineCombatRound(GetPCSpeaker());
}

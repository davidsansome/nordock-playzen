//::///////////////////////////////////////////////
//:: FileName attack
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/27/2002 10:52:45 AM
//:://////////////////////////////////////////////
#include "nw_i0_generic"

void main()
{

    // Set the faction to hate the player, then attack the player
    SetIsTemporaryEnemy(GetPCSpeaker(), OBJECT_SELF);
    // Adjust Reputation(GetPCSpeaker(), OBJECT_SELF, -100);
    DetermineCombatRound(GetPCSpeaker());
}

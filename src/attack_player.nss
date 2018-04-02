//::///////////////////////////////////////////////
//:: FileName attack_player
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/1/2002 11:19:12 AM
//:://////////////////////////////////////////////
#include "nw_i0_generic"

void main()
{

    // Set the faction to hate the player, then attack the player
    SetIsTemporaryEnemy(GetPCSpeaker(), OBJECT_SELF);
    // Adjust Reputation(GetPCSpeaker(), OBJECT_SELF, -100);
    DetermineCombatRound(GetPCSpeaker());
}

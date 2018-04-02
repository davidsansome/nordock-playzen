//::///////////////////////////////////////////////
//:: FileName drowattack
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/3/2002 11:28:48 PM
//:://////////////////////////////////////////////
#include "nw_i0_generic"

void main()
{

    // Set the faction to hate the player, then attack the player
    SetIsTemporaryEnemy(GetPCSpeaker(), OBJECT_SELF);
    DetermineCombatRound(GetPCSpeaker());
}

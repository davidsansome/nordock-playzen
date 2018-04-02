//::///////////////////////////////////////////////
//:: FileName at_zendar
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/16/2002 10:12:36 PM
//:://////////////////////////////////////////////
#include "nw_i0_generic"

void main()
{

    // Set the faction to hate the player, then attack the player
    SetIsTemporaryEnemy(GetPCSpeaker(), OBJECT_SELF);
    DetermineCombatRound(GetPCSpeaker());
}

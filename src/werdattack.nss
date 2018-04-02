//::///////////////////////////////////////////////
//:: FileName werdattack
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/5/2002 2:48:56 PM
//:://////////////////////////////////////////////
#include "nw_i0_generic"

void main()
{

    // Set the faction to hate the player, then attack the player
    SetIsTemporaryEnemy(GetPCSpeaker(), OBJECT_SELF);
        SetIsTemporaryEnemy(GetPCSpeaker(), GetObjectByTag("fred"));
    DetermineCombatRound(GetPCSpeaker());
}

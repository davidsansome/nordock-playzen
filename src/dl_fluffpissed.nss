//::///////////////////////////////////////////////
//:: FileName dl_fluffpissed
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 19/09/2002 3:47:55 PM
//:://////////////////////////////////////////////
#include "nw_i0_generic"
int oPissed = GetLocalInt(GetPCSpeaker(), "annoyfluff");

void main()
{

    // Set the faction to hate the player, then attack the player
    if (oPissed == 3)
    SetIsTemporaryEnemy(GetPCSpeaker(), OBJECT_SELF);
    DetermineCombatRound(GetPCSpeaker());
    SetLocalInt(GetPCSpeaker(), "annoyfluff", 0);
}

//::///////////////////////////////////////////////
//:: FileName  forge_death
//:://////////////////////////////////////////////
// Destroys Klactog and rewards the players when they deastroy the Elemental forge
//:://////////////////////////////////////////////
//:: Created By: Havack
//:: Created On: 10/20/02 16:30
//:://////////////////////////////////////////////


#include "nw_i0_tool"
#include "apts_inc_ptok"

void main()
{
  //Destroys Klcatog
 object oDestroy;
       oDestroy = GetObjectByTag("Klactog");
         DestroyObject(oDestroy);

            // Give the Deastroyer's party some XP
        RewardPartyXP(1000, GetLastDamager());
        SetTokenInt(GetLastDamager(), "klactog_quest", 1);
}

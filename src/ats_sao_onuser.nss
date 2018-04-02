/****************************************************
  Skinnable Animal(Omnivore) - On User Defined Event
  ats_sah_onuser

  Last Updated: July 30, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is placed on a skinnable omnivore
  animal's OnUserDefined event.

****************************************************/
#include "ats_inc_common"
#include "ats_config"
#include "ats_inc_skill_lc"

void main()
{
    object   oDeadAnimal = OBJECT_SELF; //Get the Dead Animal Object

    int iEventNumber = GetUserDefinedEventNumber();
    int bIsFriend;
    object oPlayer = GetLastPerceived();

    // Avoided using switch statement because of stack underflow bug
    if(iEventNumber == 1007) // NW_FLAG_DEATH_EVENT
    {
       ATS_CreateSkinnableCorpse(oDeadAnimal, CINT_SAO_CORPSE_FADE);
    }
    else if(iEventNumber == 1003) // NW_FLAG_END_COMBAT_ROUND_EVENT
    {
        object oTarget = GetAttackTarget();
        if(GetIsDead(oTarget) == TRUE)
        {
            SetLocalInt(OBJECT_SELF, "ats_ai_hunger", 0);
        }
    }
    else if(iEventNumber == 1004) // ON CONVERSATION
    {
        ActionRandomWalk();
    }
    else if(iEventNumber == 500)
    {
        if(GetLocalInt(oDeadAnimal, "ats_self_destruct") == TRUE)
        {
            object oLootCorpse = GetLocalObject(oDeadAnimal, "ats_oLootCorse");
            DestroyObject(oLootCorpse);
            DelayCommand(1.0f, SetIsDestroyable(TRUE,TRUE,FALSE));
            DelayCommand(1.3f, DestroyObject(oDeadAnimal));
        }
    }
}

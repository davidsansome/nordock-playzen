/****************************************************
  Skinnable Animal(Herbivore) - On User Defined Event
  ats_sah_onuser

  Last Updated: July 30, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is placed on a skinnable herbivore
  animal's OnUserDefined event.

****************************************************/
#include "ats_inc_common"
#include "ats_config"
#include "ats_inc_skill_lc"

void main()
{
    object   oDeadAnimal = OBJECT_SELF; //Get the Dead Animal Object
    int bIsFriend;
    object oPlayer = GetLastPerceived();

    int iEventNumber = GetUserDefinedEventNumber();

    // Avoided using switch statement because of stack underflow bug
    if(iEventNumber == 1007) // NW_FLAG_DEATH_EVENT
    {
       ATS_CreateSkinnableCorpse(oDeadAnimal, CINT_SAH_CORPSE_FADE);
    }

    else if(iEventNumber == 1002) // PERCEIVE EVENT
    {
        bIsFriend = GetClassByPosition(1,oPlayer);
        if(GetIsPC(oPlayer) &&
           bIsFriend != CLASS_TYPE_DRUID && bIsFriend != CLASS_TYPE_RANGER)
        {
            ClearAllActions();
            ActionMoveAwayFromObject(oPlayer,TRUE,50.0f);
            ActionRandomWalk();
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

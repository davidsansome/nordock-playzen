/****************************************************
  Action Taken Script : Train Blacksmith
  ats_at_train_bs

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script belongs to the conversation file for
  the master blacksmith npc.  It is used to train
  a player in the basics of blacksmithing.
****************************************************/
#include "ats_inc_common"
#include "ats_const_skill"
#include "ats_const_common"
#include "ats_const_recipe"
#include "ats_config"
#include "ats_inc_skill"

void main()
{
    object oPlayer = GetPCSpeaker();

    object oBook = CreateItemOnObject("ats_book_smith1");
    ActionGiveItem(oBook, oPlayer);
    ATS_RaiseTradeskill(oPlayer, CSTR_SKILLNAME_BLACKSMITHING, 5);

}

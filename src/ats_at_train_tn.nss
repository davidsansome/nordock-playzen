/****************************************************
  Action Taken Script : Train Tanning
  ats_at_train_lc

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script belongs to the conversation file for
  the master tanner npc.  It is used to train
  a player in the basics of tanning.
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

    object oBook = CreateItemOnObject("ats_book_tanning");
    ActionGiveItem(oBook, oPlayer);
    ATS_RaiseTradeskill(oPlayer, CSTR_SKILLNAME_TANNING, 5);

}

/****************************************************
  Action Taken Script : Train Fletching
  ats_at_train_jc

  Last Updated: 25 August 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)
    Assisted by Pelemele Malef'carum (Shawn Perreault)

  This script belongs to the conversation file for
  the master Fletcher npc.  It is used to train
  a player in the basics of Fletching.
***************************************************/
#include "ats_inc_common"
#include "ats_const_skill"
#include "ats_const_common"
#include "ats_const_recipe"
#include "ats_config"
#include "ats_inc_skill"

void main()
{
    object oPlayer = GetPCSpeaker();

    if(GetItemPossessedBy(oPlayer, "ATS_BOOK_FL_BW") == OBJECT_INVALID)
    {
        object oBook = CreateItemOnObject("ats_book_fl_bw");
        ActionGiveItem(oBook, oPlayer);
    }
    ATS_RaiseTradeskill(oPlayer, CSTR_SKILLNAME_FLETCHING, 5);

}

/****************************************************
  Action Taken Script : Train Jewelcrafting
  ats_at_train_jc

  Last Updated: 25 August 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)
    Assisted by Pelemele Malef'carum (Shawn Perreault)

  This script belongs to the conversation file for
  the master Jewelcrafter npc.  It is used to train
  a player in the basics of jewelcrafting.
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

    if(GetItemPossessedBy(oPlayer, "ATS_BOOK_GC_JC") == OBJECT_INVALID)
    {
        object oBook = CreateItemOnObject("ats_book_gc_jc");
        ActionGiveItem(oBook, oPlayer);
    }
    ATS_RaiseTradeskill(oPlayer, CSTR_SKILLNAME_JEWELCRAFTING, 1);

}

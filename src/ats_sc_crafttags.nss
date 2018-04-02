/****************************************************
  Starting Condition Script : Craft Tags
  ats_sc_cr_crafttags

  Last Updated: July 20, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is responsible for resetting the craft
  tag.  This is neccessary in order to display the
  list of items that can be made in the conversation
  menu.
****************************************************/
#include "ats_inc_menu"

int StartingConditional()
{
    object oPlayer = GetPCSpeaker();
    ATS_ResetCraftItemDisplayList(oPlayer);
    ATS_InitDisplayCount(oPlayer);
    int iCurrentIndex = ATS_GetCraftArrayIndex(oPlayer);
    SetLocalInt(oPlayer, "ats_start_craft_arrayindex", iCurrentIndex);

    return TRUE;
}

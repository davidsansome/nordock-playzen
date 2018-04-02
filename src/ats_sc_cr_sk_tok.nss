/****************************************************
  Starting Condition Script : Create skill custom
  conversation tokens for crafting menu
  ats_sc_cr_sk_tok

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is responsible for creating the custom
  tokens with a player's tradeskill values.
****************************************************/

#include "ats_const_skill"
#include "ats_inc_common"

int StartingConditional()
{
    object oPlayer = GetPCSpeaker();

    SetCustomToken(55001, IntToString(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_ARMORCRAFTING)));
    SetCustomToken(55002, IntToString(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_BLACKSMITHING)));
    SetCustomToken(55003, IntToString(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_MINING)));
    SetCustomToken(55004, IntToString(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_WEAPONCRAFTING)));
    SetCustomToken(55005, IntToString(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_TANNING)));
    SetCustomToken(55006, IntToString(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_GEMCUTTING)));
    SetCustomToken(55007, IntToString(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_JEWELCRAFTING)));
    SetCustomToken(55008, IntToString(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_BOWYERING)));
    SetCustomToken(55009, IntToString(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_FLETCHING)));
    SetCustomToken(55011, IntToString(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_TINKER)));
    SetCustomToken(55010, IntToString(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_TAILOR)));

    return TRUE;
}
